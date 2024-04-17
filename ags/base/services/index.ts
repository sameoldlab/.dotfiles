import Audio  from 'resource:///com/github/Aylur/ags/service/audio.js'
import Mpris  from 'resource:///com/github/Aylur/ags/service/mpris.js'
import Brightness from './brightness.js'
import onScreenIndicator from './onScreenIndicator.js'
import Player from './player.js'
// import Recorder from './recorder.js'


export async function globalServices() {
	globalThis.audio = Audio
	globalThis.mpris = Mpris
	globalThis.brightness = Brightness
	globalThis.indicator = onScreenIndicator
	globalThis.player = Player.value
	// globalThis.recorder = globalThis.ags.Recorder;
}


export {
	Mpris,
	Audio,
	Brightness,
	onScreenIndicator,
	Player,
}