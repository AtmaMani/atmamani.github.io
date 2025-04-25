TARGET_MAX_CHAR_NUM=20

all: help

.PHONY: meta-install
## Install development environment tooling
meta-install:
	brew install micromamba
	brew install direnv

.PHONY: start
## build on-the-fly and serve local site
start:
	micromamba run mkdocs serve

.PHONY: build
## Run build saved files into html
build:
	. "$(shell micromamba shell hook bash)" && micromamba activate mkdocs && mkdocs build --site-dir docs

.PHONY: publish
## git add, commit, push to origin
publish:
	git status
	git add .
	git commit -m "updates committed via makefile"
	git push origin master

## Help message
help:
	@echo ''
	@echo 'Usage:'
	@echo '  make <target>'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  %-$(TARGET_MAX_CHAR_NUM)s %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)