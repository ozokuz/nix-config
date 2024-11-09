const systemtray = await Service.import("systemtray");

export const SysTray = () =>
  Widget.Box({
    className: "tray",
    children: systemtray.bind("items").as((items) =>
      items.map((item) =>
        Widget.Button({
          child: Widget.Icon({ icon: item.bind("icon") }),
          onPrimaryClick: (_, event) => item.activate(event),
          onSecondaryClick: (_, event) => item.openMenu(event),
          tooltip_markup: item.bind("tooltip_markup"),
        })
      )
    ),
  });
