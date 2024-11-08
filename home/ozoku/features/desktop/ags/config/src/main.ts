import { MprisPlayer } from "types/service/mpris";

const hyprland = await Service.import("hyprland");
const systemtray = await Service.import("systemtray");
const battery = await Service.import("battery");
const network = await Service.import("network");
const audio = await Service.import("audio");
const mpris = await Service.import("mpris");

const date = Variable("", {
  poll: [1000, 'date "+%a, %d.%m.%y | %H:%M:%S"'],
});

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

const players = mpris.bind("players");

const Media = (player: MprisPlayer) =>
  Widget.Box({
    className: "media-controls",
    children: [
      Widget.Box({
        children: [
          Widget.Button({ child: Widget.Label("󰒮") }),
          Widget.Button({ child: Widget.Label("󰐍") }),
          Widget.Button({ child: Widget.Label("󰒭") }),
        ],
      }),
      Widget.Box({
        css: player
          .bind("cover_path")
          .transform((p) => `background-image: url('${p}');`),
        children: [Widget.Label("Song - Artist")],
      }),
    ],
  });

const CenterArea = () =>
  Widget.Box({
    spacing: 8,
    children: players.as((p) => p.map(Media)),
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

const Language = () => Widget.Label("Language");
const Weather = () => Widget.Label("Weather");
const Awake = () => Widget.Label("Awake");
const Volume = () => {
  const volumeIcon = Utils.merge(
    [audio.speaker.bind("volume"), audio.speaker.bind("is_muted")],
    (volume, muted) => {
      if (muted) return "󰝟";

      const vol = volume * 100;
      if (vol >= 66) return "󰕾";
      if (vol >= 33) return "󰖀";
      return "󰕿";
    },
  );

  return Widget.Label({
    label: volumeIcon,
  });
};

const WifiIndicator = () => {
  const wifiIcon = Utils.merge(
    [network.wifi.bind("internet"), network.wifi.bind("strength")],
    (internet, strength) => {
      if (internet === "connected") {
        if (strength >= 75) return "󰤨";
        if (strength >= 50) return "󰤥";
        if (strength >= 25) return "󰤢";
        return "󰤟";
      }
      if (internet === "connecting") return "󱛇";
      return "󰤭";
    },
  );

  return Widget.Label({
    marginRight: 4,
    label: wifiIcon,
  });
};

const WiredIndicator = () => {
  const wiredIcon = network.wired.bind("internet").as((internet) => {
    if (internet === "connected") return "󰛳";
    if (internet === "connecting") return "󰛵";
    return "󰅛";
  });

  return Widget.Label({
    label: wiredIcon,
  });
};

const Network = () =>
  Widget.Stack({
    children: {
      wifi: WifiIndicator(),
      wired: WiredIndicator(),
    },
    shown: network.bind("primary").as((p) => p || "wifi"),
  });

const Battery = () => {
  const batteryIcon = Utils.merge(
    [battery.bind("charging"), battery.bind("percent")],
    (charging, percent) => {
      if (charging) return "󰂄";
      if (percent >= 100) return "󰁹";
      if (percent >= 90) return "󰂂";
      if (percent >= 80) return "󰂁";
      if (percent >= 70) return "󰂀";
      if (percent >= 60) return "󰁿";
      if (percent >= 50) return "󰁾";
      if (percent >= 40) return "󰁽";
      if (percent >= 30) return "󰁼";
      if (percent >= 20) return "󰁻";
      if (percent >= 10) return "󰁺";
      return "󰂎";
    },
  );

  return Widget.Label({
    marginRight: 4,
    visible: battery.bind("available"),
    label: batteryIcon,
  });
};

const Status = () =>
  Widget.Box({
    className: "status",
    spacing: 12,
    children: [Language(), Weather(), Awake(), Volume(), Network(), Battery()],
  });

const Clock = () =>
  Widget.Label({
    label: date.bind(),
  });

const Notifications = () =>
  Widget.Label({
    marginLeft: 2,
    marginRight: 2,
    label: "󰂚",
  });

const ClockGroup = () =>
  Widget.Box({
    className: "clock",
    spacing: 8,
    children: [Clock(), Notifications()],
  });

const RightArea = () =>
  Widget.Box({
    hpack: "end",
    spacing: 8,
    children: [SysTray(), Status(), ClockGroup()],
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
