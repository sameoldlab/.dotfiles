import GLib from 'gi://GLib'
import Gio from 'gi://Gio'
import Gtk from '../../types/@girs/gtk-3.0/gtk-3.0'

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

	#service: Gio.Subprocess
	#ipcResponse: JsonIPC.Response | null = null

	get ipc_response() {
		return this.#ipcResponse
	}

	constructor(widget: Gtk.Widget | undefined) {
		super()

		this.#service = Utils.subprocess(
			['pop-launcher'],
			(stdout) => {
				// console.log(stdout)	
				this.#onResponse(stdout)
			},
			(stderr) => console.error('problem in stream: ', stderr),
			widget
		)
	}

	#onResponse(response: string) {
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
		// this.#service.cancellable.cancel()
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
			this.#service.write(message + '\n')
		} catch (why) {
			console.error(`failed to send request to pop-launcher: ${why}`)
		}
	}
}

/** 
 * TODO: move subprocess to somewhere it can be bound to components. Without this changes to desktop entries or installed applications will not register unless ags is restarted
 *
 */ 
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
