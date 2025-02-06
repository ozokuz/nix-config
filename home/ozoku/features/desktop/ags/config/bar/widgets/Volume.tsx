import { bind, Variable } from "astal";
import Wp from "gi://AstalWp";

const audio = Wp.get_default()?.audio!;

function icon(speakers: { volume: number; mute: boolean }) {
  speakers.volume *= 100;
  if (speakers.mute) return "󰝟";
  if (speakers.volume >= 66) return "󰕾";
  if (speakers.volume >= 33) return "󰖀";
  return "󰕿";
}

let lastVolumeSub: Function | null;
let lastMuteSub: Function | null;
let lastVolume: number;
let combined: Variable<{ volume: number; mute: boolean }>;
let audioIcon = Variable({ volume: 0, mute: true });

function sub(s: Wp.Endpoint) {
  lastVolumeSub = bind(s, "volume").subscribe((volume) => {
    lastVolume = volume;
    audioIcon.set({ volume, mute: false });
  });

  lastMuteSub = bind(s, "mute").subscribe((mute) => {
    audioIcon.set({
      volume: lastVolume,
      mute,
    });
  });

  audioIcon.set({ volume: s.get_volume(), mute: s.get_mute() });
}

bind(audio, "defaultSpeaker").subscribe((s) => {
  if (lastMuteSub) {
    lastMuteSub();
    lastMuteSub = null;
  }
  if (lastVolumeSub) {
    lastVolumeSub();
    lastVolumeSub = null;
  }

  sub(s);
});

sub(audio.defaultSpeaker);

export default function Volume() {
  return (
    <box>
      <label label={audioIcon().as(icon)} cssClasses={["icon"]} />
    </box>
  );
}
