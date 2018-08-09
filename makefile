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
	@echo 'Create a new user'; \
	read -p "Enter User Name:" user; \
	read -s -p "Enter Password:" password; \
	docker-compose run --rm --entrypoint htpasswd registry -Bbn $$user $$password | grep $$user >> $(htpasswd)
	@chmod 600 $(htpasswd)
	@echo -e '\r\nUser succesfully created'


## Run create a certificate
.PHONY: create_certificate
create_certificate:
	cd $(CURDIR)/.env-files/ && bash create_dev_certificates.sh
