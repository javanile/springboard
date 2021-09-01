
update: homepage

top:
	@echo "ALL"

homepage:
	@while IFS= read line; do make -s append; done < projects.list
## test
append:
	@echo "E"