((text) @injection.content
    (#set! injection.language "gotmpl"))

(element
    (start_tag
        (attribute
            (quoted_attribute_value
                (attribute_value) @injection.content
                (#set! injection.language "gotmpl")))))

(element
    (start_tag
        (attribute) @injection.content
            (#set! injection.language "gotmpl")))
