const audio = await Service.import("audio");

export const Volume = () => {
  const volumeIcon = Utils.merge(
    [audio.speaker.bind("volume"), audio.speaker.bind("is_muted")],
    (volume, muted) => {
      if (muted) return "󰝟";

      const vol = volume * 100;
      if (vol >= 66) return "󰕾";
      if (vol >= 33) return "󰖀";
      return "󰕿";
    }
  );

  return Widget.Button({
    className: "base",
    onSecondaryClick: () => console.log("Volume"),
    child: Widget.Label({
      className: "icon",
      label: volumeIcon,
    }),
  });
};
