require("snippet").set("go", {
    {
        prefix = "ir",
        body = {
            "if err != nil {",
            "\treturn ${1:err}",
            "}"
        },
        description = "if err != nil"
    },
    {
        prefix = "fp",
        body = "fmt.Println($0)",
        description = "fmt.Println"
    },
    {
        prefix = "ff",
        body = "fmt.Printf(\"$1\", ${2:var})",
        description = "fmt.Printf"
    },
    {
        prefix = "if",
        body = {
            "if ${1:condition} {",
            "\t$0",
            "}"
        },
    },
    {
        prefix = { "tf", "tfu", "tfun" },
        body = {
            "func Test$1(t *testing.T) {",
            "\t$0",
            "}"
        }
    },
    {
        prefix = {"tr", "tru", "trun"},
        body = {
            "t.Run(\"$1\", func(t *testing.T) {",
            "\t$0",
            "})"
        }
    },
    {
        prefix = { "im", "imp", "impo" },
        body = {
            "import (",
            "\t\"${1:package}\"",
            ")"
        }
    },
})
