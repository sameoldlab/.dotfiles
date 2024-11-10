import GObject, { register, signal } from "astal/gobject"
import { Gio, GLib } from 'astal'
import { subprocess } from 'astal/process'

@register({ GTypeName: "Spring" })
export default class Spring extends GObject.Object {
	static instance: Spring
	static get_default() {
		if (!this.instance) this.instance = new Spring();
		return this.instance;
	}

	@signal(Object)
	declare ipc_response: (event: Object) => void

	@signal(Object)
	declare close: (event: boolean) => void

	private _service: Gio.Subprocess
	private _ipcResponse: JsonIPC.Response | null = null

	constructor() {
		super()

		this._service = subprocess(
			['bash', '-c', 'cd && pop-launcher'],
			(stdout) => {
				// console.log(stdout)	
				this._onResponse(stdout)
			},
			(stderr) => console.error('problem in stream: ', stderr),
		)
	}

	private _onResponse(response: string) {
		// console.log("type of message is:", response)
		if (typeof response === 'string' && response.indexOf('Close') !== -1) {
			this.emit('close', true)
		} else {
			this.emit('ipc-response', JSON.parse(response))
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
		console.log('COMPLETE', id)
		this.#send({ Complete: id })
	}

	/** Request to end the service */
	exit() {
		this.#send('Exit')
		// this.#service.cancellable.cancel()
		const service = this._service

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

	private #send(object: Object) {
		const message = JSON.stringify(object)
		// console.info('launcherIPC send() message = ' + message)
		try {
			this._service.write(message + '\n')
		} catch (why) {
			console.error(`failed to send request to pop-launcher: ${why}`)
		}
	}
}

/** 
 * TODO: move subprocess to somewhere it can be bound to components. Without this changes to desktop entries or installed applications will not register unless ags is restarted
 *
 */
// const launcher = new LauncherService()


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
