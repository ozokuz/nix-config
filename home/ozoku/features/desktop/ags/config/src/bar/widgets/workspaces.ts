const hyprland = await Service.import("hyprland");

export const Workspaces = (monitor: number) => {
  const active = hyprland.active.workspace.bind("id");
  const workspaceClasses = (id: number) =>
    Utils.merge([active, hyprland.bind("workspaces")], (a, w) => {
      const focused = a === id ? "focused" : "";
      const ws = w.find((x) => x.id === id);
      const empty = (ws?.windows ?? 0) > 0 ? "" : "empty";
      return [focused, empty, "base"].join(" ");
    });

  const workspaces = Array.from({ length: 9 }).map((_, id) => {
    const monitorWs = monitor * 10 + id + 1;
    return Widget.Button({
      on_clicked: () =>
        hyprland.messageAsync(`dispatch workspace ${monitorWs}`),
      child: Widget.Label(`${id + 1}`),
      class_name: workspaceClasses(monitorWs),
    });
  });

  return Widget.Box({
    class_name: "workspaces",
    children: workspaces,
  });
};
