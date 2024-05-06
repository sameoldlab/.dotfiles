import Service from 'resource:///com/github/Aylur/ags/service.js'
import { exec } from 'resource:///com/github/Aylur/ags/utils.js'
import { interval } from 'resource:///com/github/Aylur/ags/utils/timeout.js'
import Gio from 'gi://Gio'

const STRENGTH_ICONS = [
	'network-wireless-signal-none-symbolic',
	'network-wireless-signal-weak-symbolic',
	'network-wireless-signal-ok-symbolic',
	'network-wireless-signal-good-symbolic',
	'network-wireless-signal-excellent-symbolic',
]
// const systemConnection = Gio.DBus.system.get_p;
/* https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree */
const iwdKnownNetworkInterface = `<node>
<interface name="net.connman.iwd.KnownNetwork">
	<method name="Forget"></method>
	<property name="Name" type="s" access="read"/>
	<property name="Type" type="s" access="read"/>
	<property name="Hidden" type="b" access="read"/>
	<property name="AutoConnect" type="b" access="readwrite"/>
	<property name="LastConnectedTime" type="s" access="read"/>
</interface>
</node>`
const iwdNetworkInterface = `<node>
<interface name="net.connman.iwd.Network">
	<method name="Connect"></method>
	<property name="Name" type="s" access="read"/>
	<property name="Connected" type="b" access="read"/>
	<property name="Device" type="o" access="read"/>
	<property name="Type" type="s" access="read"/>
	<property name="KnownNetwork" type="o" access="read"/>
</interface>
</node>`
const iwdStationInterface = `<node>
<interface name="net.connman.iwd.Station">
<method name="ConnectHiddenNetwork">
	<arg name="name" type="s" direction="in"/>
</method>
<method name="Disconnect"/>
<method name="GetOrderedNetworks">
	<arg name="networks" type="a(on)" direction="out"/>
</method>
<method name="GetHiddenAccessPoints">
	<arg name="accesspoints" type="a(sns)" direction="out"/>
</method>
<method name="Scan"/>
<method name="RegisterSignalLevelAgent">
	<arg name="path" type="o" direction="in"/>
	<arg name="levels" type="an" direction="in"/>
</method>
<method name="UnregisterSignalLevelAgent">
	<arg name="path" type="o" direction="in"/>
</method>
<property name="ConnectedNetwork" type="o" access="read"/>
<property name="Scanning" type="b" access="read"/>
<property name="State" type="s" access="read"/>
</interface>
</node>`
const StationWrapper = Gio.DBusProxy.makeProxyWrapper(iwdStationInterface)
const NetworkWrapper = Gio.DBusProxy.makeProxyWrapper(iwdNetworkInterface)
let stationProxy: Gio.DBusProxy | null = null
let connectedProxy: Gio.DBusProxy | null = null

try {	stationProxy = StationWrapper(Gio.DBus.system, 'net.connman.iwd','/net/connman/iwd/0/3'	)
} catch (why) {	console.error('Proxy Construction failed: ', why)}

stationProxy?.connect('g-properties-changed', (proxy, changed, invalidated) => {
	// UnregisterSignalLevelAgent
	// RegisterSignalLevelAgent
	try {
		const connectedObject = stationProxy.ConnectedNetwork
		if(connectedObject === null) return
		connectedProxy = NetworkWrapper(
			Gio.DBus.system,
			'net.connman.iwd',
			connectedObject
	)
	console.log(connectedProxy.Name)
} catch(e) {
	console.log(e)
}
})
// track signal_strength: /net/connman/iwd/0/3 [Signal] Changed ?? in docs need to register first?
// stationProxy.ScanSync()
let networks = stationProxy.GetOrderedNetworksSync()
/*  Array[[
        [
            "/net/connman/iwd/0/3/41697274656c5f34475f534d415254424f585f39444438_psk",
            -3900
        ],
        [
            "/net/connman/iwd/0/3/4d544e48794e6574666c657820322e3447687a_psk",
            -8500
        ]
		]]
		nested [].0: Network[] which has a connect method
		0.map(n => NetworkWrapper(Gio.DBus.system, 'net'connman.iwd', n.0))
*/


// stationProxy.ConnectAsync()
stationProxy?.connectSignal('Changed', (_proxy, nameOwner, args) => {
	console.log(nameOwner)
	console.log(args[0])
})
/* stationProxy.GetOrderedNetworks('', (returnValue, errorObj, fdList) => {
	// If @errorObj is `null`, then the method call succeeded and the variant
	// will already be unpacked with `GLib.Variant.prototype.deepUnpack()`
	if (errorObj === null) {
			console.log(`ComplexMethod('input string'): ${returnValue}`);

			if (fdList !== null) {
					// Methods that return file descriptors are fairly rare, so you
					// will know if you should expect one or not. Consult the API
					// documentation for `Gio.UnixFDList` for more information.
			}

			// If you were wrapping this function call in a Promise, this is where
			// you would call `resolve()`

	// If there was an error, then @returnValue will be an empty list and
	// @errorObj will be an Error object
	} else {
			logError(errorObj);

			// If you were wrapping this function call in a Promise, this is where
			// you would call `reject()`
	}
});
 */

