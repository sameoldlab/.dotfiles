
import GLib from 'gi://GLib'
import Gio from 'gi://Gio'

type AsyncIPC = {
	child: Gio.Subprocess
	stdout: Gio.DataInputStream 
	stdin: Gio.DataOutputStream 
	cancellable: Gio.Cancellable 
}

function start() {
	let cancellable = new Gio.Cancellable()
	let child: Gio.Subprocess | null
	try {
		child = new Gio.SubprocessLauncher({
			flags: Gio.SubprocessFlags.STDIN_PIPE | Gio.SubprocessFlags.STDOUT_PIPE,
		}).spawnv(['pop-launcher'])

	} catch (error) {
		console.error(`spawn failed: ${error}`)
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

export class LauncherService extends Service{
	static {
		Service.register(
			this,
			{},
			{}
		)
	}

	service: AsyncIPC

	constructor(

		service: AsyncIPC,
		callback: (response: JsonIPC.Response) => void
	) {
		super()

		this.service = service


		/** Recursively registers an intent to read the next line asynchronously  */
		const generator = (stdout: Gio.DataInputStream, res: any) => {	
			try {
				const [bytes] = stdout.read_line_finish(res)
				if (bytes) {
					const string = new TextDecoder().decode(bytes)

					// console.log(`received response from launcher service: ${string.split('},{')}`)
					callback(JSON.parse(string))
					this.service.stdout.read_line_async(
						0,
						this.service.cancellable,
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

		this.service.stdout.read_line_async(0, this.service.cancellable, generator)

	}

	activate(id: number) {
		this.send({ Activate: id })
	}

	activate_context(id: number, context: number) {
		this.send({ ActivateContext: { id, context } })
	}

	complete(id: number) {
		this.send({ Complete: id })
	}

	context(id: number) {
		this.send({ Context: id })
	}

	exit() {
		this.send('Exit')
		this.service.cancellable.cancel()
		const service = this.service

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

	query(search: string) {
		this.send({ Search: search })
	}

	quit(id: number) {
		this.send({ Quit: id })
	}

	select(id: number) {
		this.send({ Select: id })
	}

	send(object: Object) {
		const message = JSON.stringify(object)
		console.log('launcherIPC l140 message = ' + message)
		try {
			this.service.stdin.write_all(message + '\n', null)
		} catch (why) {
			console.error(`failed to send request to pop-launcher: ${why}`)
		}
	}
}


const ipc = start()
let Launcher = ipc ? new LauncherService(ipc, (response: JsonIPC.Response) => {
	if ('Close' === response) {
		// this.close()
	} else if ('Update' in response) {
		console.log('response: ' + response)
		console.log(response.Update[0])
	} else {
		console.log(JSON.stringify(response))
	}
}) : null

export default Launcher


/** Launcher types transmitted across the wire as JSON. */
export namespace JsonIPC {
	export interface SearchResult {
		id: number
		name: string
		description: string
		icon?: IconSource
		category_icon?: IconSource
		window?: [number, number]
	}

	export type IconSource = IconV.Name | IconV.Mime | IconV.Window

	namespace IconV {
		export interface Name {
			Name: string
		}

		export interface Mime {
			Mime: string
		}

		export interface Window {
			Window: [number, number]
		}
	}

	export type Response =
		| ResponseV.Update
		| ResponseV.Fill
		| ResponseV.Close
		| ResponseV.DesktopEntryR
		| ResponseV.Context

	namespace ResponseV {
		export type Close = 'Close'

		export interface Context {
			Context: {
				id: number
				options: Array<ContextOption>
			}
		}

		export interface ContextOption {
			id: number
			name: string
		}

		export interface Update {
			Update: Array<SearchResult>
		}

		export interface Fill {
			Fill: string
		}

		export interface DesktopEntryR {
			DesktopEntry: DesktopEntry
		}
	}

	export interface DesktopEntry {
		path: string
		gpu_preference: GpuPreference
	}

	export type GpuPreference = 'Default' | 'NonDefault'
}
