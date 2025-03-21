import { App, Astal, Gtk, Gdk } from "astal/gtk4";
import { Variable, bind } from "astal";
import Hyprland from "gi://AstalHyprland";
import style from "./Bar.scss";
import Workspaces from "./widgets/Workspaces";
import ActiveWindow from "./widgets/ActiveWindow";
import Media from "./widgets/Media";
import Clock from "./widgets/Clock";
import SysTray from "./widgets/Tray";
import BatteryStatus from "./widgets/Battery";
import WeatherStatus from "./widgets/Weather";
import NetworkStatus from "./widgets/Network";
import Volume from "./widgets/Volume";
import KeyboardLayout from "./widgets/Keyboard";
import AwakeStatus from "./widgets/Awake";

const time = Variable("").poll(1000, "date");

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  const hyprland = Hyprland.get_default();
  App.apply_css(style);

  const monitor = bind(hyprland, "monitors").as(
    (monitors) =>
      monitors?.find(
        (m) => m.name.toLowerCase() === gdkmonitor.connector.toLowerCase()
      )?.id ?? 0
  );

  return (
    <window
      visible
      cssClasses={["bar"]}
      gdkmonitor={gdkmonitor}
      marginTop={8}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={App}
    >
      <centerbox cssClasses={["bar"]}>
        <box spacing={8}>
          <box cssClasses={["pill", "pill-right"]}>
            <Workspaces monitor={monitor} />
          </box>
          <box cssClasses={["pill"]}>
            <ActiveWindow monitor={monitor} />
          </box>
        </box>
        <box cssClasses={["pill", "pill-media"]}>
          <Media />
        </box>
        <box spacing={8}>
          <box cssClasses={["pill"]}>
            <SysTray />
          </box>
          <box cssClasses={["pill"]}>
            <box spacing={8}>
              <KeyboardLayout />
              <WeatherStatus />
              <AwakeStatus />
              <Volume />
              <NetworkStatus />
              <BatteryStatus />
            </box>
          </box>
          <box cssClasses={["pill", "pill-left"]}>
            <Clock />
          </box>
        </box>
      </centerbox>
    </window>
  );
}
