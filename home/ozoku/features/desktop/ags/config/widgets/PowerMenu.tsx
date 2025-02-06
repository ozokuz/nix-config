import { Variable } from "astal";
import { App, Astal } from "astal/gtk4";
import style from "./PowerMenu.scss";

export default function PowerMenu() {
  const visible = Variable(true);

  App.apply_css(style);

  const { TOP, BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor;
  return (
    <window
      visible={visible()}
      anchor={TOP | BOTTOM | LEFT | RIGHT}
      defaultWidth={960}
      defaultHeight={360}
    >
      <box cssClasses={["powermenu"]}>
        <button cssClasses={["powerbutton", "poweroff"]}>󰐥</button>
        <button cssClasses={["powerbutton", "reboot"]}></button>
        <button cssClasses={["powerbutton", "suspend"]}>󰤄</button>
        <button cssClasses={["powerbutton", "lock"]}>󰌾</button>
        <button cssClasses={["powerbutton", "logout"]}></button>
      </box>
    </window>
  );
}
