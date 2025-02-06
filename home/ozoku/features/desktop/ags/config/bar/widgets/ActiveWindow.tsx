import { bind, Binding, Variable } from "astal";
import Hyprland from "gi://AstalHyprland";

function truncate(text: string) {
  if (text.length > 50) {
    return text.substring(0, 50) + "...";
  }
  return text;
}

export default function ActiveWindow({
  monitor,
}: {
  monitor: Binding<number>;
}) {
  const hyprland = Hyprland.get_default();
  const activeWindow = Variable(
    truncate(
      hyprland.monitors.find((m) => m.id === monitor.get())!.activeWorkspace
        .lastClient?.title ?? ""
    )
  );
  bind(hyprland, "focusedClient").subscribe((client) => {
    if (client?.get_workspace().get_monitor().id === monitor.get()) {
      activeWindow.set(truncate(client.title));
    }
  });

  return (
    <box>
      <label label={activeWindow()} />
    </box>
  );
}
