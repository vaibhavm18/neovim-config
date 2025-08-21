return {
  "ThePrimeagen/harpoon",
  config = function ()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<leader>ha", mark.add_file, {desc = "Select a file to harpoon"})
    vim.keymap.set("n", "<leader>hr", mark.clear_all, {desc = "Remove all the harpoon files"})

    vim.keymap.set("n", "<leader>ho", ui.toggle_quick_menu, {desc= "Open harpoon"})
    vim.keymap.set("n", "<C-h>", function ()
      ui.nav_file(1)
    end)
    vim.keymap.set("n", "<C-j>", function ()
      ui.nav_file(2)
    end)
    vim.keymap.set("n", "<C-k>", function ()
      ui.nav_file(3)
    end)
    vim.keymap.set("n", "<C-l>", function ()
      ui.nav_file(4)
    end)
  end
}
