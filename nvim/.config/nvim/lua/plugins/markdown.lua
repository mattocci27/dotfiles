return {
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = {
      "MarkdownPreviewToggle",
      "MarkdownPreview",
      "MarkdownPreviewStop",
    },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  -- hide render-markdown
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
  },
}
