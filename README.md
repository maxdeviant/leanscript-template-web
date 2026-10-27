# LeanScript web app template

A template for web apps written in Lean, and compiled to JavaScript with [LeanScript](https://github.com/maxdeviant/leanscript). It has a counter, and a button that fetches a message from a JSON file.

## Layout

- `Main.lean` is the app's entry point, which `index.html` loads directly, as `<script type="module" src="./Main.lean">`.
- `App/` holds the app's other modules: `App/Counter.lean` has the counter's state, and `App/Message.lean` fetches the message.
- `lakefile.toml` requires LeanScript, which provides the `Js` library and the compiler.
- `package.json` depends on `@leanscript/vite-plugin`, which compiles `.lean` files with the compiler that Lake builds, and provides the JS runtime that compiled code uses.

## Getting started

Install [elan](https://github.com/leanprover/elan), which installs the Lean version in `lean-toolchain`, and [pnpm](https://pnpm.io). With [Nix](https://nixos.org), `nix develop` provides both, and [direnv](https://direnv.net) loads them when you enter the directory, after you run `direnv allow`. Then:

```sh
pnpm install
pnpm dev
```

The first time it compiles the app, the plugin has Lake fetch LeanScript and build its compiler, which takes a few seconds.

The dev server compiles the app, and reloads the page when you edit any of its Lean files.

`pnpm build` builds the app into `dist/`, and `pnpm preview` serves the build.

## Updating LeanScript

LeanScript's Lake package and npm packages share a version, and a compiled app only runs on the runtime of the same version as its compiler. To update, change both the `rev` of LeanScript in `lakefile.toml`, such as `v0.2.0`, and the version of `@leanscript/vite-plugin` in `package.json`, to the new version. Then run `lake update leanscript` and `pnpm install`.

## License

This template is licensed under [MIT-0](LICENSE), so apps made from it don't need to keep its copyright notice, and can use any license.
