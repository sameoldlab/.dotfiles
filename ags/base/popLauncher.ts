import Gdk from 'gi://Gdk?version=3.0'
import Gio from 'gi://Gio'
import launcher from './services/launcherIPC.js'
import type { JsonIPC } from './services/launcherIPC.js'
const WINDOW_NAME = 'poplauncher'

let active_id = 0
const EntryItem = (res: JsonIPC.SearchResult) =>
	Widget.EventBox({
		on_primary_click: () => launcher.activate(res.id),
		
		className: 'applauncher__item',
		name: res.name,
		child: Widget.Box({
			children: [
				Widget.Icon({
					icon: res.category_icon
						? 'Name' in res.category_icon
							? res.category_icon.Name
							: Gio.content_type_get_icon(res.category_icon.Mime).names[1]
						: '',
					size: 16,
					className: 'icon category_icon',
				}),
				Widget.Icon({
					icon: res.icon
						? 'Name' in res.icon
							? res.icon.Name
							: Gio.content_type_get_icon(res.icon.Mime).names[1]
						: '',
					size: 28,
					className: 'icon',
				}),
				Widget.Box({
					vertical: true,
					vpack: 'center',
					children: [
						Widget.Label({
							class_name: 'title',
							label: res.name,
							xalign: 0,
							vpack: 'center',
							truncate: 'end',
						}),
						// short circuit if there is no description
						Widget.Label({
							class_name: 'description',
							label: res.description || '',
							wrap: true,
							xalign: 0,
							justification: 'left',
							vpack: 'center',
						}),
					],
				}),
			],
		}),
	})

const entries = Variable<JsonIPC.SearchResult[]>([])

const close = () => {
	console.log('popLauncher: CLOSE')
	entry.text = ''
	launcher.interrupt()
	active_id = 0
	App.closeWindow(WINDOW_NAME)
}
const list = Widget.Box({
	vertical: true,
	children: entries.bind().as(v => v.map(EntryItem)),
	spacing: 0,
})

const entry = Widget.Entry({
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
	Widget.Box({
		vertical: true,
		className: 'applauncher',
		css: `margin: ${spacing * 2}px;`,
		children: [
			entry,
			// wrap the list in a scrollable
			Widget.Scrollable({
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
export default Widget.Window({
	name: WINDOW_NAME,
	anchor: ['bottom'],
	margins: [100],
	visible: false,
	keymode: 'exclusive',
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
	Utils.execAsync(['dex', entry.path])
}
