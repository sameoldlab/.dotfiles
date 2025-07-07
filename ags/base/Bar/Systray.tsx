import { Brightness } from '../services/index.js'
// import Network from '../services/network.js'
import Audio from 'gi://AstalWp'
import Battery from 'gi://AstalBattery?version=0.1'
import { Gtk } from 'ags/gtk4'
import { createBinding } from 'ags'
import { createPoll } from 'ags/time'

const VolumeLbl = () => {

	const audio = Audio.get_default()
	const speaker = audio?.defaultSpeaker
	if (!speaker) return <box />

	const icons = {
		101: 'overamplified',
		67: 'high',
		34: 'medium',
		1: 'low',
		0: 'muted',
	}
	function getIcon(speaker: Audio.Endpoint) {

		const icon = speaker.mute
			? 0
			: ([101, 67, 34, 1, 0] as const).find(
				threshold => threshold <= speaker.volume * 100
			)!

		return `audio-volume-${icons[icon]}-symbolic`
	}
	const volume_lvl = createBinding(speaker, 'volume').as(v => `${Math.round(v * 100)}`)

	return <button
		class='volume tray-icon'
		onScrollDown={() => {
			if (!speaker) return
			const { volume } = speaker
			speaker.volume = volume - 0.01
		}}
		onScrollUp={() => {
			print(50)
			if (!speaker) return
			speaker.volume += 0.01
		}}
		css={'min-width: 180px'}
	>
		<box
			valign={Gtk.Align.CENTER}
			vexpand={true}
			spacing={2}
		>
			<image
				icon_name={getIcon(speaker)}
				vexpand={true}
				valign={Gtk.Align.CENTER}
			/>
			<label label={volume_lvl} />
		</box>
	</button>
}

const BrightnessLbl = () =>
	<eventbox
		on_scroll_up={() => {
			Brightness.screen_value += 0.011
		}}
		on_scroll_down={() => {
			Brightness.screen_value -= 0.01
		}}
		class={'battery tray-icon'}
	>
		<box
			spacing={2}
			vexpand={true}
		>
			<image icon_name={'display-brightness-symbolic'} />
			<label label={createBinding(Brightness, 'screen_value').as(v => `${Math.round(v * 100)}`)} />
		</box>
	</eventbox>
// try {
// 	Network.connect(undefined, (a, b) => {
// 		console.log(a)
// 		console.log(b)
// 	})
// } catch (err) {
// 	console.error(err)
// }

const wifi = () => {
	const signal = createPoll('offline',
		1000,
		[
			'bash',
			'-c',
			`iwctl station wlan0 show \
				| grep 'Connected network' \
				| sd '            Connected network     ' ''`,
		]).as(val => {
			// console.log(val)
			if (val === '') return 'offline'
			return 'good'
		})

	return <box class={'wifi tray-icon'} >
		<stack shown={signal} >
			good: Widget.Icon('network-wireless-signal-good-symbolic'),
			offline: Widget.Icon('network-wireless-offline-symbolic'),
		</stack>
	</box>
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

const BatteryLbl = () => {
	const battery = Battery.get_default()
	const timeLeft = createBinding(battery, 'time_to_empty').as(s => naturalTime(s))
	const percent = createBinding(battery, 'percentage').as(v => `${v}%`)
	const icon_name = createBinding(battery, 'icon_name')
	return <box
		spacing={2}
		vexpand={true}
		class={'battery tray-icon'}
		tooltip_text={timeLeft}
	>
		<image
			icon_name={icon_name}
		/>
		<label label={percent} />
	</box>
}

const Tray = (opts: { vertical: boolean } = { vertical: false }) =>
	// Widget.EventBox({
	// 	// pass_through: true,
	// revealer,
	// wifi(),

	<box
		orientation={opts.vertical ? Gtk.Orientation.VERTICAL : Gtk.Orientation.HORIZONTAL} vexpand={true} spacing={8} valign={Gtk.Align.CENTER}>
		<BrightnessLbl />
		<VolumeLbl />
		<BatteryLbl />
	</box>

export default Tray
