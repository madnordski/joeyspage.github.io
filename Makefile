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

whatlocks:
	@if [ -d .git ]; then \
		echo "Modified files (unstaged):"; \
		git ls-files -m || echo "None"; \
		echo ""; \
		echo "Staged files (ready to commit):"; \
		git diff --name-only --cached || echo "None"; \
		echo ""; \
		echo "Commits ahead of remote (if set):"; \
		if git rev-parse --verify @{u} >/dev/null 2>&1; then \
			git log --oneline @{u}..HEAD || echo "None"; \
		else \
			echo "No upstream remote set"; \
		fi \
	else \
		echo "Not a git repository"; \
	fi
