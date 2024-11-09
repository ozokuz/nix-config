const hyprland = await Service.import("hyprland");

export const Workspaces = () => {
  const active = hyprland.active.workspace.bind("id");
  const workspaceClasses = (id: number) =>
    Utils.merge([active, hyprland.bind("workspaces")], (a, w) => {
      const focused = a === id + 1 ? "focused" : "";
      const ws = w.find((x) => x.id == id + 1);
      const empty = (ws?.windows ?? 0) > 0 ? "" : "empty";
      return [focused, empty].join(" ");
    });

  const workspaces = Array.from({ length: 9 }).map((_, id) =>
    Widget.Button({
      on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id + 1}`),
      child: Widget.Label(`${id + 1}`),
      class_name: workspaceClasses(id),
    })
  );

  return Widget.Box({
    class_name: "workspaces",
    children: workspaces,
  });
};
