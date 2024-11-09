import { MprisPlayer } from "types/service/mpris";

const mpris = await Service.import("mpris");

const MediaInternal = (player: MprisPlayer) =>
  Widget.Box({
    className: "media-controls",
    children: [
      Widget.Box({
        className: "media-buttons",
        children: [
          Widget.Button({ on_clicked: () => player.previous(), className: "media-prev", child: Widget.Label("󰒮") }),
          Widget.Button({
            on_clicked: () => player.playPause(),
            className: "media-play",
            child: Widget.Label({
              label: player
                .bind("play_back_status")
                .as((p) => (p === "Playing" ? "󰏦" : "󰐍")),
            }),
          }),
          Widget.Button({ on_clicked: () => player.next(), className: "media-next", child: Widget.Label("󰒭") }),
        ],
      }),
      Widget.Box({
        css: player
          .bind("cover_path")
          .transform(
            (p) =>
              `background-image: linear-gradient(0deg, #777, #777), url('${p}');`
          ),
        className: "player-cover",
        children: [
          Widget.Label({
            label: Utils.merge(
              [player.bind("track_title"), player.bind("track_artists")],
              (title, artists) => `${title} - ${artists.join(", ")}`
            ),
          }),
        ],
      }),
    ],
  });

export const Media = () =>
  Widget.Box({
    children: mpris
      .bind("players")
      .as((p) => p.filter((f) => f.name === "playerctld").map(MediaInternal)),
  });
