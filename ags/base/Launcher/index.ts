import { Gio } from 'astal'
import { App, Astal, Gtk, Gdk, Widget } from "astal/gtk3"
import { bind, Variable } from "astal"
import { execAsync } from 'astal/process'
import Launcher from '../services/launcherIPC.js'
import type { JsonIPC } from '../services/launcherIPC.js'
import { ListItem } from './ListItem'
const WINDOW_NAME = 'poplauncher'
const launcher = Launcher.get_default()

let active_id = 0


const entries = Variable<JsonIPC.SearchResult[]>([])

const close = () => {
	console.log('popLauncher: CLOSE')
	entry.text = ''
	launcher.interrupt()
	active_id = 0
	App.closeWindow(WINDOW_NAME)
}
const list = new Widget.Box({
	vertical: true,
	children: bind(entries).as(v => v.map(ListItem)),
	spacing: 0,
})

const entry = new Widget.Entry({
	on_accept: () => launcher.activate(active_id),
	on_change: ({ text }) => {
		text = text ?? ''
		launcher.search(text)
	},
	placeholder_text: " Type to search apps, or type '?' for more options.",
	hexpand: true,
	css: `margin-bottom: ${0}px;`,
	className: 'applauncher__entry',
})

launcher.connect(
	'new-response',
	(service, res: Exclude<JsonIPC.Response, 'Close'>) => {
		// console.log('message received is:', res)
		if ('Update' in res) {
			entries.setValue(res.Update)
		} else if ('Fill' in res) {
			entry.text = res.Fill
		} else if ('DesktopEntry' in res) {
			launch(res)
			close()
		} else {
			console.log(
				"Don't know how to handle context: ",
				JSON.stringify(res.Context)
			)
		}
	}
)
launcher.connect('close', close)

const Applauncher = ({ width = 500, height = 500, spacing = 12 } = {}) =>
	new Widget.Box({
		vertical: true,
		className: 'applauncher',
		css: `margin: ${spacing * 2}px;`,
		children: [
			entry,
			// wrap the list in a scrollable
			new Widget.Scrollable({
				className: 'applauncher__list',
				hscroll: 'never',
				css: `
								min-width: ${width}px;
								min-height: ${height}px;
							`,
				child: list,

			})
		],
		setup: self =>
			self.hook(App, (_, windowName, visible) => {
				if (windowName !== WINDOW_NAME) return

				// when the applauncher shows up
				if (visible) {
					// entry.text = ''
					// entry.grab_focus()
					// For nicer default results modify plugin.ron for destop_entries to include query (peristent: true, history: true)
					launcher.search('')
				}
			}),
	})
export default new Widget.Window({
	name: WINDOW_NAME,
	anchor: Astal.WindowAnchor.BOTTOM,
	application: App,
	margin: 100,
	visible: false,
	keymode: Astal.Keymode.EXCLUSIVE,
	child: Applauncher({
		width: 550,
		height: 380,
		spacing: 0,
	}),
}).keybind('Escape', close)

entry.on('key-press-event', (self, event: Gdk.Event) => {
	const key = Gdk.keyval_name(Gdk.keyval_to_upper(event.get_keyval()[1]))
	const is_forward = () => key === 'Down' //|| key === 'J' || key === 'N'
	const is_backward = () => key === 'Up' || key === 'ISO_Left_Tab' //|| key === 'K' || key === 'P'

	const select_id = (id: number) => {
		list.children[active_id]?.toggleClassName('selected', false)
		active_id = id
		print(active_id)
		// console.log)
		const entry = list.children[active_id]
		if (entry) {
			entry.toggleClassName('selected', true)
			console.log(`${entry.name}: ${entry.class_names}`)
			// try {
			// Util.ensureActorVisibleInScrollView(this.scroller, entry)
			// } catch (_error) {}
		}
	}
	const back = () => {
		if (0 < active_id) {
			select_id(active_id - 1)
		} else if (active_id == 0) {
			select_id(list.children.length - 1)
		}
	}
	const forward = () => {
		if (active_id + 1 < list.children.length) {
			select_id(active_id + 1)
		} else if (active_id + 1 == list.children.length) {
			select_id(0)
		}
	}

	if (key === 'Tab') {
		console.log('tab complete: ', active_id)
		launcher.complete(active_id)
		return true
	}
	if (is_backward()) {
		back()
		return true
	}
	if (is_forward()) {
		forward()
		return true
	}

	select_id(active_id)
})

function launch(de: JsonIPC.ResponseV.DesktopEntry) {
	let entry = de.DesktopEntry
	// console.log(`launching desktop entry ${de}`)
	const desktop_entry_id = entry.path
		.substring(entry.path.indexOf('/applications/') + 14)
		.replace('/', '-')
	// console.log(`from file: ${desktop_entry_id}`)
	execAsync(['dex', entry.path])
}
