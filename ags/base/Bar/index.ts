// import { notifications } from 'resource:///com/github/Aylur/ags/service/notifications.js'
// import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js'
// import Media from './media.js'
// import SysTray from './systray.js'
import SystemTray from 'gi://AstalTray'
import Battery from 'gi://AstalBattery'
// import Application from 'gi://AstalApplication'
import Niri, { msg } from 'gi://AstalNiri'
import Gio from 'gi://Gio?version=2.0'
import { App, Astal, Gtk, Gdk, Widget } from "astal/gtk3"
import { bind, Variable } from "astal"
import * as Utils from 'astal/process'
import AstalApps from 'gi://AstalApps?version=0.1'

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
			className: 'clock semibold',
			vertical: false,
			spacing: 4,
		},
			new Widget.Label({
				label: bind(date).as(d => {
					const date = d.toDateString().split(' ')
					return `${date[0]} ${date[1]} ${date[2]}` ?? ''
				}),
				className: 'date semibold',
				// hexpand: true,
				vexpand: true,
				// vpack: 'end',
				halign: Gtk.Align.END,
				// justification: 'right',
			}),
			new Widget.Label({
				label: bind(date).as(d => d.toLocaleTimeString().split(' ', 1)[0] ?? ''),
				className: 'time semibold',
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
			new Widget.Icon({ icon: bind(item, 'icon_name').as(i => i ?? "") }),
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
	niri.overview
	niri.connect('event', () => {
		const ws = niri.get_workspaces()
		workspaces.set(ws)
	})

	// Mod keys on my logitech mx master using wayland in 2024
	// Hardcoded because I can't find the right value in Gdk.ModifierType
	// Check event.modifier if setup changes 
	const BACK = 32768
	const FORWARD = 65536

	Gio._promisify(Niri.msg, 'pick_color', 'pick_color_finish')
	let lastTime = 0
	return new Widget.Box({
		className: 'workspaces',
	},
		new Widget.EventBox({
			onScroll(_, event) {
				if (event.time - lastTime < 150) return
				lastTime = event.time

				switch (event.direction) {
					case Gdk.ScrollDirection.UP: return niri.msg.send({ Action: { FocusWorkspaceUp: {} } })
					// case Gdk.ScrollDirection.UP: return Utils.execAsync('niri msg action focus-workspace-up')
					// case Gdk.ScrollDirection.DOWN: return Utils.execAsync('niri msg action focus-workspace-down')
					// case Gdk.ScrollDirection.LEFT: return Utils.execAsync('niri msg action focus-column-left')
					// case Gdk.ScrollDirection.RIGHT: return Utils.execAsync('niri msg action focus-column-right')
					case Gdk.ScrollDirection.SMOOTH:
						const isVerical = Math.abs(event.delta_y) === Math.max(Math.abs(event.delta_x), Math.abs(event.delta_y))
						if (isVerical) {
							if (event.delta_y < 0) {
								return Niri.msg.focus_workspace_up()
								// Gio._promisify(Niri.Message.prototype, 'send_async')
							}




							// return Utils.execAsync('niri msg action focus-workspace-up')
							// return niri.message({ Action: { FocusColumnLeft: {} } })
							return Utils.execAsync('niri msg action focus-workspace-down')
						}
						if (event.delta_x < 0)
							return Utils.execAsync('niri msg action focus-column-left')
						return Utils.execAsync('niri msg action focus-column-right')
				}
			},
		},
			bind(niri, "focused_workspace").as((w) => w
				? new Widget.Label({
					className: "semibold px-4 bg-accent txt-mantle",
					label: bind(w, 'name').as(name => `${w.idx} ${name}`)
				})
				: '')
			/* new Widget.Box({
				vertical: opts.vertical
			},
				workspaces(ws => ws.filter((w) => w.is_focused).map((w, i) => new Widget.Button({
					className: 'occupied indicator',
					on_clicked: () => Utils.execAsync(`niri msg action focus-workspace ${w.id}`)
						.catch(printerr),
				}, w.name
				)))
			) */
		)
	)
}
const Seperator = (label = ' |  ') => new Widget.Label({ label, className: 'seperator' })
const Current = () => {
	const niri = Niri.get_default()
	const current_title: Variable<string> = Variable(niri.get_window(niri.focused_window_id)?.title ?? '')
	niri.connect('window-focus-changed', (niri, w_id) => {
		current_title.set(niri.get_window(w_id)?.title ?? '')
	})
	return new Widget.Label({ label: current_title().as(t => t.slice(0, 150)) })
}

const Current2 = () => {
	const niri = Niri.get_default();
	return new Widget.Label({
		className: "bg-surface px-4",
		label: bind(niri, "focused_window").as((win) => (win ? win.title : "")),
	});
};
function WorkspaceButton({ ws }: { ws: Niri.Workspace }) {
	const clients = bind(ws, "windows").as((clients) =>
		clients.sort((a, b) => a.id - b.id),
	);

	console.log(clients)
	return Widget.Box({

	})
}

const Testing = (monitor: Gdk.Monitor) => {
	const niri = Niri.get_default();
	const apps = new AstalApps.Apps();

	return bind(niri, "focused_workspace").as(wk =>
		wk && new Widget.Box({
			children: bind(wk, 'windows').as(wins => wins.map(w => new Widget.Button({
				onClick() {
					Niri.msg.focus_window(w.id)
				},
				label: bind(w, 'title').as(name => ` ${name} |`),
				className: bind(w, 'is_focused').as(f => f ? "txt-accent" : "txt-"),
				// child: new Widget.Icon({ icon: (apps.fuzzy_query(w.app_id) ?? []).shift()?.icon_name })
			})))
		},
			// if (!current) return new Widget.Label({ label: "not found" })
			// return new Widget.Label({ label: bind(current, "name").as(n => ` ${n} `) })
		)
	)
};

const Current3 = () => {
	const niri = Niri.get_default();
	return bind(niri, 'focused_window').as(fw =>
		new Widget.Label({
			label: fw && bind(fw, "title").as((t) => (t ?? ""))
		})
	)
};

const Demo = () => {
	const niri = Niri.get_default();
	return [
		new Widget.Button({
			onClick: async () => {
				try {

					let res = await niri.msg(JSON.stringify({
						Action: { FocusWorkspace: { reference: { Index: 2 } } }
					}))
					console.log("res:", res)
				} catch (e) {
					console.error(e)
				}
				console.log('hello workd')
			},
			label: 'X'
		})

	]
};


const Left = (monitor: Gdk.Monitor) => new Widget.Box({
	children: [
		// Workspaces({ vertical: false }),
		// Current2(),
		Testing(monitor)
		// Current3()
	],
})

export const Center = new Widget.Box({
	children: [
		Clock(),
		// ...Demo()
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
	],
})

export const Bar = (monitor: Gdk.Monitor) => {

	return new Widget.Window({
		name: 'bar',
		className: 'bar',
		monitor,
		anchor: Astal.WindowAnchor.TOP
			| Astal.WindowAnchor.LEFT
			| Astal.WindowAnchor.RIGHT,
		application: App,
		// margins: [4],
		exclusivity: Astal.Exclusivity.EXCLUSIVE,
	},
		new Widget.CenterBox({
			start_widget: Left(monitor),
			center_widget: Center,
			end_widget: Right,
		},
		)
	)
}
