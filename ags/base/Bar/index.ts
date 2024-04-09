import {
	Notifications,
	SystemTray,
	onScreenIndicator,
} from '../services/index.js'
import Media from './media.js'
import SysTray from './systray.js'
import GLib from 'gi://GLib'

const dayOfWeek = ['S', 'M', 'T', 'W', 'T', 'F', 'S']
let date = GLib.DateTime.new_now_local()
const Clock = () =>
	Widget.Box({
		class_name: 'clock',
		vertical: false,
		spacing: 4,
		children: [
			Widget.Label({
				class_name: 'time',
				justification: 'right',
				// vpack: 'end',
				vexpand: true,
				// hexpand: true,
				connections: [[1000, self => (self.label = date.format('%I:%M %p'))]],
			}),
			Widget.Label({
				class_name: 'date',
				// hexpand: true,
				vexpand: true,
				// vpack: 'end',
				justification: 'right',
				connections: [[1000, self => (self.label = date.format('%a, %b %d'))]],
			}),
		],
		connections: [[1000, _ => (date = GLib.DateTime.new_now_local())]],
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

const Center = Widget.Box({
	children: [
		// Notification(),
	],
})

const Right = Widget.Box({
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
	}),
	connections: [],
})
