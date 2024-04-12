import launcher from './services/launcherIPC.js'
import type { JsonIPC } from './services/launcherIPC.js'

const WINDOW_NAME = 'poplauncher'

const EntryItem = (res: JsonIPC.SearchResult) =>
	Widget.Button({
		on_clicked: () => {
			console.info(`clicked: ${res.name}`)
			launcher.activate(res.id)
		},
		on_primary_click: () => {
			console.info(`clicked: ${res.name}`)
			launcher.activate(res.id)
		},
		/* 
		on_secondary_click: () => {
			console.info(`clicked: ${res.name}`)
			launcher.activate_context(res.id, 1)
		}, */
		child: Widget.Box({
			className: 'applauncher__item',
			children: [
				Widget.Icon({
					icon: res.category_icon?.Name || res.category_icon?.Mime || '',
					size: 16,
					className: 'icon',
				}),
				Widget.Icon({
					icon: res.icon?.Name || res.icon?.Mime || '',
					size: 32,
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

const Applauncher = ({ width = 500, height = 500, spacing = 12 } = {}) => {
	let entries: JsonIPC.SearchResult[]

	const close = () => {
		console.info('CLOSE')
		entry.text = ''
		launcher.interrupt()
		App.closeWindow(WINDOW_NAME)
	}

	const list = Widget.Box({
		vertical: true,
		spacing,
	})

	const entry = Widget.Entry({
		on_accept: ({ text }) => {
			// const results = applications.query(text || '')
			// if (results[0]) {
			// App.toggleWindow(WINDOW_NAME)
			// results[0].launch()

			// }
			launcher.activate(entries[0].id)
		},
		on_change: ({ text }) => {
			text = text ?? ''
			print(text)
			launcher.search(text)
		},
		hexpand: true,
		css: `margin-bottom: ${spacing}px;`,
		className: 'applauncher__entry',
	})

	launcher.connect('new-response', (service, res: Exclude<JsonIPC.Response, "Close">) => {
		// console.log('message received is:', res)
		if ('Update' in res) {
			entries = res.Update
			list.children = entries.map(EntryItem)
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
	})

	launcher.connect('close', close)

	return Widget.Box({
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
			}),
		],
		setup: self =>
			self.hook(App, (_, windowName, visible) => {
				if (windowName !== WINDOW_NAME) return

				// when the applauncher shows up
				if (visible) {
					// entry.text = ''
					entry.grab_focus()
					launcher.search(' ')
				}
			}),
	}).keybind('Escape', close)
}

export default Widget.Window({
	name: WINDOW_NAME,
	visible: false,
	keymode: 'exclusive',
	child: Applauncher({
		width: 600,
		height: 400,
		spacing: 0,
	}),
})

function launch(de: JsonIPC.ResponseV.DesktopEntry) {
	let entry = de.DesktopEntry
	// console.log(`launching desktop entry ${de}`)
	const desktop_entry_id = entry.path
		.substring(entry.path.indexOf('/applications/') + 14)
		.replace('/', '-')
	// console.log(`from file: ${desktop_entry_id}`)
	Utils.execAsync(['gtk-launch', desktop_entry_id])
}
