import { NotificationPopups } from "./widgets/notifications";

const hyprland = await Service.import("hyprland");
export const Widgets = [NotificationPopups] as const;

type Widgets = {
  [key in (typeof Widgets)[number]["name"]]: (typeof Widgets)[number];
};

const widgets = Object.fromEntries(
  Widgets.map((widget) => [widget.name, widget])
) as Widgets;

export const toggleWidget = (widgetName: keyof typeof widgets) => {
  const widget = widgets[widgetName];

  if (widget.visible && widget.monitor === hyprland.active.monitor.id) {
    widget.hide();
    return;
  }

  widget.monitor = hyprland.active.monitor.id;

  if (!widget.visible) {
    widget.show();
  }
};

globalThis.toggleWidget = toggleWidget;
