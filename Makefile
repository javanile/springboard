
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
	cat <<- EOF > $@
		$(MYVAR)
		========

		This stuff will all be written to the target file. Be sure
		to escape dollar-signs and backslashes as Make will be scanning
		this text for variable replacements before bash scans it for its
		own strings.

		Otherwise formatting is just as in any other bash heredoc. Note
		I used the <<- operator which allows for indentation. This markdown
		file will not have whitespace at the start of lines.

		Here is a programmatic way to generate a markdwon list all PDF files
		in the current directory:

		`find -maxdepth 1 -name '*.pdf' -exec echo " + {}" \;`
	EOF
