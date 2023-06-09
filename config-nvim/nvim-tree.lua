local nvim_tree = require('nvim-tree')

nvim_tree.setup {
    open_on_setup = true,
    view = {
        side = "left",
        width = 30,
        auto_resize = true
    },
    -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
    update_cwd = false,
}
