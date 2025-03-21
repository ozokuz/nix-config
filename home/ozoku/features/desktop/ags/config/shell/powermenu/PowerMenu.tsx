import { Variable } from "astal";
import { App, Astal, Gtk } from "astal/gtk4";
import style from "./PowerMenu.scss";
import { FlowBox } from "../../lib/widgets/FlowBox";

export default function PowerMenu() {
  const visible = Variable(true);

  App.apply_css(style);

  const { TOP, BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor;
  return (
    <window
      visible={visible()}
      layer={Astal.Layer.TOP}
      exclusivity={Astal.Exclusivity.IGNORE}
      anchor={TOP | BOTTOM | LEFT | RIGHT}
    >
      <box
        cssClasses={["transparent"]}
        onButtonReleased={() => {
          //visible.set(false);
        }}
      >
        <centerbox hexpand vexpand>
          <box vexpand hexpand></box>
          <centerbox orientation={Gtk.Orientation.VERTICAL}>
            <box vexpand hexpand></box>
            <FlowBox
              rowSpacing={6}
              columnSpacing={6}
              maxChildrenPerLine={5}
              hexpand
              cssClasses={["powermenu"]}
            >
              <button cssClasses={["powerbutton", "poweroff"]}>
                <label>󰐥</label>
              </button>
              <button cssClasses={["powerbutton", "reboot"]}>
                <label></label>
              </button>
              <button cssClasses={["powerbutton", "suspend"]}>
                <label>󰤄</label>
              </button>
              <button cssClasses={["powerbutton", "lock"]}>
                <label>󰌾</label>
              </button>
              <button cssClasses={["powerbutton", "logout"]}>
                <label></label>
              </button>
            </FlowBox>
            <box vexpand hexpand></box>
          </centerbox>
          <box vexpand hexpand></box>
        </centerbox>
      </box>
    </window>
  );
}
