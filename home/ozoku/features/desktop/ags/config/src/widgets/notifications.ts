import { Notification as AGSNotification } from "types/service/notifications";
import { currentMonitor, NamedWidget } from "../lib/widget";

const notifications = await Service.import("notifications");

function NotificationIcon({ app_entry, app_icon, image }: AGSNotification) {
  if (image) {
    return Widget.Box({
      css:
        `background-image: url("${image}");` +
        "background-size: contain;" +
        "background-repeat: no-repeat;" +
        "background-position: center;",
    });
  }

  let icon = "help-about";
  if (Utils.lookUpIcon(app_icon)) icon = app_icon;

  if (app_entry && Utils.lookUpIcon(app_entry)) icon = app_entry;

  return Widget.Box({
    child: Widget.Icon(icon),
  });
}

const Notification = (n: AGSNotification) => {
  const icon = Widget.Box({
    vpack: "start",
    className: "notification-icon",
    child: NotificationIcon(n),
  });

  const title = Widget.Label({
    className: "notification-title",
    xalign: 0,
    justification: "left",
    hexpand: true,
    maxWidthChars: 24,
    truncate: "end",
    wrap: true,
    label: n.summary,
    useMarkup: true,
  });

  const body = Widget.Label({
    className: "notification-body",
    hexpand: true,
    useMarkup: true,
    xalign: 0,
    justification: "left",
    wrap: true,
    label: n.body,
  });

  const actions = Widget.Box({
    className: "notification-actions",
    children: n.actions.map(({ id, label }) =>
      Widget.Button({
        className: "notification-action",
        onClicked: () => {
          n.invoke(id);
          n.dismiss();
        },
        hexpand: true,
        child: Widget.Label({ label }),
      })
    ),
  });

  return Widget.EventBox({
    attribute: { id: n.id },
    onPrimaryClick: n.dismiss,
    child: Widget.Box({
      vertical: true,
      className: ["notification", n.urgency].join(" "),
      children: [
        Widget.Box({
          children: [
            icon,
            Widget.Box({
              vertical: true,
              children: [title, body],
            }),
          ],
        }),
        actions,
      ],
    }),
  });
};

const list = Widget.Box({
  vertical: true,
  children: notifications.popups.map(Notification),
});

export const NotificationPopups = NamedWidget("notifications", {
  className: "notification-popups",
  anchor: ["top", "right"],
  child: Widget.Box({
    css: "min-width: 2px; min-height: 2px;",
    class_name: "notifications",
    vertical: true,
    child: list,
  }),
});

function onNotified(_, id: number) {
  const n = notifications.getNotification(id);
  if (!n) return;
  NotificationPopups.monitor = currentMonitor();
  list.children = [Notification(n), ...list.children];
}

function onDismissed(_, id: number) {
  list.children.find((c) => c.attribute.id === id)?.destroy();
}

list
  .hook(notifications, onNotified, "notified")
  .hook(notifications, onDismissed, "dismissed");
