import { bind, Binding, Variable } from "astal";
import Hyprland from "gi://AstalHyprland";
import style from "./Workspaces.scss";
import { App } from "astal/gtk4";
import { ButtonProps } from "astal/gtk4/widget";
import { range } from "../../utils";

type WorkspaceButtonProps = ButtonProps & {
  ws: Hyprland.Workspace;
  num: number;
};

const hyprland = Hyprland.get_default();

const moveCount = Variable(0);
hyprland.connect("client-moved", () => {
  moveCount.set(moveCount.get() + 1);
});

function WorkspaceButton({ ws, num, ...props }: WorkspaceButtonProps) {
  const classes = Variable.derive(
    [
      bind(hyprland, "focusedWorkspace"),
      bind(hyprland, "clients"),
      moveCount(),
    ],
    (fws) =>
      [
        "base",
        fws?.id === ws.id ? "focused" : "",
        hyprland.get_workspace(ws.id)?.get_clients()?.length > 0 ? "" : "empty",
      ].filter(Boolean)
  );

  return (
    <button
      cssClasses={classes()}
      onDestroy={() => classes.drop()}
      onClicked={() => ws.focus()}
      {...props}
    >
      {num}
    </button>
  );
}

export default function Workspaces({ monitor }: { monitor: Binding<number> }) {
  App.apply_css(style);
  return (
    <box cssClasses={["workspaces"]}>
      {monitor.as((m) =>
        range(9, 1).map((i) => (
          <WorkspaceButton
            ws={Hyprland.Workspace.dummy(m * 10 + i, null)}
            num={i}
          />
        ))
      )}
    </box>
  );
}
