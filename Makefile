
.PHONY: whatlocks begin end status

begin:
	@git rev-parse --is-inside-work-tree >/dev/null || \
	 (echo "Not inside a git repo"; exit 1)
	git fetch origin
	git pull --rebase origin main
	@echo "Session started: repo synced."

end:
	git add -A
	git diff --quiet && git diff --cached --quiet || \
	 git commit -m "Session Update: $(shell date)"
	git pull --rebase origin main
	git push origin main
	@echo "Session ended: changes pushed."

status:
	git fetch origin
	git status
	git diff main origin/main --stat

whatlocks:
	@if [ -d .git ]; then \
		git ls-files -m \
			| sed 's/^/file: /; s/$$/ git status: modified/'; \
		git diff --name-only --cached \
			| sed 's/^/file: /; s/$$/ git status: staged/'; \
		if git rev-parse --verify HEAD@{upstream} >/dev/null 2>&1; \
		then \
			git diff --name-only HEAD@{upstream}..HEAD \
			| sed 's/^/file: /; s/$$/ git status: committed/'; \
		fi \
	else \
		echo "Not a git repository"; \
	fi
