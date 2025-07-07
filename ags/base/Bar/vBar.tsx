import { notifications } from 'resource:///com/github/Aylur/ags/service/notifications.js'
import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js'
import Media from './media.js'
import { Workspaces, systemTray } from './index.js'
import SysTray from './systray.js'
import GLib from 'gi://GLib'

export const Clock = () =>
	Widget.Box({
		class_name: 'clock',
		vertical: true,
		spacing: 4,
		children: [
			Widget.Label({
				label: date.bind().as(d => d.format('%a %d ')?.toString() ?? ''),
				class_name: 'date',
				// hexpand: true,
				vexpand: true,
				// vpack: 'end',
				justification: 'right',
			}),
			Widget.Label({
				label: date.bind().as(d => d.format('%I:%M')?.toString() ?? ''),
				class_name: 'time',
				justification: 'right',
				// vpack: 'end',
				vexpand: true,
				// hexpand: true,
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

const Current = () => {
	const label = Variable('', {
		poll: [1800, 'niri msg -j focused-window', (res: string) => {
			// print(res)
			const focused = JSON.parse(res)

			return `${focused.title.substring(0,24)} | ${focused.app_id}`
		}]
	})

	return Widget.Label({
		label: label.bind()})
}
// layout of the bar
const Left = Widget.Box({
	children: [
		Workspaces({vertical: true}),
	],
})

export const Center = Widget.Box({
	children: [
		// Notification(),
		// Current()
	],
})

export const Right = Widget.Box({
	hpack: 'end',
	children: [
		Media(),
		systemTray({vertical: true}),
		SysTray({vertical: true}),
		Clock(),
	],
})

export default Widget.Window({
	name: `vBar`,
	class_name: 'bar',
	anchor: ['left', 'top', 'bottom'],
	// margins: [4],
	// exclusivity: 'exclusive',
	child: Widget.CenterBox({
		vertical: true,
		start_widget: Left,
		center_widget: Center,
		end_widget: Right,
	}),
})
