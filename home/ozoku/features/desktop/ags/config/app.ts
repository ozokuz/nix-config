import { App } from "astal/gtk4";
import Hyprland from "gi://AstalHyprland";
import style from "./style.scss";
import Bar from "./bar/Bar";
import PowerMenu from "./widgets/PowerMenu";

App.start({
  css: style,
  main() {
    App.get_monitors().map(Bar);
    //PowerMenu();
  },
});

const h = Hyprland.get_default();
h.connect("monitor-added", (_, m) => {
  const mon = App.get_monitors().filter((g) => g.connector === m.name)[0];
  Bar(mon);
});
