return {
    "inhesrom/remote-ssh.nvim",
    branch = "master",
    -- dependencies = {
    --     "ibhagwan/fzf-lua", -- Replace telescope with fzf-lua
    --     "nvim-lua/plenary.nvim", -- Still needed for remote-ssh.nvim
    --     -- Optional: nvim-notify for notifications
    --     "rcarriga/nvim-notify",
    -- },
    config = function()
        -- Set up fzf-lua
        require('fzf-lua').setup({
            -- Basic fzf-lua configuration
            winopts = {
                preview = { default = 'bat' }, -- Use bat for previews (optional)
            },
            files = {
                -- Configure fzf-lua to work with remote files if needed
                cmd = 'find . -type f', -- Example: Customize for remote file search
            },
            keymap = {
                -- Example keybindings for fzf-lua
                fzf = {
                    -- ["<leader>ff"] = "file", -- Find files
                    -- ["<leader>rb"] = "buffers", -- Find buffers
                    -- ["<leader>ro"] = "oldfiles", -- Recent files
                },
            },
        })

        -- Set up remote-ssh.nvim without LSP or telescope
        require('remote-ssh').setup({
            -- Minimal configuration for plain text editing
        })

        -- Key mapping for <leader>rf to open a prompt with predefined rsync URL for RemoteOpen
        vim.api.nvim_set_keymap(
            "n",
            "<leader>rf",
            "",
            {
                noremap = true,
                silent = true,
                callback = function()
                    vim.ui.input({
                        prompt = "Remote file: ",
                        default = ":RemoteOpen rsync://root@109.248.161.147//root/t.txt",
                    }, function(input)
                        if input then
                            vim.cmd(input)
                        end
                    end)
                end,
            }
        )

        -- Key mapping for <leader>rd to open a prompt with predefined rsync URL for RemoteTreeBrowser
        vim.api.nvim_set_keymap(
            "n",
            "<leader>rd",
            "",
            {
                noremap = true,
                silent = true,
                callback = function()
                    vim.ui.input({
                        prompt = "Remote directory: ",
                        default = "RemoteTreeBrowserrsync://root@109.248.161.147//root/",
                    }, function(input)
                        if input then
                            vim.cmd(input)
                        end
                    end)
                end,
            }
        )
    end
}
