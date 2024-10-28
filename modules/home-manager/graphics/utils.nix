{
  config,
  lib,
  ...
}: rec {
  displayNames = lib.map (d: d.port) (lib.filter (d: d.port != "") config.ozoku.displays);
  workspacesForDisplay = index: lib.map (workspace: workspace + (index * 10)) (lib.range 1 config.ozoku.workspaces);
  displayWorkspaces =
    lib.imap0 (index: name: {
      inherit name;
      value = workspacesForDisplay index;
    })
    displayNames;
}
