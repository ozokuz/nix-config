import { Variable } from "astal";
import Hyprland from "gi://AstalHyprland";

const hyprland = Hyprland.get_default();

const flags: Record<string, string> = {
  Finnish: "🇫🇮",
  "English (US)": "🇺🇸",
};
const kbLayout = Variable(flags.Finnish);

hyprland.connect("keyboard-layout", (_, _keyboard, layout) => {
  kbLayout.set(flags[layout]);
});

export default function KeyboardLayout() {
  return (
    <box>
      <label label={kbLayout()} />
    </box>
  );
}
