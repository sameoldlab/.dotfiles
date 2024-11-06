import { Gio } from 'astal'
import { Widget } from "astal/gtk3"
import Launcher from '../services/launcherIPC.js'
import type { JsonIPC } from '../services/launcherIPC.js'
const launcher = Launcher.get_default()

export const ListItem = (res: JsonIPC.SearchResult) =>
	new Widget.EventBox({
		on_primary_click: () => launcher.activate(res.id),

		className: 'applauncher__item',
		name: res.name,
		child: new Widget.Box({
			children: [
				new Widget.Icon({
					icon: res.category_icon
						? 'Name' in res.category_icon
							? res.category_icon.Name
							: Gio.content_type_get_icon(res.category_icon.Mime).names[1]
						: '',
					size: 16,
					className: 'icon category_icon',
				}),
				new Widget.Icon({
					icon: res.icon
						? 'Name' in res.icon
							? res.icon.Name
							: Gio.content_type_get_icon(res.icon.Mime).names[1]
						: '',
					size: 28,
					className: 'icon',
				}),
				new Widget.Box({
					vertical: true,
					vpack: 'center',
					children: [
						new Widget.Label({
							class_name: 'title',
							label: res.name,
							xalign: 0,
							vpack: 'center',
							truncate: true,
						}),
						// short circuit if there is no description
						new Widget.Label({
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
