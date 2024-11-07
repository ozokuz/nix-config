const hyprland = await Service.import("hyprland");
const systemtray = await Service.import("systemtray");

const Workspaces = () => {
  const active = hyprland.active.workspace.bind("id");
  const workspaceClasses = (id: number) =>
    Utils.merge([active, hyprland.bind("workspaces")], (a, w) => {
      const focused = a === id + 1 ? "focused" : "";
      const ws = w.find((x) => x.id == id + 1);
      const empty = (ws?.windows ?? 0) > 0 ? "" : "empty";
      return [focused, empty].join(" ");
    });

  const workspaces = Array.from({ length: 9 }).map((_, id) =>
    Widget.Button({
      on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id + 1}`),
      child: Widget.Label(`${id + 1}`),
      class_name: workspaceClasses(id),
    }),
  );

  return Widget.Box({
    class_name: "workspaces",
    children: workspaces,
  });
};

const maxTitleLength = 50;

const ActiveWindow = () =>
  Widget.Label({
    class_name: "active-window",
    label: hyprland.active.client
      .bind("title")
      .as((title) =>
        title.length > maxTitleLength
          ? title.substring(0, maxTitleLength) + "..."
          : title,
      ),
  });

const LeftArea = () =>
  Widget.Box({
    spacing: 8,
    children: [Workspaces(), ActiveWindow()],
  });

const CenterArea = () =>
  Widget.Box({
    spacing: 8,
    children: [Widget.Label("Hello"), Widget.Label("Hello")],
  });

const date = Variable("", {
  poll: [1000, 'date "+%a, %d.%m.%y | %H:%M:%S"'],
});

const SysTray = () =>
  Widget.Box({
    className: "tray",
    children: systemtray.bind("items").as((items) =>
      items.map((item) =>
        Widget.Button({
          child: Widget.Icon({ icon: item.bind("icon") }),
          onPrimaryClick: (_, event) => item.activate(event),
          onSecondaryClick: (_, event) => item.openMenu(event),
          tooltip_markup: item.bind("tooltip_markup"),
        }),
      ),
    ),
  });

const Clock = () =>
  Widget.Label({
    className: "clock",
    label: date.bind(),
  });

const RightArea = () =>
  Widget.Box({
    hpack: "end",
    spacing: 8,
    children: [SysTray(), Widget.Label("Hello"), Clock()],
  });

const Bar = (monitor: number) =>
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

const cssFile = "./style.css";

App.config({
  windows: [Bar(0)],
  style: cssFile,
});

Utils.monitorFile(cssFile, () => {
  App.resetCss();
  App.applyCss(cssFile);
});
