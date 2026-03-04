push:
	@git rev-parse --is-inside-work-tree >/dev/null
	git add -A
	git commit -m "Update site: $(shell date)" || true
	@git --no-pager show --name-status --oneline -1
	git push origin main

init:
	git init
	git branch -M main
	-git remote add origin git@github.com:madnordski/joeyspage.github.io.git

.PHONY: whatlocks

whatlocks:
	@if [ -d .git ]; then \
		git ls-files -m \
			| sed 's/^/file: /; s/$$/ locked by: modified/'; \
		git diff --name-only --cached \
			| sed 's/^/file: /; s/$$/ locked by: staged/'; \
		if git rev-parse --verify HEAD@{upstream} >/dev/null 2>&1; \
		then \
			git diff --name-only HEAD@{upstream}..HEAD \
			| sed 's/^/file: /; s/$$/ locked by: committed/'; \
		fi \
	else \
		echo "Not a git repository"; \
	fi
