import { Variable } from "astal";
import { App, Astal, Gtk } from "astal/gtk4";
import style from "./PowerMenu.scss";
import { FlowBox } from "../../widgets/FlowBox";

export default function PowerMenu() {
  const visible = Variable(true);

  App.apply_css(style);

  const { TOP, BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor;
  return (
    <window
      visible={visible()}
      exclusivity={Astal.Exclusivity.IGNORE}
      anchor={TOP | BOTTOM | LEFT | RIGHT}
    >
      <box
        cssClasses={["powermenu"]}
        onButtonReleased={() => {
          visible.set(false);
        }}
      >
        <centerbox>
          <box vexpand hexpand></box>
          <centerbox orientation={Gtk.Orientation.VERTICAL}>
            <box vexpand hexpand></box>
            <FlowBox
              rowSpacing={6}
              columnSpacing={6}
              maxChildrenPerLine={5}
              hexpand
            >
              <button cssClasses={["powerbutton", "poweroff"]}>󰐥</button>
              <button cssClasses={["powerbutton", "reboot"]}></button>
              <button cssClasses={["powerbutton", "suspend"]}>󰤄</button>
              <button cssClasses={["powerbutton", "lock"]}>󰌾</button>
              <button cssClasses={["powerbutton", "logout"]}></button>
            </FlowBox>
            <box vexpand hexpand></box>
          </centerbox>
          <box vexpand hexpand></box>
        </centerbox>
      </box>
    </window>
  );
}
