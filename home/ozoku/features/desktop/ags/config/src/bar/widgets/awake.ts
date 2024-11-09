import awake from "../../services/awake";

export const Awake = () =>
  Widget.Label({
    label: awake.bind("state").as((state) => (state ? "" : "")),
  });
