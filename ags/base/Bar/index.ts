// import { notifications } from 'resource:///com/github/Aylur/ags/service/notifications.js'
// import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js'
// import Media from './media.js'
// import SysTray from './systray.js'
import SystemTray from 'gi://AstalTray'
import Battery from 'gi://AstalBattery'
import Niri from 'gi://AstalNiri'
import { App, Astal, Gtk, Gdk, Widget } from "astal/gtk3"
import { bind, Variable } from "astal"
import * as Utils from 'astal/process'

const log = (...args: Array<any>) => console.log(...args)

const batteryLabel = () => {
	const bat = Battery.get_default()
	return new Widget.Box({
		spacing: 2,
		vexpand: true,
		class_name: 'battery tray-icon',
		tooltip_text: bind(bat, 'time_to_empty').as(s => `naturalTime: ${s}`)
	},
		new Widget.Icon({
			icon: bind(bat, 'battery_icon_name',),
		}),
		bind(bat, 'percentage').as(p => Math.round(p * 100) + '%')
	)
}

const date = Variable(new Date(0)).poll(1000, "date -R", (d) => new Date(d))

let hide = false
export const Clock = () =>
	new Widget.Button({
		onClick(self) {
			hide = !hide
			self.toggleClassName('hide', hide)
		},
	},
		new Widget.Box({
			className: 'clock',
			vertical: false,
			spacing: 4,
		},
			new Widget.Label({
				label: bind(date).as(d => {
					const date = d.toDateString().split(' ')
					return `${date[0]} ${date[1]} ${date[2]}` ?? ''
				}),
				className: 'date',
				// hexpand: true,
				vexpand: true,
				// vpack: 'end',
				halign: Gtk.Align.END,
				// justification: 'right',
			}),
			new Widget.Label({
				label: bind(date).as(d => d.toLocaleTimeString().split(' ', 1)[0] ?? ''),
				className: 'time',
				halign: Gtk.Align.END,
				// justification: 'right',
				// vpack: 'end',
				vexpand: true,
				// hexpand: true,
			}),
		))

/*
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
*/

export const systemTray = (opts: { vertical: boolean }) => {
	const tray = SystemTray.get_default()
	const child = bind(tray, 'items').as(items => items.map(item => {
		const menu = item.menu_model
		return new Widget.Button({
			className: "tray-icon",
			tooltip_markup: bind(item, 'tooltip_markup'),
			onDestroy() { menu?.run_dispose() },
			on_click: (btn, event) => {
				switch (event.button) {
					case Gdk.BUTTON_PRIMARY: return item.activate(event.x, event.y)
					case Gdk.BUTTON_MIDDLE: return item.secondary_activate(event.x, event.y)
					case Gdk.BUTTON_SECONDARY:
					// menu?popup_at_widget(btn, Gdk.Gravity.NORTH, Gdk.Gravity.SOUTH, null)
				}
			}
		},
			new Widget.Icon({ g_icon: bind(item, 'gicon') })
		)
	}))

	return new Widget.Box({
		vertical: opts.vertical,
	},
		child)
}

export const Workspaces = (opts: { vertical: boolean }) => {
	const workspaces: Variable<Niri.Workspace[]> = Variable([])
	const niri = Niri.get_default()
	niri.connect('event', () => {
		const ws = niri.get_workspaces()
		workspaces.set(ws)
	})

	// Mod keys on my logitech mx master using wayland in 2024
	// Hardcoded because I can't find the right value in Gdk.ModifierType
	// Check event.modifier if setup changes 
	const BACK = 32768
	const FORWARD = 65536

	let lastTime = 0
	return new Widget.Box({
		className: 'workspaces',
	},
		new Widget.EventBox({
			onScroll(_, event) {
				if (event.time - lastTime < 150) return
				lastTime = event.time

				switch (event.direction) {
					case Gdk.ScrollDirection.UP: return Utils.execAsync('niri msg action focus-workspace-up')
					case Gdk.ScrollDirection.DOWN: return Utils.execAsync('niri msg action focus-workspace-down')
					case Gdk.ScrollDirection.LEFT: return Utils.execAsync('niri msg action focus-column-left')
					case Gdk.ScrollDirection.RIGHT: return Utils.execAsync('niri msg action focus-column-right')
					case Gdk.ScrollDirection.SMOOTH:
						const isVerical = Math.abs(event.delta_y) === Math.max(Math.abs(event.delta_x), Math.abs(event.delta_y))
						if (isVerical) {
							if (event.delta_y < 0)
								return Utils.execAsync('niri msg action focus-workspace-up')
							// return niri.message({ Action: { FocusColumnLeft: {} } })
							return Utils.execAsync('niri msg action focus-workspace-down')
						}
						if (event.delta_x < 0)
							return Utils.execAsync('niri msg action focus-column-left')
						return Utils.execAsync('niri msg action focus-column-right')
				}
			},
		},
			new Widget.Box({
				vertical: opts.vertical
			},
				workspaces(ws => ws.filter((w) => w.is_focused).map((w, i) => new Widget.Button({
					className: 'occupied indicator',
					on_clicked: () => Utils.execAsync(`niri msg action focus-workspace ${w.id}`)
						.catch(printerr),
				}, w.name
				)))
			)
		)
	)
}
const Seperator = () => new Widget.Label({ label: ' |  ', className: 'seperator' })
const Current = () => {
	const niri = Niri.get_default()
	const current_title: Variable<string> = Variable(niri.get_window(niri.focused_window_id)?.title ?? '')
	niri.connect('window-focus-changed', (niri, w_id) => current_title
		.set(niri.get_window(w_id)?.title ?? ''))
	return new Widget.Label({ label: current_title().as(t => t.slice(0, 150)) })
}

const Active = () => {
	const niri = Niri.get_default()
	return new Widget.Label({ label: niri.focused_window.title().as(t => t.slice(0, 150)) })
}

const Left = new Widget.Box({
	children: [
		Workspaces({ vertical: false }),
		Seperator(),
		Current()
	],
})

export const Center = new Widget.Box({
	children: [
		// Notification(),
	],
})

export const Right = new Widget.Box({
	halign: Gtk.Align.END,
	children: [
		/*
		Media(),
		SysTray(),
	'	*/
		systemTray({ vertical: false }),
		// sysTray(),
		batteryLabel(),
		Clock(),
	],
})

export const Bar = () => {
	return new Widget.Window({
		name: 'bar',
		className: 'bar',
		monitor: 0,
		anchor: Astal.WindowAnchor.TOP
			| Astal.WindowAnchor.LEFT
			| Astal.WindowAnchor.RIGHT,
		application: App,
		// margins: [4],
		exclusivity: Astal.Exclusivity.EXCLUSIVE,
	},
		new Widget.CenterBox({
			start_widget: Left,
			center_widget: Center,
			end_widget: Right,
		},
		)
	)
}
