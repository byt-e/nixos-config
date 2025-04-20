{ config, pkgs, lib, ... }:
{
  options.my.flatpakApps = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    description = "List of Flatpak app IDs to install from Flathub.";
  };

  config = {
    home.packages = [
      pkgs.flatpak
    ];

    home.activation.installFlatpakApps = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      flatpak="${pkgs.flatpak}/bin/flatpak"

      "$flatpak" remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

      for app in ${lib.concatStringsSep " " (map (a: "\"${a}\"") config.my.flatpakApps)}; do
        "$flatpak" install --user --or-update -y --noninteractive flathub "$app" || true
      done
    '';
  };
}

