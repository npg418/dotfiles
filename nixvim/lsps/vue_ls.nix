{ pkgs, lib, ... }:
{
  lsp.servers = {
    vue_ls = {
      enable = true;
      packageFallback = true;
    };
    ts_ls.config = {
      filetypes = lib.mkAfter [
        "vue"
      ];
      init_options = {
        plugins = [
          {
            name = "@vue/typescript-plugin";
            location = "${pkgs.vue-language-server}/lib/language-tools/packages/language-server";
            languages = [ "vue" ];
          }
        ];
      };
    };
  };
}