const IWD = 'iwctl'

const iwd = {
	devices: () => exec(`${App.configDir}/scripts/get_device.sh`).split('\n'),

	// Might be smarter to start iwctl (interactive mode) as a subprocess(?) and get the output of station show from there where it's live updating?

	station: device => {
		const req = `${IWD} station ${device}`
		// console.log(req)

		const scan = () => exec(`${req} scan`)

		const show = (): IWDStationState =>
			JSON.parse(exec(`${App.configDir}/scripts/iwd_show.sh ${device}`))

		const get_networks = () => {
			scan()
			const str = exec(`${App.configDir}/scripts/get_networks.sh ${device}`)
			if (str === '') return null

			const networks: Array<IWDStationNetwork> = str
				.split('\n')
				.map(s => JSON.parse(s))
			networks.sort((a, b) => a.signal - b.signal)
			return networks
		}

		return {
			/** show station info */
			show,
			get_networks,
			/**
			 * Scan for networks.
			 * Note: does not return scanned networks on it's own.
			 * use `get_networks` instead for an array of available networks
			 */
			scan,
			/** Disconnect from current network */
			disconnect: () => exec(`${req} disconnect`),
			/**
			 * Connect to a given network
			 * currently assumes you have authenticated with this network in the past
			 * @param network name of network to connect to
			 */
			connect: (network: string) => exec(`${req} connect ${network}`),
		}
	},

	// const known = (network) => {list(), forget(), show(), set(name, value)}
}
type IWDDevice = {
	name: string
	address: string
	powered: 'on' | 'off'
	adapter: string
	mode: 'station' | string
}
type IWDStation = {
	show: () => IWDStationState
	get_networks: () => IWDStationNetwork[] | null
	scan: () => void
	disconnect: () => void
	connect: (network: string) => void
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
	static {
		Service.register(
			this,
			{},
			{
				'enabled': ['boolean', 'rw'],
				// 'internet': ['boolean'],
				'frequency': ['int'],
				'access-points': ['jsobject'],
				'ssid': ['string'],

				'state': ['string'],
				'network': ['jsobject'],
				'strength': ['int', 'r'],
				'icon-name': ['string', 'r'],
			}
		)
	}

	#network: IWDStationNetwork | undefined
	#device: string = iwd.devices()[0]
	#station: IWDStation = iwd.station(this.#device)
	#state: 'connected' | 'connecting' | 'disconnected' = 'disconnected' //this.#station.show().State

	constructor() {
		super()

		this.scan()
		console.log(`device: ${iwd.devices()}`)
		this.#station = iwd.station(this.#device)

		this.#state = this.#station.show().State
		// this.update()
		/* interval(1000, () => {
			console.log('show', this.#station.show())
			console.log('get_networks', this.#station.get_networks())
		}) */
	}
	// todo: scan, get active, --get signal--

	get network(): IWDStationNetwork | undefined {
		const state = this.#station?.show()
		if (state?.State !== 'connected') return undefined

		const network = this.#station
			.get_networks()
			?.find(n => n.name === state['Connected network'])

		if (this.network?.name !== network?.name) {
			this.#network = network
			this.strength = network?.signal ?? 0
		}
		this.changed('network')
		return this.#network
	}

	get icon_name() {
		console.log('icon name has run')
		if (!this.network) return STRENGTH_ICONS[0]
		return STRENGTH_ICONS[this.network.signal]
	}
	get strength() {
		return this.network?.signal ?? 0
	}
	set strength(v) {
		this.strength = v
		// this.icon_name
		this.changed('strength')
		this.changed('icon-name')
	}

	set state(val: IWDStationState['State']) {
		this.#state = val
		if (val === 'disconnected') {
			this.#network = undefined
			this.changed('network')
		}
		this.changed('state')
	}

	scan() {
		this.#station.scan()
	}
	disconnect() {
		this.#station.disconnect()
	}

	connectNetwork(network: IWDStationNetwork | undefined) {
		if (!network) {
			this.#station.scan()
			const networks = this.#station.get_networks()
			if (!networks) return
			network = networks[0]
		}
		try {
			this.#station.connect(network.name)
			this.state = this.#station.show().State
		} catch (why) {
			console.error('Connection failed' + why)
		}
	}

	update() {
		interval(1000, () => {
			console.log(this.strength)
		})
		this.changed('icon_name')
	}
}

let service
// the singleton instance
try {
	service = new NetworkService()

	// make it global for easy use with cli
	globalThis.network = service
} catch(err) {
	console.error(err)
}
//need to take care of case where dbus not found
	// export to use in other modules
	export default service
