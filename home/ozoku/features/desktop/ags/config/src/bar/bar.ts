import { Workspaces } from "./widgets/workspaces";
import { ActiveWindow } from "./widgets/active-window";

import { Media } from "./widgets/media";

import { SysTray } from "./widgets/systray";

import { Language } from "./widgets/language";
import { Weather } from "./widgets/weather";
import { Awake } from "./widgets/awake";
import { Volume } from "./widgets/volume";
import { Network } from "./widgets/network";
import { Battery } from "./widgets/battery";

import { Clock } from "./widgets/clock";
import { Notifications } from "./widgets/notifications";

const Left1 = () =>
  Widget.Box({
    className: "pill pill-right",
    children: [Workspaces()],
  });

const Left2 = () =>
  Widget.Box({
    className: "pill",
    children: [ActiveWindow()],
  });

const Left = () =>
  Widget.Box({
    spacing: 8,
    children: [Left1(), Left2()],
  });

const Center = () =>
  Widget.Box({
    className: "pill",
    css: "padding-right: 0;",
    children: [Media()],
  });

const Right1 = () => Widget.Box({
  className: "pill",
  children: [SysTray()],
});

const Status = () =>
  Widget.Box({
    className: "pill",
    spacing: 12,
    children: [Language(), Weather(), Awake(), Volume(), Network(), Battery()],
  });

const Right2 = () =>
  Widget.Box({
    className: "pill pill-left",
    spacing: 8,
    children: [Clock(), Notifications()],
  });

export const Right = () =>
  Widget.Box({
    hpack: "end",
    spacing: 8,
    children: [Right1(), Status(), Right2()],
  });

export const Bar = (monitor: number) =>
  Widget.Window({
    name: `bar-${monitor}`,
    class_name: "bar",
    anchor: ["top", "left", "right"],
    margins: [8, 0, 0, 0],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      class_name: "bar",
      start_widget: Left(),
      center_widget: Center(),
      end_widget: Right(),
    }),
  });
