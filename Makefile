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

