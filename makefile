SHELL=/bin/bash

htpasswd := $(CURDIR)/.secret-files/htpasswd

# self documenting makefile
.DEFAULT_GOAL := help
## Print (this) short summary
help: bold = $(shell tput bold; tput setaf 3)
help: reset = $(shell tput sgr0)
help:
	@echo
	@sed -nr \
		-e '/^## /{s/^## /    /;h;:a;n;/^## /{s/^## /    /;H;ba};' \
		-e '/^[[:alnum:]_\-]+:/ {s/(.+):.*$$/$(bold)\1$(reset):/;G;p};' \
		-e 's/^[[:alnum:]_\-]+://;x}' ${MAKEFILE_LIST}
	@echo

###########
# TARGETS #
###########

## Run create_user command (sudo permission needed)
.PHONY: create_user
create_user:
	@read -p "Enter User Name:" user
	@read -s -p "Enter Password:" password
	@echo ''; \
	if [ -f $(htpasswd) ] ; \
		then \
				 sudo chmod 1000:1000 $(htpasswd) ; \
		     sudo chmod 666 $(htpasswd) ; \
		fi; \
	docker-compose run --rm --user root --entrypoint htpasswd registry -Bbn $$user $$password >> $(htpasswd)
	@chmod 600 $(htpasswd)
	@chown root:root $(htpasswd)
