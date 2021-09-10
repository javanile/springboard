
MY := javanile/springboard
REPOS := https://api.github.com/repos
CONTRIBUTORS :=	$(shell curl -s $(REPOS)/$(MY)/contributors | grep '"login":' | cut -d'"' -f4 | sort -r)
CONTRIBUTORS_MD := docs/contributors.md

update: homepage

docs: homepage

top:
	@echo "ALL"

homepage:
	@while IFS= read project; do [ -n "$${project}" ] && make -s append project="$${project}" ; done < projects.list

append:
	@echo "$${project}"

contributors:
	@sed -n '1,8p' -i $(CONTRIBUTORS_MD)
	@for user in $(CONTRIBUTORS); do make -s user user=$${user} >> $(CONTRIBUTORS_MD); done

user:
	@echo "## $(user)"
	@echo "<img src='https://github.com/$(user).png' width='100' height='100' alt='$(user)' />"
	@echo ""
