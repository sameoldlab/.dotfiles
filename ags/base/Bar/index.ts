// import { notifications } from 'resource:///com/github/Aylur/ags/service/notifications.js'
// import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js'
// import Media from './media.js'
// import SysTray from './systray.js'
import { App, Astal, Gtk, Widget } from "astal/gtk3"
import { bind, Variable } from "astal"
import * as Utils from 'astal/process'

const date = Variable(new Date(0)).poll(1000, "date -R", (d) => new Date(d))

export const Clock = () =>
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
			label: bind(date).as(d => d.toTimeString().split(' ', 1)[0] ?? ''),
			className: 'time',
			halign: Gtk.Align.END,
			// justification: 'right',
			// vpack: 'end',
			vexpand: true,
			// hexpand: true,
		}),
	)

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

export const systemTray = (opts: {vertical: boolean}) =>
	Widget.Box({
		vertical: opts.vertical,
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


	return Widget.Label({
		label: label.bind()})
}
*/

export const Workspaces = (opts: { vertical: boolean }) => new Widget.Box({
	className: 'workspaces',
	child: new Widget.EventBox({
		// on_scroll_up: () => Utils.execAsync('niri msg action focus-workspace-up'),
		// on_scroll_down: () => Utils.execAsync('niri msg action focus-workspace-down'),
		// on_scroll_left: ()=> Utils.execAsync('niri msg action focus-column-left'),
		child: new Widget.Box({
			vertical: opts.vertical,
			children: [...Array(10)].map((_, i) => {
				i++
				return new Widget.Button({
					className: 'occupied',
					on_clicked: () => Utils.execAsync(`niri msg action focus-workspace ${i}`).catch(print),
					child: new Widget.Label({
						label: `${i}`,
						className: 'indicator',
					}),
					// connections: [[Hyprland, btn => {
					// 	btn.toggleClassName('focused', Hyprland.active.workspace.id === i)
					// 	btn.toggleClassName('occupied', Hyprland.getWorkspace(i)?.windows > 0)
					// }]]
				})
			})
		})
	})
})

const Current = () => {
	const label = Variable('')
		.poll(1800, 'niri msg -j focused-window', (res: string) => {
			// print(res)
			const focused = JSON.parse(res)

			return `${focused.title.substring(0, 24)} | ${focused.app_id}`
		})
	return new Widget.Label({ label: bind(label) })
}
// layout of the bar
const Left = new Widget.Box({
	children: [
		Workspaces({ vertical: false }),
	],
})

export const Center = new Widget.Box({
	children: [
		// Notification(),
		Current()
	],
})

export const Right = new Widget.Box({
	halign: Gtk.Align.END,
	// hpack: 'end',
	children: [
		/*
		Media(),
		systemTray({vertical: false}),
		SysTray(), 
		*/
		Clock(),
	],
})
// new Widget.Button({
// 	onClicked: () => print("hello"),
// 	halign: Gtk.Align.CENTER
// },
// 	new Widget.Label({ label: bind(date) })
// ),

export const Bar = new Widget.Window({
	name: 'agsBar',
	className: 'bar',
	monitor: 0,
	anchor: Astal.WindowAnchor.TOP
		| Astal.WindowAnchor.LEFT
		| Astal.WindowAnchor.RIGHT,
	application: App,
	// margins: [4],
	// exclusivity={Astal.Exclusivity.EXCLUSIVE},
},
	new Widget.CenterBox({
		start_widget: Left,
		center_widget: Center,
		end_widget: Right,
	},
	)
)
