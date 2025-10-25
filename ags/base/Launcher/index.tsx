import { Astal, Gtk, Gdk } from 'ags/gtk4'
import { execAsync } from 'ags/process'
import PopLauncher, { type JsonIPC } from '../services/launcherIPC.js'
import { ListItem } from './ListItem.js'
import { createState, For } from 'ags'
import Gio from 'gi://Gio'
import app from 'ags/gtk4/app'
const WINDOW_NAME = 'launcher'

//TODO: Track context to update
const Keyhint = (opt: { action: string, bind: string }) => <button spacing={2} vexpand={true} >
  <box>
    <label label={opt.action} />
    <label class={'keybind'} label={opt.bind} />
  </box>
</button>

export const [active_id, set_active_id] = createState(0)
export const Launcher = ({ width = 650, height = 320 } = {}) => {
  const launcher = PopLauncher.get_default()
  const [entries, setEntries] = createState<JsonIPC.SearchResult[]>([])
  const [text, set_text] = createState('')

  const close = () => {
    Input.set_text('')
    set_active_id(0)
    launcher.interrupt()
    app.toggle_window(WINDOW_NAME)
    return true
  }

  const List = <box name={'scrollable-box'} orientation={Gtk.Orientation.VERTICAL} >
    <For each={entries}> {ListItem} </For>
  </box>

  const Input = () => <entry
    $={() => launcher.search('')}
    text={text}
    onActivate={() => launcher.activate(active_id.get())}
    secondary_icon_name={entries(e => e.length > 0 && e[0].category_icon
      ? 'Name' in e[0].category_icon
        ? e[0].category_icon.Name
        : Gio.content_type_get_icon(e[0].category_icon.Mime).to_string() ?? ''
      : '')}
    onNotifyText={(self, c) => {
      self.vfunc_move_cursor(Gtk.MovementStep.DISPLAY_LINE_ENDS, 100, false)
      launcher.search(self.text)
    }}
    onChanged={(self) => {
    }}
    placeholder_text={'Launch apps and send commands'}
    hexpand={true}
    onKeyPressed={(_, event) => {
      const key = event.get_keyval()[1]

      if (key === Gdk.KEY_Tab) {
        launcher.complete(active_id.get())
        return true
      }

      const ctrl = event.get_state()[1] === Gdk.ModifierType.CONTROL_MASK
      const up = key === Gdk.KEY_Up || (ctrl && key === Gdk.KEY_k) || (ctrl && key === Gdk.KEY_p)
      const down = key === Gdk.KEY_Down || (ctrl && key === Gdk.KEY_j) || (ctrl && key === Gdk.KEY_n)

      const select = (id: number) => {
        set_active_id(id)
        const entry = entries.get()[active_id.get()]
        if (entry) {
          // try {
          // Util.ensureActorVisibleInScrollView(this.scroller, entry)
          // } catch (_error) {}
        }
        return true
      }

      if (up)
        return (active_id.get() === 0) ? select(entries.get().length - 1)
          : select(active_id.get() - 1)
      if (down)
        return (active_id.get() + 1 === entries.get().length) ? select(0)
          : select(active_id.get() + 1)
    }}
  />

  launcher.connect('ipc-response',
    (_, res: Exclude<JsonIPC.Response, 'Close'>) => {
      // console.log('message received is:', res)
      if ('Update' in res) setEntries(res.Update)
      else if ('Fill' in res) Input.set_text(res.Fill)
      else if ('DesktopEntry' in res) {
        launch(res)
        close()
      }
      else console.warn('unhandled context', JSON.stringify(res.Context))
    }
  )
  launcher.connect('close', close)

  const Applauncher = () => <box
    orientation={Gtk.Orientation.VERTICAL}
    class={'spring'}
    css={` min-width=${width}px; `}
  // setup: self => self.hook(, (_, windowName, visible) => {
  //   console.log({ windowName, visible })
  //   if (windowName !== WINDOW_NAME) return
  // })
  >
    <box name={'top'}>
      <Input />
    </box>
    <scrolledwindow
      hscroll={Gtk.PolicyType.NEVER}
      visible={entries(e => e.length !== 0)}
      css={entries((e) => {
        const h = e.length ? 50 * e.length + 16 : 0
        return `
              border: 0;
              padding: 0;
              transition: min-height 80ms cubic-bezier(0.76, 0, 0.24, 1);
              min-height: ${h}px;`
      })}
      hexpand={true}
    >
      {entries(e => {
        if (e.length === 1 && (e[0].icon?.Name === 'accessories-calculator' || e[0].category_icon?.Name === 'utilities-terminal')) {
          new Widget.Box({
            className: 'spotlight'
          }, new Widget.Label({ label: e[0].name }))
        }
        return List
      })
      }          //list
    </scrolledwindow>
    <centerbox
      hexpand={false}
      visible={entries(e => e.length !== 0)}
    >
      <box $type='end' halign={Gtk.Align.END} spacing={16} >
        <Keyhint action='Accept' bind='⤶' />
        <Keyhint action='Help' bind='?' />
      </box>
    </centerbox>
  </box>

  return <window
    name={WINDOW_NAME}
    anchor={Astal.WindowAnchor.TOP}
    application={app}
    margin={300}
    visible={false}
    keymode={Astal.Keymode.EXCLUSIVE}
    onKeyPressed={(_, event) => {
      if (event.get_keyval()[0] && event.get_keyval()[1] === Gdk.KEY_Escape)
        close()
    }}
  >
    <Applauncher />
  </window>
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
