import { Astal, Gtk } from "ags/gtk4";
import AstalNiri from "gi://AstalNiri";
import AstalApps from "gi://AstalApps?version=0.1";
import { createBinding, createComputed, createState, For } from "ags";
const niri = AstalNiri.get_default();

type AppButtonProps = {
  app?: AstalApps.Application;
  client: AstalNiri.Window;
};

const application = new AstalApps.Apps();

function AppButton({ app, client }: AppButtonProps) {
  const classes = createBinding(niri, "focusedWindow").as((fcsClient) => {
    const classes = ["taskbar-button"];
    if (!fcsClient || !client.app_id || !fcsClient.app_id) return classes;
    const isFocused = fcsClient.id === client?.id;
    if (isFocused) classes.push("focused");
    return classes;
  });

  return (
    <button
      onClicked={() => AstalNiri.msg.focus_window(client.id)}
      cssClasses={classes}
    >
      <label label={client.title} />
    </button>
  );
}

function WorkspaceButton({ ws }: { ws: AstalNiri.Workspace }) {
  const clients = createBinding(ws, "windows")

  return (
    <box class={"classNames"}>
      <button
        class={"workspace-button"}
        onClicked={() => {
          print(clients.get().length)
        }}
      >
        <label label={ws.idx.toString()} />
      </button>
      <box>
        <For each={clients}>
          {(client: AstalNiri.Window, i) => {
            for (const app of application.list) {
              if (
                client.app_id &&
                app.entry
                  .split(".desktop")[0]
                  .toLowerCase()
                  .match(client.app_id.toLowerCase())
              ) {
                return (<box><label label={i.as(i => i.toString())} /><AppButton app={app} client={client} /></box>);
              }
            }
            return <AppButton client={client} />;
          }}
        </For>
      </box>
    </box>
  );
}

export function Workspaces() {
  const workspaces = createBinding(niri, "workspaces");

  return (
    <box spacing={6} class={"workspaces"}
      orientation={Gtk.Orientation.VERTICAL}
    >
      <For each={workspaces}>{(ws) => <WorkspaceButton ws={ws} />}</For>
    </box>
  );
}

