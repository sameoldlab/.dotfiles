import GLib from 'gi://GLib'
import Gio from 'gi://Gio'

type AsyncIPC = {
	child: Gio.Subprocess
	stdout: Gio.DataInputStream
	stdin: Gio.DataOutputStream
	cancellable: Gio.Cancellable
}

export function start() {
	let cancellable = new Gio.Cancellable()
	let child: Gio.Subprocess | null
	try {
		child = new Gio.SubprocessLauncher({
			flags: Gio.SubprocessFlags.STDIN_PIPE | Gio.SubprocessFlags.STDOUT_PIPE,
		}).spawnv(['pop-launcher'])
	} catch (error) {
		throw Error(`spawn failed: ${error}`)
	}

	let stdin = new Gio.DataOutputStream({
		base_stream: child.get_stdin_pipe(),
		close_base_stream: true,
	})

	let stdout = new Gio.DataInputStream({
		base_stream: child.get_stdout_pipe(),
		close_base_stream: true,
	})

	child.wait_async(null, (source: any, res: any) => {
		source.wait_finish(res)
		cancellable.cancel()
	})

	return { child, stdin, stdout, cancellable }
}

export function async_process_ipc(argv: Array<string>): AsyncIPC | null {
	const { SubprocessLauncher, SubprocessFlags } = Gio

	const launcher = new SubprocessLauncher({
		flags: SubprocessFlags.STDIN_PIPE | SubprocessFlags.STDOUT_PIPE,
	})

	let child: Gio.Subprocess | null

	let cancellable = new Gio.Cancellable()

	try {
		child = launcher.spawnv(argv)
	} catch (why) {
		console.error(`failed to spawn ${argv}: ${why}`)
		return null
	}

	let stdin = new Gio.DataOutputStream({
		base_stream: child.get_stdin_pipe(),
		close_base_stream: true,
	})

	let stdout = new Gio.DataInputStream({
		base_stream: child.get_stdout_pipe(),
		close_base_stream: true,
	})

	child.wait_async(null, (source: any, res: any) => {
		source.wait_finish(res)
		cancellable.cancel()
	})

	return { child, stdin, stdout, cancellable }
}

export class LauncherService extends Service {
	static {
		Service.register(
			this,
			{
				'new-response': ['jsobject'],
				'close': ['boolean'],
			},
			{
				'ipc-response': ['jsobject', 'r'],
			}
		)
	}

	#service: AsyncIPC = start()
	#ipcResponse: JsonIPC.Response | null = null

	get ipc_response() {
		return this.#ipcResponse
	}

	constructor() {
		super()

		/** Recursively registers an intent to read the next line asynchronously  */
		const generator = (stdout: Gio.DataInputStream, res: any) => {
			try {
				const [bytes] = stdout.read_line_finish(res)
				if (bytes) {
					const string = new TextDecoder().decode(bytes)

					// console.log(`received response from launcher service: ${string.split('},{')}`)
					this.#onResponse(string)

					this.#service.stdout.read_line_async(
						0,
						this.#service.cancellable,
						generator
					)
				}
			} catch (why) {
				// Do not print an error if it was merely cancelled.
				if ((why as any).matches(Gio.IOErrorEnum, Gio.IOErrorEnum.CANCELLED)) {
					return
				}

				console.error(`failed to read response from launcher service: ${why}`)
			}
		}

		this.#service.stdout.read_line_async(
			0,
			this.#service.cancellable,
			generator
		)
	}

	#onResponse(response: JsonIPC.Response) {
		// console.log("type of message is:", response)
		if (typeof response === 'string' && response.includes('Close')) {
			this.emit('close', true)
		} else {
			this.#ipcResponse = JSON.parse(response)
			this.changed('ipc-response')
			this.emit('new-response', this.#ipcResponse)
		}
	}

	/** Activate on the selected item */
	activate(id: number) {
		this.#send({ Activate: id })
	}

	/** Activate a context item on an item. */
	activate_context(id: number, context: number) {
		this.#send({ ActivateContext: { id, context } })
	}

	/** Request for any context options this result may have. */
	context(id: number) {
		this.#send({ Context: id })
	}

	/** Perform a tab completion from the selected item */
	complete(id: number) {
		this.#send({ Complete: id })
	}

	/** Request to end the service */
	exit() {
		this.#send('Exit')
		this.#service.cancellable.cancel()
		const service = this.#service

		GLib.timeout_add(GLib.PRIORITY_DEFAULT, 100, () => {
			if (service.stdout.has_pending() || service.stdin.has_pending())
				return true

			const close_stream = (stream: any) => {
				try {
					stream.close(null)
				} catch (why) {
					console.error(`failed to close pop-launcher stream: ${why}`)
				}
			}

			close_stream(service.stdin)
			close_stream(service.stdin)

			// service.child.send_signal(15)

			return false
		})
	}

	interrupt() {
		this.#send('Interrupt')
	}

	/** Perform a search in our database */
	search(search: string) {
		return this.#send({ Search: search })
	}

	/** Request to close the selected item */
	quit(id: number) {
		this.#send({ Quit: id })
	}

	/** Activate on the selected item */
	select(id: number) {
		this.#send({ Select: id })
	}

	#send(object: Object) {
		const message = JSON.stringify(object)
		console.info('launcherIPC send() message = ' + message)
		try {
			this.#service.stdin.write_all(message + '\n', null)
		} catch (why) {
			console.error(`failed to send request to pop-launcher: ${why}`)
		}
	}
}

const launcher = new LauncherService()

export default launcher

/** Launcher types transmitted across the wire as JSON. */
export namespace JsonIPC {
	export type SearchResult = {
		id: number
		name: string
		description: string
		icon?: Icon
		category_icon?: Icon
	}
	export type Icon = { Name: string } | { Mime: string }
	//|		window?: [number, number]
	export type Response =
		| ResponseV.Update
		| ResponseV.Fill
		| ResponseV.Close
		| ResponseV.DesktopEntry
		| ResponseV.Context

	export namespace ResponseV {
		export type Close = 'Close'

		export type Context = {
			/** Additional options for launching a certain item */
			Context: {
				id: number
				options: ContextOption[]
			}
		}
		type ContextOption = {
			id: number
			name: string
		}

		export type Update = {
			/**  The frontend should clear its search results and display a new list */
			Update: SearchResult[]
		}

		export type Fill = {
			/** An item was selected that resulted in a need to autofill the launcher */
			Fill: string
		}

		export type DesktopEntry = {
			/** Notifies that a .desktop entry should be launched by the frontend. */
			DesktopEntry: {
				path: string
				gpu_preference: 'Default' | 'NonDefault'
			}
		}
	}
}
