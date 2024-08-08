{ config, lib, pkgs, ... }:

{
  imports = [
    # ./mount.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "unrelated";
  home.homeDirectory = "/home/unrelated";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = (with pkgs; [
    telegram-desktop
    keepassxc
    qbittorrent
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ] ++ (with gnomeExtensions; [
    dash-to-dock
  ]));

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/wm/keybindings" = {
        switch-applications = [];
        switch-applications-backward = [];
        switch-windows = [ "<Alt>Tab" ];
        switch-windows-backward = [ "<Shift><Alt>Tab" ];
	switch-input-source = [ "<Control>space" ];
	switch-input-source-backward = [ "<Shift><Control>space" ];
      };
      "org/gnome/shell/extensions/dash-to-dock" = {
        click-action = "minimize-or-previews";
        background-opacity = 0.80000000000000004;
        dash-max-icon-size = 48;
        dock-fixed = true;
        dock-position = "LEFT";
        extend-height = true;
        height-fraction = 0.90000000000000002;
        preferred-monitor = -2;
        preferred-monitor-by-connector = "eDP-1";
      };
      "org/gnome/nautilus/preferences" = {
        default-folder-viewer = "list-view";
      };
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
        resize-with-right-button = false;
      };
      "org/gnome/settings-deamon/plugins/media-keys" = {
        control-center = [ "<Super>i" ];
	custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
        home = [ "<Super>e" ];
      };
      "org/gtk/settings/file-chooser" = {
        show-hidden = true;
      };
      "org/gnome/Greay" = {
        run-in-background = true;
      };
      # fixme: laptop should use kp_insert, desktop should use insert
      "org/gnome/terminal/legacy/keybindings" = {
        copy = "<Primary>KP_Insert";
	paste = "<Shift>KP_Insert";
      };
      "org/gnome/desktop/input-sources" = with lib.hm.gvariant; {
        mru-sources = [ (mkTuple [ "xkb" "cn" ]) (mkTuple "ibus" "libpinyin") ];
        sources = [ (mkTuple [ "xkb" "cn" ]) (mkTuple "ibus" "libpinyin") ];
	xkb-options = [ "terminate:ctrl_alt_bksp" "lv3:ralt_switch" ];
      };
      "com/github/libpiyin/ibus-libpinyin/libpinyin" = {
        english-input-mode = false;
	lookup-table-page-size = 7;
	main-switch = "";
	punct-switch = "";
	sort-candidate-option = 0;
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Control><Alt>t";
	command = "gnome-terminal";
        name = "启动terminal";
      };
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    "下载/Aria2Downloads" = {
      source = config.lib.file.mkOutOfStoreSymlink /var/lib/aria2/Downloads;
    };
    ".ssh/id_ed25519" = {
      source = ./secrets/ssh-secret-key;
    };

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/unrelated/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
