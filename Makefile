.PHONY: all

all:
	@echo "make"
	@echo "\trelease - to create a new release on github"
	@echo "\tbump - to bump version"
	
audit:
	brew audit --strict --new-formula --online telegram.sh

release: check_clean
	git push --tags
	gh release create "$(shell git describe --tags)" --draft --generate-notes

bump: check_clean
	#brew install guilhem/homebrew-tap/bump	
	bump patch

check_clean:
	@git diff --quiet || (echo "There are uncommitted changes."; exit 1)