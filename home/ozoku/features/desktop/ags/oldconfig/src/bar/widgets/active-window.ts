const hyprland = await Service.import("hyprland");

const maxTitleLength = 50;

export const ActiveWindow = () =>
  Widget.Label({
    class_name: "active-window",
    label: hyprland.active.client
      .bind("title")
      .as((title) =>
        title.length > maxTitleLength
          ? title.substring(0, maxTitleLength) + "..."
          : title
      ),
  });
