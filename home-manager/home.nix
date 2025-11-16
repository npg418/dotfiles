{
  home.username = "nullp";
  home.homeDirectory = "/home/nullp";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  imports = [
    ./programs
  ];
}
