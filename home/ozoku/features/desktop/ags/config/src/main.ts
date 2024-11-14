import Gtk from "types/@girs/gtk-3.0/gtk-3.0";
import { Bar } from "./bar/bar";
import { Widgets } from "./widgets";
import Gdk from "gi://Gdk";

const hyprland = await Service.import("hyprland");

function forMonitors(widget: (monitor: number) => Gtk.Window) {
  const n = Gdk.Display.get_default()?.get_n_monitors() ?? 1;
  return Array.from({ length: n }, (_, i) => widget(i));
}

App.config({
  windows: () => [...forMonitors(Bar), ...Widgets],
  style: "./src/style.css",
});

hyprland.connect("monitor-added", (_, name: string) => {
  Utils.timeout(100, () => {
    const monitor = hyprland.monitors.find((m) => m.name === name)?.id;
    if (!monitor) return;

    App.addWindow(Bar(monitor));
  });
});

Utils.timeout(100, () =>
  Utils.notify({
    summary: "Notification Popup Example",
    iconName: "help-about",
    body:
      "Lorem ipsum dolor sit amet, qui minim labore adipisicing " +
      "minim sint cillum sint consectetur cupidatat.",
    actions: {
      Cool: () => print("pressed Cool"),
    },
  })
);
