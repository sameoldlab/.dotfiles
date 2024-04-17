import { Brightness } from '../services/index.js'
import Audio from 'resource:///com/github/Aylur/ags/service/audio.js'
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js'

const Volume = () => Widget.Button({
	class_name: 'volume tray-icon',


		on_scroll_down: () => {
			if(!Audio.speaker) return
			const {volume} = Audio.speaker
			Audio.speaker.volume = volume - .01
		},
		on_scroll_up: () => {
			print(50)
			if(!Audio.speaker) return
			const {volume} = Audio.speaker
			Audio.speaker.volume = volume + .01
		},
	// css: 'min-width: 180px',
	child: Widget.Stack({
			children: {
				// tuples of [string, Widget]
				'101': Widget.Icon('audio-volume-overamplified-symbolic'),
				'67': Widget.Icon('audio-volume-high-symbolic'),
				'34': Widget.Icon('audio-volume-medium-symbolic'),
				'1': Widget.Icon('audio-volume-low-symbolic'),
				'0': Widget.Icon('audio-volume-muted-symbolic'),
			},
			connections: [
				[
					Audio,
					self => {
						if (!Audio.speaker) return

						if (Audio.speaker.is_muted) {
							self.shown = '0'
							return
						}
						
						const {volume} = Audio.speaker

						const show = [101, 67, 34, 1, 0].find(
							threshold => threshold <= volume * 100
						)

						self.shown = `${show}`
					},
					'speaker-changed',
				],
			],
		})
})


const BrightnessLabel = () => Widget.EventBox({
	on_scroll_up:()=>{Brightness.screen_value += 0.011},
	on_scroll_down:()=>{Brightness.screen_value -= 0.01},
	class_name: 'battery tray-icon',
	child: Widget.Label({
		binds: [['label', Brightness, 'screen-value', v => ` B: ${Math.round(v*100)}`]],
	})
})

const Wifi = () => Widget.Box({
	class_name: 'wifi tray-icon',
	children: [
		Widget.Stack({
			children: {
				'c1': Widget.Icon('network-wireless-signal-good-symbolic'),
				'c0': Widget.Icon('network-wireless-offline-symbolic'),
			}
		}).poll(1000, self => {
			self.shown = Utils.execAsync([
				'bash',
				'-c',
				`iwctl station wlan0 show \
				 | grep 'Connected network' \
				 | sd '            Connected network     ' ''`, 
			]).then(s => (s === '' ? 'c0' : 'c1'))
		}),
	]
})

const naturalTime = (s: number) => {
	let time = ['']
	let m = s / 60
	s = Math.round(((m % 1) * 60))

	let h = m / 60
	m = Math.round(((h % 1) * 60))

	if( h > 1 ) {
		h = Math.round(h)		
		return `${h}h ${m}m ${s}s`
	}

	return `${m}m ${s}s`
}

const BatteryLabel = () => Widget.Box({
	class_name: 'battery tray-icon',
	binds: [['tooltip_text', Battery, 'time-remaining', s => `${naturalTime(s)}`]],
	children: [
		Widget.Icon({
			connections: [
				[
					Battery,
					self => {
						self.icon = Battery.icon_name
					},
				]
			]
		}),
		Widget.Label({
			binds: [['label', Battery, 'percent', p => ` ${p}%`]],
	}),
	]
})


const ExtTray = () =>
	Widget.Box({
		connections: [
			[
				SystemTray,
				self => {
					self.children = SystemTray.items.map(item =>
						Widget.Button({
							child: Widget.Icon({ binds: [['icon', item, 'icon']] }),
							on_primary_click: (_, event) => item.activate(event),
							on_secondary_click: (_, event) => item.openMenu(event),
							binds: [['tooltip-markup', item, 'tooltip-markup']],
						})
					)
				},
			],
		],
	})

const SysTray = () => Widget.EventBox({
	// pass_through: true,

	child: 
		Widget.Box({
		children: [
			BrightnessLabel(),
			// revealer,
			Wifi(),
			Volume(),
			BatteryLabel(),
		]
	}),
})

export default SysTray
