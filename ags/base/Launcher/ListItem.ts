import PopLauncher, { type JsonIPC } from '../services/launcherIPC.js'
import { Widget, Gtk } from "astal/gtk3"
import { Gio } from 'astal'
import { active_id } from './index.js'

export const ListItem = (res: JsonIPC.SearchResult, i: number) => {
  const launcher = PopLauncher.get_default()
  return new Widget.EventBox({
    on_click: () => launcher.activate(res.id),

    name: res.name,
    child: new Widget.Box({
      className: 'applauncher__item',
      setup(self) {
        self.toggleClassName('selected', i === active_id.get())
        self.hook(active_id, () => {
          self.toggleClassName('selected', i === active_id.get())
          if (i === active_id.get())
            console.log('scroll parent??')
        })
      },
      children: [
        /* new Widget.Icon({
          icon: res.category_icon
            ? 'Name' in res.category_icon
              ? res.category_icon.Name
              : Gio.content_type_get_icon(res.category_icon.Mime).names[1]
            : '',
          size: 16,
          className: 'icon category_icon',
        }), */
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
          valign: Gtk.Align.CENTER,
          children: [
            new Widget.Label({
              className: 'title',
              label: res.name,
              xalign: 0,
              valign: Gtk.Align.CENTER,
              truncate: true,
            }),
            // short circuit if there is no description
            new Widget.Label({
              className: 'description',
              label: res.description || '',
              wrap: true,
              xalign: 0,
              justify: Gtk.Justification.LEFT,
              valign: Gtk.Align.CENTER,
            }),
          ],
        }),
      ],
    }),
  })
}
