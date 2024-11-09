import awake from "../services/awake";

const systemtray = await Service.import("systemtray");
const battery = await Service.import("battery");
const network = await Service.import("network");
const audio = await Service.import("audio");

const date = Variable("", {
  poll: [1000, 'date "+%a, %d.%m.%y | %H:%M:%S"'],
});

const weather = Variable("", {
  poll: [3600000, "ode_weather_status"],
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
        })
      )
    ),
  });

const Language = () => Widget.Label("Language");

// TODO: make weather a proper service & use an api instead of wttr.in and a script
const Weather = () =>
  Widget.Label({
    label: weather.bind().as((w) => JSON.parse(w || "{}").text || ""),
    tooltip_markup: weather
      .bind()
      .as((w) => JSON.parse(w || "{}").tooltip || ""),
  });

const Awake = () =>
  Widget.Label({
    label: awake.bind("state").as((state) => (state ? "" : "")),
  });

const Volume = () => {
  const volumeIcon = Utils.merge(
    [audio.speaker.bind("volume"), audio.speaker.bind("is_muted")],
    (volume, muted) => {
      if (muted) return "󰝟";

      const vol = volume * 100;
      if (vol >= 66) return "󰕾";
      if (vol >= 33) return "󰖀";
      return "󰕿";
    }
  );

  return Widget.Label({
    className: "icon",
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
    }
  );

  return Widget.Label({
    marginRight: 4,
    className: "icon",
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
    className: "icon",
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
    }
  );

  return Widget.Label({
    marginRight: 4,
    className: "icon",
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
    className: "icon",
    label: "󰂚",
  });

const ClockGroup = () =>
  Widget.Box({
    className: "clock",
    spacing: 8,
    children: [Clock(), Notifications()],
  });

export const RightArea = () =>
  Widget.Box({
    hpack: "end",
    spacing: 8,
    children: [SysTray(), Status(), ClockGroup()],
  });
