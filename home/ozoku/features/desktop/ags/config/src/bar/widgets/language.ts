const flags = {
  fi: "🇫🇮",
  us: "🇺🇸",
};

export const Language = () =>
  Widget.Button({
    className: "base",
    onSecondaryClick: () => console.log("language"),
    child: Widget.Label(flags["fi"]),
  });
