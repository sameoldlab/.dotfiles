import {
	Notifications,
	SystemTray,
	onScreenIndicator,
} from '../services/index.js'
import Media from './media.js'
import SysTray from './systray.js'
import GLib from 'gi://GLib'

const dayOfWeek = ['S', 'M', 'T', 'W', 'T', 'F', 'S']
let date = Variable(GLib.DateTime.new_now_local(), {
		poll: [1000, () => GLib.DateTime.new_now_local()]
	})

export const Clock = () =>
	Widget.Box({
		class_name: 'clock',
		vertical: false,
		spacing: 4,
		children: [
			Widget.Label({
				label: date.bind().as(d => d.format('%I:%M %p')?.toString() ?? ""),
				class_name: 'time',
				justification: 'right',
				// vpack: 'end',
				vexpand: true,
				// hexpand: true,
			}),
			Widget.Label({
				label: date.bind().as(d => d.format('%a, %b %d')?.toString() ?? ""),
				class_name: 'date',
				// hexpand: true,
				vexpand: true,
				// vpack: 'end',
				justification: 'right',
			})
		]
	})

const Notification = () =>
	Widget.Box({
		class_name: 'notification',
		children: [
			Widget.Icon({
				icon: 'preferences-system-notifications-symbolic',
				connections: [
					[
						Notifications,
						self => (self.visible = Notifications.popups.length > 0),
					],
				],
			}),
			Widget.Label({
				connections: [
					[
						Notifications,
						self => {
							self.label = Notifications.popups[0]?.summary || ''
						},
					],
				],
			}),
		],
	})



// layout of the bar
const Left = Widget.Box({
	children: [
		//Workspaces()
		],
})

export const Center = Widget.Box({
	children: [
		// Notification(),
	],
})

export const Right = Widget.Box({
	hpack: 'end',
	children: [Media(), SysTray(), Clock()],
})

export default Widget.Window({
	name: `agsBar`, // name has to be unique
	class_name: 'bar',	
	anchor: ['top', 'left', 'right'],
	// margins: [4],
	exclusivity: 'exclusive' /* Stops draw over */,
	child: Widget.CenterBox({
		start_widget: Left,
		center_widget: Center,
		end_widget: Right,
	})
})
