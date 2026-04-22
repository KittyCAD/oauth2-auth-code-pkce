.PHONY: all
all: build

.PHONY: build
build: node_modules/
	-mkdir pkg/
	npx esbuild --bundle --global-name=OAuth2AuthCodePKCE src/index.ts --outdir=pkg
	npx tsc --build
	cp package.json pkg/
	cp README.md pkg/

clean:
	-rm -r pkg
	
node_modules/:
	npm install

