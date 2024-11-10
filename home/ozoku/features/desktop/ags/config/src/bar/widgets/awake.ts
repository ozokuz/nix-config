import awake from "../../services/awake";

export const Awake = () =>
  Widget.Button({
    className: "base",
    onSecondaryClick: () => awake.toggle(),
    child: Widget.Label({
      label: awake.bind("state").as((state) => (state ? "" : "")),
    }),
  });
