import { bind } from "astal";
import { Awake } from "../../services/Awake";
import { App } from "astal/gtk4";
import style from "./Awake.scss";

const awake = new Awake();

function awakeIcon(state: boolean) {
  if (state) return "";
  return "";
}

App.apply_css(style);

export default function AwakeStatus() {
  return (
    <box>
      <button
        cssClasses={["base", "awake"]}
        onButtonPressed={(self, event) => {}}
      >
        <label
          label={bind(awake, "state").as(awakeIcon)}
          cssClasses={["icon"]}
        />
      </button>
    </box>
  );
}
