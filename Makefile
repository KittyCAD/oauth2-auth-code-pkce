.PHONY: all
all: build

.PHONY: serve
keyfile := $(shell mktemp)
certfile := $(shell mktemp)

serve: node_modules/
	openssl req -x509 -newkey rsa:4096 -keyout $(keyfile) -out $(certfile) -days 9999 -nodes -subj /CN=127.0.0.1 
	trap cleanup EXIT
	npx esbuild --bundle --global-name=OAuth2AuthCodePKCE src/index.ts --outdir=public --servedir=public --serve=127.0.0.1:3000 --keyfile="$(keyfile)" --certfile="$(certfile)"

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

