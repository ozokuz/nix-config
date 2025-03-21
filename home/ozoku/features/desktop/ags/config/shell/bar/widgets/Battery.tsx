import { bind, Variable } from "astal";
import Battery from "gi://AstalBattery";

const battery = Battery.get_default();

const icon = Variable.derive(
  [bind(battery, "percentage"), bind(battery, "state")],
  (percent, charging) => {
    percent *= 100;
    if (charging === Battery.State.CHARGING) return "󰂄";
    if (charging === Battery.State.PENDING_CHARGE) return "󰚥";
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

export default function BatteryStatus() {
  return (
    <box>
      <label label={icon()} cssClasses={["icon"]} />
    </box>
  );
}
