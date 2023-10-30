(call_expression
    (selector_expression
        field: (field_identifier) @method
            (#any-of? @method "Exec" "ExecContext"
                              "Query" "QueryContext"
                              "QueryRow" "QueryRowContext"
                              "Prepare" "PrepareContext"))

    (argument_list
        ((interpreted_string_literal) @injection.content
            (#offset! @injection.content 0 1 0 -1)
            (#set! injection.language "sql")))
)
