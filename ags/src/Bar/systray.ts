import { Notifications, Mpris, Audio, Battery, Brightness}  from '../services/index.js'
import {Widget, Utils} from '../imports.js'

/* 
// For Media, Volume, and Brightness amounts
const revealer = Widget.Revealer({
	reveal_child: false,
	transition_duration: 1000,
	transition: 'slide_right',
	child: Widget.Label('hello!'),
	connections: [[2000, self => {
			self.reveal_child = !self.reveal_child;
	}]],
}); */

const Volume = () => Widget.Button({
	class_name: 'volume tray-icon',


		on_scroll_down: () => {
			print(32)
			if(!Audio.speaker) return
			const {volume} = Audio.speaker
			Audio.speaker.volume = volume - .1
		},
		on_scroll_up: () => {
			print(50)
			if(!Audio.speaker) return
			const {volume} = Audio.speaker
			Audio.speaker.volume = volume + .1
		},
	// css: 'min-width: 180px',
	child: Widget.Stack({
			items: [
				// tuples of [string, Widget]
				['101', Widget.Icon('audio-volume-overamplified-symbolic')],
				['67', Widget.Icon('audio-volume-high-symbolic')],
				['34', Widget.Icon('audio-volume-medium-symbolic')],
				['1', Widget.Icon('audio-volume-low-symbolic')],
				['0', Widget.Icon('audio-volume-muted-symbolic')],
			],
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

const BrightnessLabel = () => Widget.Label({
	class_name: 'battery tray-icon',
	binds: [['label', Brightness, 'screen-value', v => `${v}`]],
	connections: [
		[
			Brightness,
			self => {
				self.label = `${Brightness.screen_value}`
			},
			'notify::screen-value',
		],
	],
})

const Wifi = () => Widget.Box({
	class_name: 'wifi tray-icon',
	children: [
		Widget.Stack({
			items: [
				// tuples of [string, Widget]
				['1', Widget.Icon('network-wireless-signal-good-symbolic')],
				['0', Widget.Icon('network-wireless-offline-symbolic')],
			],
			connections: [
				[
					1000, self => 
						Utils.execAsync([
							'bash',
							'-c',
							`iwctl station wlan0 show \
							 | grep 'Connected network' \
							 | sd '            Connected network     ' ''`, 
						]).then(s => (self.shown = s === '' ? '0' : '1'))
				],
			],
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

const SysTray = () => Widget.EventBox({
	// pass_through: true,
	on_primary_click:()=>{print(42)},
	on_scroll_up:()=>{print(45)},
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
