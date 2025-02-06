import { bind, Variable } from "astal";
import { App } from "astal/gtk4";
import Mpris from "gi://AstalMpris";
import style from "./Media.scss";

const mpris = Mpris.get_default();
const player = mpris.players.find((p) => p.busName.endsWith("playerctld"))!;

bind(player, "coverArt").subscribe((cover) => {
  App.apply_css(`
      .cover-art {
        background-image: linear-gradient(0deg, #777, #777), url('file://${cover}');
      }
    `);
});

App.apply_css(style);

const songLabel = Variable.derive(
  [bind(player, "artist"), bind(player, "title")],
  (artist, title) => `${title} - ${artist}`
);

export default function Media() {
  return (
    <box cssClasses={["media"]}>
      <box spacing={8} cssClasses={["media-buttons"]}>
        <button cssClasses={["base"]} onClicked={() => player.previous()}>
          <label label={"󰒮"} cssClasses={["media-icon"]} />
        </button>
        <button
          cssClasses={["base", "play"]}
          onClicked={() => player.play_pause()}
        >
          <label
            label={bind(player, "playbackStatus").as((s) =>
              s === Mpris.PlaybackStatus.PLAYING ? "󰏦" : "󰐍"
            )}
            cssClasses={["media-icon"]}
          />
        </button>
        <button cssClasses={["base"]} onClicked={() => player.next()}>
          <label label={"󰒭"} cssClasses={["media-icon"]} />
        </button>
      </box>
      <box cssClasses={["cover-art"]}>
        <label label={songLabel()} cssClasses={["media-label"]} />
      </box>
    </box>
  );
}
