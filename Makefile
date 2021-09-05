
REPOS := https://api.github.com/repos

update: homepage

top:
	@echo "ALL"

homepage:
	@while IFS= read project; do [ -n "$${project}" ] && make -s append project="$${project}" ; done < projects.list

append:
	@echo "$${project}"

contributors:
	@sed -n '1,8p' -i docs/contributors.md
	@curl -s $(REPOS)/javanile/springboard/contributors | grep '"login":' | cut -d'"' -f4
