import { bind, Binding, Variable } from "astal";
import Hyprland from "gi://AstalHyprland";
import { truncate } from "../../../lib/utils";

export default function ActiveWindow({
  monitor,
}: {
  monitor: Binding<number>;
}) {
  const hyprland = Hyprland.get_default();
  const activeWindow = Variable(
    hyprland.monitors.find((m) => m.id === monitor.get())!.activeWorkspace
      .lastClient?.title ?? ""
  );
  bind(hyprland, "focusedClient").subscribe((client) => {
    if (client?.get_workspace().get_monitor().id === monitor.get()) {
      activeWindow.set(client.title ?? "");
    }
  });
  hyprland.connect("client-moved", () => {
    if (
      hyprland.monitors
        .find((m) => m.id === monitor.get())!
        .activeWorkspace.get_clients().length === 0
    ) {
      activeWindow.set("");
    }
  });

  return (
    <box
      cssClasses={activeWindow().as((t) => [t ? "pill" : ""].filter(Boolean))}
    >
      <label label={activeWindow().as(truncate)} />
    </box>
  );
}
