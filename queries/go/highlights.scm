; extends

((nil) @constant.builtin (#set! priority 200))
([(true) (false)] @boolean (#set! priority 200))

((escape_sequence) @string.special (#set! priority 200))

(field_declaration (type_identifier) @type (#set! priority 200))
(field_declaration (_ (type_identifier) @type (#set! priority 200)))

(field_declaration (field_identifier) @variable.member (#set! priority 200))
(keyed_element key: (literal_element (identifier) @variable.member (#set! priority 200)))
; priority only 126 to be overridable by modifiers
((selector_expression (field_identifier) @variable.member (#set! priority 126) ) @_parent
    (#not-has-parent? @_parent call_expression))
