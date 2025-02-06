const battery = await Service.import("battery");

export const Battery = () => {
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

  return Widget.Button({
    onSecondaryClick: () => console.log("Battery clicked"),
    className: "base",
    child: Widget.Label({
      marginRight: 4,
      className: "icon",
      visible: battery.bind("available"),
      label: batteryIcon,
    }),
  });
};
