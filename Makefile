PATH := node_modules/.bin:$(PATH)
NPM=npm
NODE_VERSION=$(shell node --version 2>/dev/null)
NVMRC=$(shell cat .nvmrc)
TEST_REPORTS_DIR=test-reports
COVERAGE_REPORTS_DIR=coverage
ROOT = index.js
BIN_DIR = bin
SOURCES = $(ROOT) `find $(BIN_DIR)`
SCRIPTS = `find scripts -name "*.js"`
TESTS = `find __tests__ -name "*.js"`
JESTRC = .jestrc
JEST_FLAGS =
DEVELOPMENT=development

LINT = standard
TEST = jest -c $(JESTRC) $(JEST_FLAGS)

define postinstall-message
@echo ""
@echo "**** ATTENTION ****"
@echo "|"
@echo "| Please execute the following command:"
@echo "|   \`npm --version\` should be: `.node_modules/.bin/npm --version`"
@echo "|"
@echo "| If not, please source \`scripts/set_environment.sh\` into the current shell."
@echo "|"
@echo "| Hint: \`. scripts/set_environments.sh\`"
@echo "|"
@echo "**** THANK YOU ****"
@echo ""
endef

all: i test clean
	$(postinstall-message)

configure:
ifneq "$(shell echo $(NODE_VERSION) | sed 's/^v\(.\).*/\1/')" "$(NVMRC)"
$(info )
$(info | Pro tip: install the node version manager (nvm) to manage multiple nodes.)
$(info | https://github.com/creationix/nvm)
$(info )
$(info | Hint: `nvm install $(NVMRC)`)
$(info )
$(error No or wrong node version.  Found "$(NODE_VERSION)", please install node $(NVMRC))
endif


i: | configure
ifeq "$(NODE_ENVIRONMENT)" "$(DEVELOPMENT)"
	@$(NPM) link;
else
	@$(NPM) i;
endif
	$(postinstall-message)

test: lint
	@rm -rf $(TEST_REPORTS_DIR);
	@mkdir -p $(TEST_REPORTS_DIR);
	@JEST_JUNIT_REPORTS_DIR=$(TEST_REPORTS_DIR) $(TEST);

lint:
	@$(LINT) $(SOURCES) $(TESTS) $(SCRIPTS);

.clean: clean
	@rm -rf node_modules;

clean:
	@rm -rf $(DIST_DIR) \
	$(TEST_REPORTS_DIR) \
	$(COVERAGE_REPORTS_DIR) \
	$(CODE_REPORTS_DIR);

.PHONY : all \
	configure \
	.clean \
	clean \
	i \
	lint \
	test
