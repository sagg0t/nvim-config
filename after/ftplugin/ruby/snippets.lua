require("snippet").add("ruby", {
    {
        prefix = "frozen",
        body = {
            "# frozen_string_literal: true",
            "",
            "",
        },
        description = "Insert frozen literal string",
    },
    {
        prefix = "class",
        body = {
            "class ${1:ClassName}",
            "\t$0",
            "end",
        },
        description = "Class definition",
    },
    {
        prefix = "mod",
        body = {
            "module ${1:ModuleName}",
            "\t$0",
            "end",
        },
        description = "Module definition",
    },
    {
        prefix = "def",
        body = {
            "def ${1:method_name}",
            "\t$0",
            "end",
        },
        description = "method definition",
    },
    {
        prefix = "init",
        body = {
            "def initialize(${1:args})",
            "\t$0",
            "end",
        },
        description = "initialize method definition",
    },
    {
        prefix = "desc",
        body = {
            "describe ${1:subject} do",
            "\t$0",
            "end",
        },
        description = "Insert describe",
    },
    {
        prefix = "cont",
        body = {
            "context \"${1:message}\" do",
            "\t$0",
            "end",
        },
        description = "Insert context block",
    },
    {
        prefix = "it",
        body = {
            "it \"${1:spec_name}\" do",
            "\t$0",
            "end",
        },
        description = "Insert it block",
    },
    {
        prefix = "bef",
        body = {
            "before do",
            "\t$0",
            "end",
        },
        description = "Insert before block",
    },
    {
        prefix = "let",
        body = "let(:${1:object}) { $0 }",
        description = "Insert let",
    },
    {
        prefix = "let!",
        body = "let!(:${1:object}) { $0 }",
        description = "Insert let!",
    }
})
