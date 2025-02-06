import { bind, Binding, Variable } from "astal";
import Hyprland from "gi://AstalHyprland";
import style from "./Workspaces.scss";
import { App } from "astal/gtk4";

export default function Workspaces({ monitor }: { monitor: Binding<number> }) {
  App.apply_css(style);
  const hyprland = Hyprland.get_default();
  const monitorWorkspacesData = Variable.derive(
    [
      monitor,
      bind(hyprland, "workspaces"),
      bind(hyprland, "monitors"),
      bind(hyprland, "focusedWorkspace"),
    ],
    (monitor, workspaces, monitors, focusedWorkspace) => ({
      monitor,
      workspaces,
      monitors,
      focusedWorkspace,
    })
  );

  return (
    <box cssClasses={["workspaces"]}>
      {monitorWorkspacesData().as((wsd) =>
        Array.from({ length: 9 }).map((_, n) => {
          const wsnum = wsd.monitor * 10 + n + 1;
          const ws = hyprland.get_workspace(wsnum);

          return (
            <button
              cssClasses={[
                "base",
                !ws || ws.clients.length === 0 ? "empty" : "",
                wsd.focusedWorkspace === ws ? "focused" : "",
              ].filter(Boolean)}
              onClicked={() =>
                hyprland.message_async(`dispatch workspace ${wsnum}`, () => {})
              }
            >
              {n + 1}
            </button>
          );
        })
      )}
    </box>
  );
}
