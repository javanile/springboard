
update: homepage

top:
	@echo "ALL"

homepage:
	@while IFS= read project; do [ -n "$${project}" ] && make -s append project="$${project}" ; done < projects.list

append:
	@echo "$${project}"
