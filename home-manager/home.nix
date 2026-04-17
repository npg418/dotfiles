{
  home.username = "nullp";
  home.homeDirectory = "/home/nullp";

  programs.home-manager.enable = true;

  imports = [
    ./programs
  ];
}
