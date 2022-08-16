local todo = require("todo-comments")

todo.setup({
    search = {
        args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--glob=!node_modules",
            "--glob=!vendor/bundle",
            "--glob=!.git",
        }
    }
})
