import { Gtk } from "ags/gtk4";
import Niri from "gi://AstalNiri";
import AstalApps from "gi://AstalApps?version=0.1";
import { createBinding, For } from "ags";
const niri = Niri.get_default();

type AppButtonProps = {
  app?: AstalApps.Application;
  client: Niri.Window;
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
      onClicked={() => Niri.msg.focus_window(client.id)}
      cssClasses={classes}
    >
      <overlay>
        <image icon_name={app?.icon_name} />
      </overlay>
    </button>
  );
}

function WorkspaceButton({ ws }: { ws: Niri.Workspace }) {
  const clients = createBinding(ws, "windows")
  return (
    <box class={"classNames"}>
      <button
        class={"workspace-button"}
        onClicked={() => {
          ws.focus()
        }}
      >
        <label label={ws.idx.toString()} />
      </button>
      <box>
        <For each={clients}>
          {(client: Niri.Window) => {
            for (const app of application.list) {
              if (
                client.app_id &&
                app.entry
                  .split(".desktop")[0]
                  .toLowerCase()
                  .match(client.app_id.toLowerCase())
              ) {
                return <AppButton app={app} client={client} />;
              }
            }
            return <AppButton client={client} />;
          }}
        </For>
      </box>
    </box>
  );
}

export default function() {
  const workspaces = createBinding(niri, "workspaces");

  return (
    <box spacing={6} class={"workspaces"}
      orientation={Gtk.Orientation.HORIZONTAL}
    >
      <For each={workspaces}>{(ws) => <WorkspaceButton ws={ws} />}</For>
    </box>
  );
}

