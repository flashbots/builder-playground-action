# For local development (install "act" first)
# Runs one job at a time to avoid confusing failures
# --env XDG_STATE_HOME: redirects artifact storage from ~/.local/state to /tmp,
#   since act runs as root and $HOME differs between act container and host
# -v /tmp:/tmp: builder-playground stores artifacts and volumes under /tmp,
#   shared so sibling Docker containers can bind-mount them
ACT_FLAGS := --env XDG_STATE_HOME=/tmp --container-options "-v /tmp:/tmp"

define cleanup
	@sudo rm -rf /tmp/builder-playground || true
	@docker kill $$(docker ps -q --filter "label=playground=true") 2>/dev/null || true
	@docker container rm $$(docker ps -q --filter "label=playground=true") 2>/dev/null || true
endef

.PHONY: test
test:
	$(cleanup)
	@act -W .github/workflows/test.yml -j test-recipe $(ACT_FLAGS)
	$(cleanup)
	@act -W .github/workflows/test.yml -j test-recipe-file $(ACT_FLAGS)
	$(cleanup)
	@act -W .github/workflows/test.yml -j test-attached-with-args $(ACT_FLAGS)
	$(cleanup)
	@act -W .github/workflows/test.yml -j test-install-only $(ACT_FLAGS)
