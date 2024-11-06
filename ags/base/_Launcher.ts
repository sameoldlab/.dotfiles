import { Application } from "resource:///com/github/Aylur/ags/service/applications.js"
const { query } = await Service.import('applications')

const WINDOW_NAME = 'applauncher'

const AppItem = (app: Application) =>
	Widget.Button({
		on_clicked: () => {
			App.closeWindow(WINDOW_NAME)
			app.launch()
		},
		attribute: { app },
		child: Widget.Box({
			className: 'applauncher__item',
			children: [
				Widget.Icon({
					icon: app.icon_name || '',
					size: 32,
					className: 'icon',
				}),
				Widget.Box({
					vertical: true,
					vpack: 'center',
					children: [
						Widget.Label({
							class_name: 'title',
							label: app.name,
							xalign: 0,
							vpack: 'center',
							truncate: 'end',
						}),
						// short circuit if there is no description
						Widget.Label({
							class_name: 'description',
							label: app.description || '',
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
	let applications = query('').map(AppItem)

	const list = Widget.Box({
		vertical: true,
		children: applications,
		spacing,
	})

	// repopulate the box, so the most frequent apps are on top of the list
	function repopulate() {
		applications = query('').map(AppItem)
		list.children = applications
	}

	const entry = Widget.Entry({
		hexpand: true,
		css: `margin-bottom: ${spacing}px;`,
		className: 'applauncher__entry',

		// to launch the first item on Enter
		on_accept: ({ text }) => {
			text = text ?? ''
			if (text.startsWith(': ')) {
				App.closeWindow(WINDOW_NAME)
				Utils.exec(text.substring(2))
			}

			const results = applications.filter(item => item.visible)
			if (results[0]) {
				App.toggleWindow(WINDOW_NAME)
				applications[0].attribute.app.launch()
			}
		},

		// filter out the list
		on_change: ({ text = '' }) => {
			if (text) {
				print(text)
				if (text.startsWith('/ ')) print('search directories')
				if (text.startsWith('f ')) print('search files')
				if (text.startsWith(': ')) {
					print('execute', text.substring(1))
				}
			}

			return applications.forEach(item => {
				item.visible = item.attribute.app.match(text)
			})
		},
	})

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
					repopulate()
					entry.text = ''
					entry.grab_focus()
				}
			}),
	})
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
}).keybind('Escape', () => App.closeWindow(WINDOW_NAME))
