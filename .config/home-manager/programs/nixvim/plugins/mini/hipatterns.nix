{ nixvim, ... }:
{
  programs.nixvim.plugins.mini.modules.hipatterns = {
    hilighters = {
      fixme = {
        pattern = "%f[%w]()FIXME()%f[%w]";
        group = "MiniHipatternsFixme";
      };
      hack = {
        pattern = "%f[%w]()HACK()%f[%w]";
        group = "MiniHipatternsHack";
      };
      todo = {
        pattern = "%f[%w]()TODO()%f[%w]";
        group = "MiniHipatternsTodo";
      };
      note = {
        pattern = "%f[%w]()NOTE()%f[%w]";
        group = "MiniHipatternsNote";
      };
      fuck = {
        pattern = "%f[%w]()FUCK()%f[%w]";
        group = "MiniHipatternsFixme";
      };

      hex_color = nixvim.mkRaw "require(\"mini.hipatterns\").gen_highlighter.hex_color()";
    };
  };
}
