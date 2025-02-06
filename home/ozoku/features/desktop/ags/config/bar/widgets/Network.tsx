import { bind, Variable } from "astal";
import Network from "gi://AstalNetwork";

const network = Network.get_default();

const netInfo = Variable.derive(
  [
    bind(network, "primary"),
    bind(network, "wifi"),
    bind(network, "connectivity"),
  ],
  (primary, wifi, connectivity) => ({ primary, wifi, connectivity })
);

function logo(network: {
  primary: Network.Primary;
  wifi: Network.Wifi;
  connectivity: Network.Connectivity;
}) {
  if (network.primary === Network.Primary.WIRED) {
    if (network.connectivity === Network.Connectivity.FULL) return "󰈁";
    if (network.connectivity === Network.Connectivity.LIMITED) return "󰈂";
    return "󰅖";
  } else if (network.primary === Network.Primary.WIFI) {
    if (network.connectivity === Network.Connectivity.FULL) {
      if (network.wifi.strength >= 80) return "󰤨";
      if (network.wifi.strength >= 60) return "󰤥";
      if (network.wifi.strength >= 40) return "󰤢";
      if (network.wifi.strength >= 20) return "󰤟";
      return "󰤯";
    }
    if (network.connectivity === Network.Connectivity.LIMITED) {
      if (network.wifi.strength >= 80) return "󰤩";
      if (network.wifi.strength >= 60) return "󰤦";
      if (network.wifi.strength >= 40) return "󰤣";
      if (network.wifi.strength >= 20) return "󰤠";
      return "󰤫";
    }
    return "󰤮";
  } else {
    return "󰅖";
  }
}

export default function NetworkStatus() {
  return (
    <box>
      <label label={netInfo().as(logo)} cssClasses={["icon"]} />
    </box>
  );
}
