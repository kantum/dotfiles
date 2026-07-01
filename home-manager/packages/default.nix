{
  config,
  pkgs,
  pkgs-stable,
  ...
}: {
  home.packages = with pkgs;
    [
      android-tools
      python312Packages.flask
      pipenv
      scala
      scrcpy
      awscli2
      ext4fuse
      bottom
      btop
      cmatrix
      convco # conventionnal commits
      dbeaver-bin
      dive # docker image explorer
      duf # disk usage
      dust # disk usage
      elixir_1_18
      fd
      # flyctl
      geany
      gh
      git
      git-lfs
      git-filter-repo
      glab
      gnupg
      go
      grpcurl
      htop
      imagemagick
      jq
      lua
      luarocks
      ncdu # disk usage
      fastfetch
      nh # Nix helper
      nixos-shell
      nmap
      nodejs_24
      obsidian
      ocaml
      ocamlPackages.batteries
      ocamlPackages.findlib
      ollama
      openssl
      pinentry-curses
      pkg-config
      platformio # https://github.com/NixOS/nixpkgs/pull/258358
      portaudio
      postgresql
      qemu # Emulator
      ripgrep
      lnav
      rustup
      beam28Packages.expert
      shellcheck
      stow
      texliveFull
      tree
      tui-journal
      mpv
      watch
      wget
      xh # better curl (http command)
      yt-dlp
      zstd # compression
      claude-code
      claude-code-router
      catimg
      affine
      github-copilot-cli
      uv
      # nvim checkhealth
      tree-sitter
      thunderbird
      speedtest-cli
      ghc
      cabal-install
      podman
      kind
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin [
      monitorcontrol # Control your display's brightness & volume on your Mac as if it was a native Apple Display.
      pngpaste
      pkgs-stable.libation
      vlc-bin
      libreoffice-bin
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      vlc
      libreoffice
      # firefox-bin-unwrapped
      firefox-bin
    ];
}
