const systemtray = await Service.import("systemtray");

const excluded = ["spotify-client", "gammastep", "Bitwarden"];
// const excluded = [] as string[];

export const SysTray = () =>
  Widget.Box({
    className: "tray",
    children: systemtray.bind("items").as((items) =>
      items
        .filter(
          (i) =>
            !excluded.includes(
              i.id === "chrome_status_icon_1" ? i.tooltip_markup : i.id
            )
        )
        .map((item) =>
          Widget.Button({
            child: Widget.Icon({ icon: item.bind("icon") }),
            onPrimaryClick: (_, event) => item.activate(event),
            onSecondaryClick: (_, event) => item.openMenu(event),
            tooltip_markup: item.bind("tooltip_markup"),
          })
        )
    ),
  });

// Utils.timeout(1000, () => {
//   console.log(systemtray.items);
// });
