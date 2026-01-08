require("snippet").set("lua", {
    {
        prefix = "if",
        body = {
            "if $1 then",
            "\t$0",
            "end"
        }
    },
    {
        prefix = "ife",
        body = {
            "if $1 then",
            "\t$0",
            "else",
            "\t",
            "end"
        }
    },
    {
        prefix = "fun",
        body = {
            "function $1($2)",
            "\t$0",
            "end"
        }
    },
})
