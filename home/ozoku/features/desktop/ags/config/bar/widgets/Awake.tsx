import { bind } from "astal";
import { Awake } from "../../services/Awake";

const awake = new Awake();

function awakeIcon(state: boolean) {
  if (state) return "";
  return "";
}

export default function AwakeStatus() {
  return (
    <box>
      <button onButtonPressed={(self, event) => {}}>
        <label
          label={bind(awake, "state").as(awakeIcon)}
          cssClasses={["icon"]}
        />
      </button>
    </box>
  );
}
