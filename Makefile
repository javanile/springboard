
GH := https://github.com
MY := javanile/springboard
REPOS := https://api.github.com/repos
PROJECTS_MD := docs/index.md
CONTRIBUTORS_MD := docs/contributors.md
PROJECT_MD := docs/$(project)/index.md

## -------
## Actions
## -------
update: homepage

docs: homepage

top:
	@echo "ALL"


## --------
## Projects
## --------
projects: projects = $(shell cat projects.list | grep -E '^[a-zA-Z0-9]' | sed -e 's%^github\.com/%%i')
projects:
	@for project in $(projects); do make -s project-page project=$${project}; done
	@#for IFS= read project; do [ -n "$${project}" ] && make -s append project="$${project}" ; done < projects.list

project-page:
	@make -s $(PROJECT_MD) project=$(project)

$(PROJECT_MD):
	@mkdir -p docs/$(project)
	@make -s generate-project-page > $@
	@echo Created page: $(PROJECT_MD)

generate-project-page: A = B
generate-project-page:
	@echo "## $(user)"
	@echo "<img src='$(GH)/$(user).png' width='100' height='100' alt='$(user)' />"
	@echo "<a href='$(GH)/$(MY)/pulls?q=is%3Apr+author%3A$(user)' target='_blank'>🗣️ Contributes</a>"
	@echo "<a href='$(GH)/$(MY)/commits?author=$(user)' target='_blank'>🗣️ Changes</a>"
	@echo "<a href='$(GH)/$(MY)/$(user)?tab=repositories&type=source&sort=stargazers' target='_blank'>🗣️ Repositories</a>"
	@echo "<a href='$(GH)/pulls?q=is%3Apr+author%3A$(user)' target='_blank'>🗣️ Pull-requests</a>"
	@echo ""

## ------------
## Contributors
## ------------
contributors: contributors = $(shell curl -s $(REPOS)/$(MY)/contributors | grep '"login":' | cut -d'"' -f4 | sort -R)
contributors:
	@sed -n '1,7p' -i $(CONTRIBUTORS_MD)
	@for user in $(contributors); do make -s contributor user=$${user} >> $(CONTRIBUTORS_MD); done

contributor:
	@echo "## $(user)"
	@echo "<img src='$(GH)/$(user).png' width='100' height='100' alt='$(user)' />"
	@echo "<a href='$(GH)/$(MY)/pulls?q=is%3Apr+author%3A$(user)' target='_blank'>🗣️ Contributes</a>"
	@echo "<a href='$(GH)/$(MY)/commits?author=$(user)' target='_blank'>🗣️ Changes</a>"
	@echo "<a href='$(GH)/$(MY)/$(user)?tab=repositories&type=source&sort=stargazers' target='_blank'>🗣️ Repositories</a>"
	@echo "<a href='$(GH)/pulls?q=is%3Apr+author%3A$(user)' target='_blank'>🗣️ Pull-requests</a>"
	@echo ""

## -----
## Tests
## -----
test-project-page:
	@make -s project-page project=akoskm/gitforcats

test-project-md-page:
	@make -s docs/akoskm/gitforcats/index.md project=akoskm/gitforcats

test-contributors:
	@make -s contributors
	@cat $(CONTRIBUTORS_MD)
