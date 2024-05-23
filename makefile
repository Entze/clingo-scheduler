
DOCUMENTATION := $(patsubst docs/%.dj,docs_md/%.md,$(wildcard docs/*.dj))

generate_all_documentation: $(DOCUMENTATION)


docs_md/%.md: docs/%.dj
	pandoc --from=djot $< --to=markdown_strict+fenced_code_blocks+inline_code_attributes+yaml_metadata_block --output=$@
	sed -Ei 's/\(([^)]*)\.dj\)/(\1.md)/g' $@

.PHONY = generate_all_documentation
