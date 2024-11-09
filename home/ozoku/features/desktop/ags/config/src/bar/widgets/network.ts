const network = await Service.import("network");

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

export const Network = () =>
  Widget.Stack({
    children: {
      wifi: WifiIndicator(),
      wired: WiredIndicator(),
    },
    shown: network.bind("primary").as((p) => p || "wifi"),
  });
