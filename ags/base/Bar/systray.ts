import { Brightness } from '../services/index.js'
// import Network from '../services/network.js'
import Audio from 'resource:///com/github/Aylur/ags/service/audio.js'
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js'

const volume = () => {
	const icons = {
		101: 'overamplified',
		67: 'high',
		34: 'medium',
		1: 'low',
		0: 'muted',
	}
	function getIcon() {
		const icon = Audio.speaker.is_muted
			? 0
			: [101, 67, 34, 1, 0].find(
				threshold => threshold <= Audio.speaker.volume * 100
			)!

		return `audio-volume-${icons[icon]}-symbolic`
	}

	const icon = Widget.Icon({
		icon: Utils.watch(getIcon(), Audio.speaker, getIcon),
	})

	return Widget.Button({
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
		child: icon,
	})
}

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
				v => `B: ${Math.round(v * 100)}`
			),
		}),
	})
// try {
// 	Network.connect(undefined, (a, b) => {
// 		console.log(a)
// 		console.log(b)
// 	})
// } catch (err) {
// 	console.error(err)
// }

const wifi = () => {
	const signal = Variable('offline', {
		poll: [
			1000,
			[
				'bash',
				'-c',
				`iwctl station wlan0 show \
				| grep 'Connected network' \
				| sd '            Connected network     ' ''`,
			],
			val => {
				// console.log(val)
				if (val === '') return 'offline'
				return 'good'
			},
		],
	})
	return Widget.Box({
		class_name: 'wifi tray-icon',
		children: [
			Widget.Stack({
				children: {
					good: Widget.Icon('network-wireless-signal-good-symbolic'),
					offline: Widget.Icon('network-wireless-offline-symbolic'),
				},
				shown: signal.bind(),
			}),
		],
	})
}

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
				// wifi(),
				volume(),
				batteryLabel(),
			],
		}),
	})

export default Tray
