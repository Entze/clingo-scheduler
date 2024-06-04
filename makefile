docs_md/%.md: docs/%.dj docs/admonitions.lua docs/links.lua
	pandoc --lua-filter=docs/admonitions.lua --lua-filter=docs/links.lua --from=djot $< --to=markdown_strict+inline_code_attributes+yaml_metadata_block+backtick_code_blocks --output=$@
