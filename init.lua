-- Make sure to setup `mapleader` and `maplocalleader` befor
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"


-- Setup lazy.nvim
require("lazy").setup({
    'ThePrimeagen/vim-be-good',
    'navarasu/onedark.nvim',
    'nvim-lualine/lualine.nvim',
    -- 'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
    'hrsh7th/nvim-cmp',
    {
	    'folke/which-key.nvim', opts = {}
    },
    {
    	'mrcjkb/rustaceanvim',
    	version = '^5', -- Рекомендуется зафиксировать мажорную версию
      lazy = false,    -- Плагин сам определит, когда загрузиться для .rs файлов
    },
    {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
   	 lazy = false, -- neo-tree will lazily load itself
    }
})

-- Color Theme
require('onedark').setup {
    style = 'warm'
}
require('onedark').load()

-- info line
require('lualine').setup()

-- keymap
vim.api.nvim_set_keymap('n', '<leader>e', ':Neotree<CR>', { noremap = true, silent = true })




