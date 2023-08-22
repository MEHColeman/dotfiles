-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true







-- Open API key and api endpoint
vim.g["codegpt_openai_api_key"] = os.getenv("OPENAI_API_KEY")
vim.g["codegpt_chat_completions_url"] = "https://models-gateway.builder.ai/api/v1/openai/deployments/gpt-35-turbo/chat/completions"
vim.g["codegpt_openai_api_provider"] = "Azure" -- or Azure

-- clears visual selection after completion
vim.g["codegpt_clear_visual_selection"] = true


-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
--   vim.fn.system({
--     "git",
--     "clone",
--     "--filter=blob:none",
--     "https://github.com/folke/lazy.nvim.git",
--     "--branch=stable", -- latest stable release
--     lazypath,
--   })
-- end
-- vim.opt.rtp:prepend(lazypath)
--
-- require("lazy").setup(plugins, opts)
--
-- vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
--
-- require("lazy").setup({
--   {
--     "jackMort/ChatGPT.nvim",
--     event = "VeryLazy",
--     config = function()
--       require("chatgpt").setup()
--     end,
--     dependencies = {
--       "MunifTanjim/nui.nvim",
--       "nvim-lua/plenary.nvim",
--       "nvim-telescope/telescope.nvim"
--     }
--   }
-- })
