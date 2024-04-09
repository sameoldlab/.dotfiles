import Notifications	from 'resource:///com/github/Aylur/ags/service/notifications.js' 
import Mpris					from 'resource:///com/github/Aylur/ags/service/mpris.js'
import Audio					from 'resource:///com/github/Aylur/ags/service/audio.js'
import Battery				from 'resource:///com/github/Aylur/ags/service/battery.js' 
import SystemTray			from 'resource:///com/github/Aylur/ags/service/systemtray.js' 
import Applications		from 'resource:///com/github/Aylur/ags/service/applications.js'
import Bluetooth			from 'resource:///com/github/Aylur/ags/service/bluetooth.js'
import Network				from 'resource:///com/github/Aylur/ags/service/network.js'

import Brightness from './brightness.js'
import onScreenIndicator from './onScreenIndicator.js'
import Player from './player.js'
// import Launcher from './PopLauncher.js'
// import Recorder from './recorder.js'

import * as services from './index.js'

export async function globalServices() {
	globalThis.brightness = Brightness
	// globalThis.recorder = globalThis.ags.Recorder;
	globalThis.indicator = onScreenIndicator
	// globalThis.launcher = Launcher
	globalThis.audio = Audio
	globalThis.player = Player.value
	globalThis.mpris = Mpris
}
globalServices()


export {
	Notifications,
	Mpris,
	Audio,
	Battery,
	SystemTray,
	Applications,
	Bluetooth,
	Network,
	Brightness,
	onScreenIndicator,
	Player,
}