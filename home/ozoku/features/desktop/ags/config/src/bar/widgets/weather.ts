import weather from "../../services/weather";

export const Weather = () =>
  Widget.Button({
    onSecondaryClick: () => console.log("weather"),
    className: "base",
    child: Widget.Label({
      label: weather.bind("short"),
      tooltip_markup: weather.bind("long"),
    }),
  });
