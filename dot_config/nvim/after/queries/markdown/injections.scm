; extends
; NOTE: https://phelipetls.github.io/posts/mdx-syntax-highlight-treesitter-nvim/
((inline) @injection.content
  (#lua-match? @injection.content "^%s*import")
  (#set! injection.language "typescript"))
((inline) @injection.content
  (#lua-match? @injection.content "^%s*export")
  (#set! injection.language "typescript"))

; Mermaid
((fenced_code_block (info_string (language) @lang)) @injection.content
(#eq? @lang mermaid)
(#set! injection.language "mermaid" ))


; ((fenced_code_block (info_string (language) @lang)) @injection.content
; (#set! injection.language @lang))
