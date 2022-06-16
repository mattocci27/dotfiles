local wezterm = require 'wezterm';

return {
  font = wezterm.font("Cousine Nerd Font"),
  use_ime = true,
  font_size = 12.0,
  line_height = 1.2,
  color_scheme = "MaterialDesignColors",
  window_background_opacity = 0.95,
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = false,
}
