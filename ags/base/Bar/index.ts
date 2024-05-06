import { notifications } from 'resource:///com/github/Aylur/ags/service/notifications.js'
import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js'
import Media from './media.js'
import SysTray from './systray.js'
import GLib from 'gi://GLib'

const dayOfWeek = ['S', 'M', 'T', 'W', 'T', 'F', 'S']
let date = Variable(GLib.DateTime.new_now_local(), {
	poll: [1000, () => GLib.DateTime.new_now_local()],
})

export const Clock = () =>
	Widget.Box({
		class_name: 'clock',
		vertical: false,
		spacing: 4,
		children: [
			Widget.Label({
				label: date.bind().as(d => d.format('%I:%M %p')?.toString() ?? ''),
				class_name: 'time',
				justification: 'right',
				// vpack: 'end',
				vexpand: true,
				// hexpand: true,
			}),
			Widget.Label({
				label: date.bind().as(d => d.format('%a, %b %d')?.toString() ?? ''),
				class_name: 'date',
				// hexpand: true,
				vexpand: true,
				// vpack: 'end',
				justification: 'right',
			}),
		],
	})

const Notification = () =>
	Widget.Box({
		class_name: 'notification',
		children: [
			Widget.Icon({
				icon: 'preferences-system-notifications-symbolic',
				visible: notifications.bind('popups').as(p => p.length > 0),
			}),
			Widget.Label({
				label: notifications.bind('popups').as(p => p[0].summary),
			}),
		],
	})

const systemTray = () =>
	Widget.Box({
		children: SystemTray.bind('items').as(items =>
			items.map(item => Widget.Button({
					child: Widget.Icon({
						 icon: item.bind('icon'),
						}),
					class_name: "tray-icon",
					on_primary_click: (_, event) => item.activate(event),
					on_secondary_click: (_, event) => item.openMenu(event),
					tooltip_markup: item.bind('tooltip_markup'),
				})
			)
		), 
	})
/*
 */

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
	children: [
		Media(),
		systemTray(),
		SysTray(),
		Clock(),
	],
})

export default Widget.Window({
	name: `agsBar`,
	class_name: 'bar',
	anchor: ['top', 'left', 'right'],
	// margins: [4],
	exclusivity: 'exclusive',
	child: Widget.CenterBox({
		start_widget: Left,
		center_widget: Center,
		end_widget: Right,
	}),
})
