return {
  {
    "ThePrimeagen/harpoon",
    keys = {
      {
        "<leader>HD",
        function()
          require("harpoon"):list():remove()
        end,
        desc = "Delete Entry File",
      },
    },
  },
}
