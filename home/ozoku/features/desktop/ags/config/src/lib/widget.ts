export type NamedWidget<Name> = ReturnType<typeof Widget.Window> & {
  readonly name: Name;
};

export function NamedWidget<const Name>(
  name: Name,
  ...t: Parameters<typeof Widget.Window>
): NamedWidget<Name> {
  const opts = t[0] as any;
  opts.name = name;
  // opts.visible = false;
  return Widget.Window(opts, t[1]) as NamedWidget<Name>;
}
