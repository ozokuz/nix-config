import { CenterArea } from "./center";
import { LeftArea } from "./left";
import { RightArea } from "./right";

export const Bar = (monitor: number) =>
  Widget.Window({
    name: `bar-${monitor}`,
    class_name: "bar",
    anchor: ["top", "left", "right"],
    margins: [8, 0, 0, 0],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      class_name: "bar",
      start_widget: LeftArea(),
      center_widget: CenterArea(),
      end_widget: RightArea(),
    }),
  });
