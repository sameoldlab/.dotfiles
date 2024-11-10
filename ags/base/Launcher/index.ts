import { Gio, Variable } from 'astal'
import { App, Astal, Gtk, Gdk, Widget } from 'astal/gtk3'
import { execAsync } from 'astal/process'
import PopLauncher, { type JsonIPC } from '../services/launcherIPC.js'
import { ListItem } from './ListItem.js'
const WINDOW_NAME = 'launcher'

//TODO: Track context to update
const keyhint = (action: string, bind: string) => new Widget.Button({
  spacing: 2,
  vexpand: true,
},
  new Widget.Box({},
    new Widget.Label({ label: action }),
    new Widget.Label({ className: 'keybind', label: bind })
  )
)

export const active_id = Variable(0)
export const Launcher = ({ width = 650, height = 320 } = {}) => {
  const launcher = PopLauncher.get_default()
  const entries = Variable<JsonIPC.SearchResult[]>([])

  const close = () => {
    input.set_text('')
    active_id.set(0)
    launcher.interrupt()
    App.toggle_window(WINDOW_NAME)
    return true
  }
  const list = new Widget.Box({
    name: 'scrollable-box',
    vertical: true,
  },
    entries(v => v.map(ListItem)),
  )

  const input = new Widget.Entry({
    setup: () => launcher.search(''),
    onActivate: () => launcher.activate(active_id.get()),
    secondary_icon_name: entries(e => e.length > 0 && e[0].category_icon
      ? 'Name' in e[0].category_icon
        ? e[0].category_icon.Name
        : Gio.content_type_get_icon(e[0].category_icon.Mime).to_string()
      : ''),
    onChanged: (self) => {
      self.vfunc_move_cursor(Gtk.MovementStep.DISPLAY_LINE_ENDS, 100, false)
      launcher.search(self.text)
    },
    placeholder_text: 'Launch apps and send commands',
    hexpand: true,
    onKeyPressEvent: (_, event) => {
      const key = event.get_keyval()[1]

      if (key === Gdk.KEY_Tab) {
        launcher.complete(active_id.get())
        return true
      }

      const ctrl = event.get_state()[1] === Gdk.ModifierType.CONTROL_MASK
      const up = key === Gdk.KEY_Up || (ctrl && key === Gdk.KEY_k) || (ctrl && key === Gdk.KEY_p)
      const down = key === Gdk.KEY_Down || (ctrl && key === Gdk.KEY_j) || (ctrl && key === Gdk.KEY_n)

      const select = (id: number) => {
        active_id.set(id)
        const entry = list.get_children()[active_id.get()]
        if (entry) {
          // try {
          // Util.ensureActorVisibleInScrollView(this.scroller, entry)
          // } catch (_error) {}
        }
        return true
      }

      if (up)
        return (active_id.get() === 0) ? select(list.children.length - 1)
          : select(active_id.get() - 1)
      if (down)
        return (active_id.get() + 1 === list.children.length) ? select(0)
          : select(active_id.get() + 1)
    }
  })
  launcher.connect('ipc-response',
    (_, res: Exclude<JsonIPC.Response, 'Close'>) => {
      // console.log('message received is:', res)
      if ('Update' in res) entries.set(res.Update)
      else if ('Fill' in res) input.set_text(res.Fill)
      else if ('DesktopEntry' in res) {
        launch(res)
        close()
      }
      else console.warn('unhandled context', JSON.stringify(res.Context))
    }
  )
  launcher.connect('close', close)

  const Applauncher = () =>
    new Widget.Box({
      vertical: true,
      className: 'spring',
      css: ` min-width: ${width}px; `,
      // setup: self => self.hook(, (_, windowName, visible) => {
      //   console.log({ windowName, visible })
      //   if (windowName !== WINDOW_NAME) return
      // })
    },
      new Widget.Box({ name: 'top' }, input),
      new Widget.Scrollable({
        hscroll: Gtk.PolicyType.NEVER,
        visible: entries(e => e.length !== 0),
        css: entries((e) => {
          const h = e.length ? 50 * e.length + 16 : 0
          return `
            border: 0;
            padding: 0;
            transition: min-height 80ms cubic-bezier(0.76, 0, 0.24, 1);
            min-height: ${h}px;`
        }),
        hexpand: true,
      },
        entries(e => {
          if (e.length === 1 && (e[0].icon?.Name === 'accessories-calculator' || e[0].category_icon?.Name === 'utilities-terminal')) {
            new Widget.Box({
              className: 'spotlight'
            }, new Widget.Label({ label: e[0].name }))
          }
          return list
        })
        //list
      ),
      new Widget.CenterBox({
        hexpand: false,
        visible: entries(e => e.length !== 0),
        start_widget: new Widget.Box({ halign: Gtk.Align.START, }),
        end_widget: new Widget.Box(
          { halign: Gtk.Align.END, spacing: 16 },
          keyhint('Accept', '⤶'),
          keyhint('Help', '?'),
        )
      })
    )

  return new Widget.Window({
    name: WINDOW_NAME,
    anchor: Astal.WindowAnchor.TOP,
    application: App,
    margin: 300,
    visible: false,
    keymode: Astal.Keymode.EXCLUSIVE,
    child: Applauncher(),
    onKeyPressEvent(_, event) {
      if (event.get_keyval()[0] && event.get_keyval()[1] === Gdk.KEY_Escape)
        close()
    }
  })
}

function launch(de: JsonIPC.ResponseV.DesktopEntry) {
  let entry = de.DesktopEntry
  // console.log(`launching desktop entry ${de}`)
  // const desktop_entry_id = entry.path
  //   .substring(entry.path.indexOf('/applications/') + 14)
  //   .replace('/', '-')
  // console.log(`from file: ${desktop_entry_id}`)
  return execAsync(['dex', entry.path])
}
