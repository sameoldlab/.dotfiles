import { Brightness } from '../services/index.js'
import Audio from 'resource:///com/github/Aylur/ags/service/audio.js'
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js'

const volume = () =>
	Widget.Button({
		class_name: 'volume tray-icon',

		on_scroll_down: () => {
			if (!Audio.speaker) return
			const { volume } = Audio.speaker
			Audio.speaker.volume = volume - 0.01
		},
		on_scroll_up: () => {
			print(50)
			if (!Audio.speaker) return
			const { volume } = Audio.speaker
			Audio.speaker.volume = volume + 0.01
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
			shown: Audio.bind('speaker').as(v => {
				console.log(v.volume)
				if (v.is_muted === true ) return '0'
				const show = [101, 67, 34, 1, 0].find(
					threshold => threshold <= v.volume * 100
				)?.toString() as "101" | "67" | "34" | "1"| "0" | undefined
				
				return show
			}),
			
		}),
	})

const brightnessLabel = () =>
	Widget.EventBox({
		on_scroll_up: () => {
			Brightness.screen_value += 0.011
		},
		on_scroll_down: () => {
			Brightness.screen_value -= 0.01
		},
		class_name: 'battery tray-icon',
		child: Widget.Label({
			label: Brightness.bind('screen_value').as(
				v => ` B: ${Math.round(v * 100)}`
			),
		}),
	})

const wifi = () =>
	Widget.Box({
		class_name: 'wifi tray-icon',
		children: [
			Widget.Stack({
				children: {
					'good': Widget.Icon('network-wireless-signal-good-symbolic'),
					'offline': Widget.Icon('network-wireless-offline-symbolic'),
				},
			}).poll(1000, self => {
				Utils.execAsync([
					'bash',
					'-c',
					`iwctl station wlan0 show \
				 | grep 'Connected network' \
				 | sd '            Connected network     ' ''`,
				]).then(s => (s === '' ? 'offline' : 'good'))
			}),
		],
	})

const naturalTime = (s: number) => {
	let time = ['']
	let m = s / 60
	s = Math.round((m % 1) * 60)

	let h = m / 60
	m = Math.round((h % 1) * 60)

	if (h > 1) {
		h = Math.round(h)
		return `${h}h ${m}m ${s}s`
	}

	return `${m}m ${s}s`
}

const batteryLabel = () =>
	Widget.Box({
		class_name: 'battery tray-icon',
		tooltip_text: Battery.bind('time_remaining').as(s => naturalTime(s)),
		children: [
			Widget.Icon({
				icon: Battery.bind('icon_name'),
			}),
			Widget.Label({
				label: Battery.bind('percent').as(v => `${v}%`),
			}),
		],
	})


const Tray = () =>
	Widget.EventBox({
		// pass_through: true,

		child: Widget.Box({
			children: [
				brightnessLabel(),
				// revealer,
				wifi(),
				volume(),
				batteryLabel(),
			],
		}),
	})

export default Tray
