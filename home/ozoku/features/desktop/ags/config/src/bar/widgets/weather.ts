const weather = Variable("", {
  poll: [3600000, "ode_weather_status"],
});

// TODO: make weather a proper service & use an api instead of wttr.in and a script
export const Weather = () =>
  Widget.Button({
    onSecondaryClick: () => console.log("weather"),
    className: "base",
    child: Widget.Label({
      label: weather.bind().as((w) => JSON.parse(w || "{}").text || ""),
      tooltip_markup: weather
        .bind()
        .as((w) => JSON.parse(w || "{}").tooltip || ""),
    }),
  });
