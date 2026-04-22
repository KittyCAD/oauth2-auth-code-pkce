.PHONY: all
all: build

.PHONY: serve
serve: node_modules/
	npx esbuild --bundle --global-name=OAuth2AuthCodePKCE src/index.ts --outdir=public --servedir=public --serve=localhost:3000

.PHONY: build
build: node_modules/
	-mkdir pkg/
	npx esbuild --bundle --global-name=OAuth2AuthCodePKCE src/index.ts --outfile=pkg/index.iife.js
	npx tsc --build
	cp package.json pkg/
	cp README.md pkg/

clean:
	-rm -r pkg
	
node_modules/:
	npm install

