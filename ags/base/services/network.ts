import Service from 'resource:///com/github/Aylur/ags/service.js'
import { exec, execAsync } from 'resource:///com/github/Aylur/ags/utils.js'

const STRENGTH_ICONS = [
	'network-wireless-signal-none-symbolic',
	'network-wireless-signal-weak-symbolic',
	'network-wireless-signal-ok-symbolic',
	'network-wireless-signal-good-symbolic',
	'network-wireless-signal-excellent-symbolic',
]
const iwd = () => {
	const IWD = 'iwctl'
	const { exec } = Utils
	/** Remove table header and escape characters */
	const clean = `tail -n +5 \
	| sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g;/^\s*$/d"`

	const devices = () =>
		exec(`${IWD} device list \
	| ${clean}\
	| awk '{print  $1`).split('\n')
	const defaultInterface = devices()[0]

	// Might be smarter to start iwctl (interactive mode) as a subprocess(?) and get the output of station show from there where it's live updating?

	const station = (device = devices()[0]) => {
		const req = `${IWD} station ${device}`
		return {
			/** list devices in station mode */
			list: `${IWD} station list | ${clean}`,
			/** show station info */
			show: (): IWDStationState =>
				JSON.parse(
					exec(`${req} show 
		| ${clean} \
		| sd '   +' '|' \
		| awk -F "|" 'BEGIN {print "{"}; {print "\""$2"\": \""$3"\","} END {print"\"eof\":0}"}'
		`)
				),
			get_networks: () => {
				const str = exec(`${req} get-networks \
			| grep psk | sd '\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]' '  '\
			| sd '>' ' ' \
			| sd '  +' '|' \ 
			| awk -F "|" '{print "{\"name\":\""$2"\", \"signal\":"length($4)"}"}'`)
				const networks: Array<IWDStationNetwork> = str
					.split('\n')
					.map(s => JSON.parse(s))
				networks.sort((a, b) => a.signal - b.signal)
				return networks
			},
			/**
			 * Scan for networks.
			 * Note!: does not return scanned networks on it's own.
			 * Call `get_networks` after this to get an array of available networks
			 */
			scan: () => {
				exec(`${req} scan`)
			},
			/** Disconnect from current network */
			disconnect: () => {
				exec(`${req} disconnect`)
			},
			/**
			 * Connect to a given network
			 * currently assumes you have authenticated with this network in the past
			 * @param network name of network to connect to
			 */
			connect: (network: string) => {
				exec(`${req} connect ${network}`)
			},
		}
	}

	// const known = (network) => {list(), forget(), show(), set(name, value)}

	return {
		devices,
		station,
	}
}
type IWDDevice = {
	name: string
	address: string
	powered: 'on' | 'off'
	adapter: string
	mode: 'station' | string
}
type IWDStationNetwork = {
	name: string
	signal: 1 | 2 | 3 | 4
}
type IWDStationState =
	| {
			Scanning: 'no' | 'yes'
			State: 'disconnected'
	  }
	| {
			'Scanning': 'no'
			'State': 'connecting'
			'Connected network': String
	  }
	| {
			'Scanning': 'no' | 'yes'
			'State': 'connected'
			'Connected network': String
			'IPv4 address': String
			'ConnectedBss': String
			'Frequency': String
			'Channel': String
			'Security': String
			'RSSI': String
			'AverageRSSI': String
			'RxMode': String
			'RxMCS': String
			'TxMode': String
			'TxMCS': String
			'TxBitrate': String
			'RxBitrate': String
	  }


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
