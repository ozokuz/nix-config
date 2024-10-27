{pkgs,...}:
let
  lf-escape = pkgs.writeShellScriptBin "lf-escape" ''
    exec ${pkgs.gnused}/bin/sed -z 's/\\/\\\\/g;s/"/\\"/g;s/\n/\\n/g;s/^/"/;s/$/"/'
  '';
in
{
  programs.lf = {
    enable = true;

    commands = {
      dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
      mkdir = ''
      ''${{
        printf "Directory name: "
        read DIR
        mkdir $DIR
      }}
      '';
      new-file = ''
      ''${{
        printf "File name: "
        read FILE
        touch $FILE
      }}
      '';
      new-edit = ''
      ''${{
        printf "File name: "
        read FILE
        $EDITOR $FILE
      }}
      '';
      z = ''
      %{{
        result=$(zoxide query --exclude "$PWD" "$@" | ${lf-escape}/bin/lf-escape)
        lf -remote "send $id cd \"$result\""
      }}
      '';
      zi = ''
      %{{
        result=$(zoxide query -i | ${lf-escape}/bin/lf-escape)
        lf -remote "send $id cd \"$result\""
      }}
      '';
      on-cd = ''
      &{{
        ${pkgs.zoxide}/bin/zoxide add "$PWD"
        fmt="$(STARSHIP_SHELL= ${pkgs.starship}/bin/starship prompt | ${lf-escape}/bin/lf-escape)"
        lf -remote "send $id set promptfmt \"$fmt\""
      }}
      '';
      on-select = ''
      &{{
        lf -remote "send $id set statfmt \"$(eza -ld --color=always "$f" | ${lf-escape}/bin/lf-escape)\""
      }}
      '';
      trash = ''%${pkgs.trash-cli}/bin/trash-put -- $fx'';
      extract = ''
      ''${{
        set -f
        ${pkgs.ouch}/bin/ouch decompress $fx
      }}
      '';
      compress = ''
      ''${{
        set -f
        printf "Output file: "
        read FILE
        ${pkgs.ouch}/bin/ouch compress $fx $FILE &
      }}
      '';
    };

    keybindings = {
      c = "mkdir";
      "<enter>" = "open";
      D = "trash";
      do = "dragon-out";
      gsp = "cd ~/src/p";
      gss = "cd ~/src/s";
      gst = "cd ~/src/temp";
      V = ''$$${pkgs.bat}/bin/bat --paging=always --theme=gruvbox "$f"'';
      x = "new-file";
      X = "new-edit";
      zh = "";
      zr = "";
      zn = "";
      zs = "";
      zt = "";
      za = "";
      oh = "set hidden!";
      or = "set reverse!";
      on = "set info";
      os = "set info size";
      ot = "set info time";
      oa = "set info size:time";
      z = "z";
      Z = "zi";
      ax = ":extract; reload";
      ac = "compress";
    };

    settings = {
      preview = true;
      hidden = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
    };

    extraConfig =
      let
        previewer =
          pkgs.writeShellScriptBin "preview.sh" ''
          file=$1
          w=$2
          h=$3
          x=$4
          y=$5

          if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
            ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
            exit 1
          fi

          ${pkgs.pistol}/bin/pistol "$file"
        '';
        cleaner = pkgs.writeShellScriptBin "clean.sh" ''
          ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
        '';
      in
      ''
        set cleaner ${cleaner}/bin/clean.sh
        set previewer ${previewer}/bin/preview.sh
      '';
  };
}
