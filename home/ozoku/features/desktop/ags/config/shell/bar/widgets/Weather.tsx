import { bind } from "astal";
import { Weather } from "../../../services/Weather";

const weather = new Weather();

export default function WeatherStatus() {
  return (
    <box>
      <label
        label={bind(weather, "short")}
        tooltipMarkup={bind(weather, "long")}
      />
    </box>
  );
}
