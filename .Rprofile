rm(list = ls()) # This clears everything from memory.
# cran 
local({
  r = getOption("repos")
  #r["CRAN"] = "https://mirror.lzu.edu.cn/CRAN/"
  r["CRAN"] = "https://ftp.yz.yamagata-u.ac.jp/pub/cran/"
  options(repos = r,
  browser = "brave")
})

# read packages
options(
  defaultPackages=c(getOption("defaultPackages"),"tidyverse", "rmarkdown"),
  blogdown.generator = "jekyll",
  blogdown.method = "custom",
  blogdown.subdir = "assets",

  # radian
  # see https://help.farbox.com/pygments.html
  # for a list of supported color schemes, default scheme is "native"
  #radian.color_scheme = "native",

  # either  `"emacs"` (default) or `"vi"`.
  radian.editing_mode = "vi",

  # indent continuation lines
  # turn this off if you want to copy code without the extra indentation;
  # but it leads to less elegent layout
  radian.indent_lines = TRUE,

  # auto match brackets and quotes
  radian.auto_match = FALSE,

  # auto indentation for new line and curly braces
  radian.auto_indentation = TRUE,
  radian.tab_size = 4,

  # pop up completion while typing
  radian.complete_while_typing = TRUE,
  # timeout in seconds to cancel completion if it takes too long
  # set it to 0 to disable it
  radian.completion_timeout = 0.05,

  # automatically adjust R buffer size based on terminal width
  radian.auto_width = TRUE,

  # insert new line between prompts
  radian.insert_new_line = TRUE,

  # when using history search (ctrl-r/ctrl-s in emacs mode), do not show duplicate results
  radian.history_search_no_duplicates = FALSE,

  # custom prompt for different modes
  radian.prompt = "\033[0;34mr$>\033[0m ",
  radian.shell_prompt = "\033[0;31m#!>\033[0m ",
  radian.browse_prompt = "\033[0;33mBrowse[{}]>\033[0m ",

  # supress the loading message for reticulate
  radian.suppress_reticulate_message = FALSE,
  # enable reticulate prompt and trigger `~`
  radian.enable_reticulate_prompt = TRUE
)

# short cut for quit
class(Q)=Q="no";print.no=q
