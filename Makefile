
MY := javanile/springboard
GH := https://api.github.com
CONTRIBUTORS :=	$(shell curl -s $(GH)/repos/$(MY)/contributors | grep '"login":' | cut -d'"' -f4 | sort -r)
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
	@echo "<img src='$(GH)/$(user).png' width='100' height='100' alt='$(user)' />"
	@echo "<a href='$(GH)/$(MY)/pulls?q=is%3Apr+author%3A$(user)' target='_blank'>🗣️ Contributes</a>"
	@echo "<a href='$(GH)/$(MY)/commits?author=$(user)' target='_blank'>🗣️ Changes</a>"
	@echo "<a href='$(GH)/$(MY)/$(user)?tab=repositories&type=source&sort=stargazers' target='_blank'>🗣️ Repositories</a>"
	@echo "<a href='$(GH)/pulls?q=is%3Apr+author%3A$(user)' target='_blank'>🗣️ Pull-requests</a>"
	@echo ""
