import Service from 'resource:///com/github/Aylur/ags/service.js'
import { exec, execAsync } from 'resource:///com/github/Aylur/ags/utils.js'

class NetworkService extends Service {
	// every subclass of GObject.Object has to register itself
	static {
		// takes three arguments
		// the class itself
		// an object defining the signals
		// an object defining its properties
		Service.register(
			this,
			{
				// 'name-of-signal': [type as a string from GObject.TYPE_<type>],
				'screen-changed': ['float'],
				'is-connected': ['boolean'],
			},
			{
				// 'kebab-cased-name': [type as a string from GObject.TYPE_<type>, 'r' | 'w' | 'rw']
				// 'r' means readable
				// 'w' means writable
				// guess what 'rw' means
				'is-connected': ['boolean', 'r'],
			}
		)
	}
	#screen = null

	#currentNetwork = null

	// the getter has to be in snake_case
	get current_network() {
		return this.#currentNetwork
	}

	// the setter has to be in snake_case too
	set screen_value(percent) {

		execAsync(`brightnessctl s ${percent * 100}% -q`)
			.then(() => {
				this.#screen = percent

				// signals has to be explicity emitted
				// this.emit('changed') // emits "changed"
				// this.notify('screen-value') // emits "notify::screen-value"

				// or use Service.changed(propName: string) which does the above two
				this.changed('screen-value');
			})
			.catch(print)
	}

	constructor() {
		super()
		const current = Number(exec('brightnessctl g'))
		const max = Number(exec('brightnessctl m'))
		this.screen_value = current / max
	}

	// overwriting the connect method, let's you
	// change the default event that widgets connect to
	connect(event = 'screen-changed', callback) {
		return super.connect(event, callback)
	}
}

// the singleton instance
const service = new NetworkService()

// make it global for easy use with cli
globalThis.network = service

// export to use in other modules
export default service
