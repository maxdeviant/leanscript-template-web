# LeanScript web app template

A template for web apps written in Lean, and compiled to JavaScript with [LeanScript](https://github.com/maxdeviant/leanscript). It has a counter, and a button that fetches a message from a JSON file.

## Layout

- `Main.lean` is the app's entry point, which `index.html` loads directly, as `<script type="module" src="./Main.lean">`.
- `App/` holds the app's other modules: `App/Counter.lean` has the counter's state, and `App/Message.lean` fetches the message.
- `lakefile.toml` requires LeanScript, which provides the `Js` library, the compiler, the JS runtime, and the Vite plugin. `lake-manifest.json` pins its version.
- `package.json` links the `leanscript` npm package to the copy of LeanScript that Lake fetches, so the JS runtime and the Vite plugin always match the compiler.

## Getting started

Install [elan](https://github.com/leanprover/elan), which installs the Lean version in `lean-toolchain`, and [pnpm](https://pnpm.io). With [Nix](https://nixos.org), `nix develop` provides both, and [direnv](https://direnv.net) loads them when you enter the directory, after you run `direnv allow`. Then:

```sh
lake build leanscript
pnpm install
pnpm dev
```

`lake build leanscript` fetches LeanScript and builds its compiler, which `pnpm install` needs to link to. The `dev` and `build` scripts run it again, which does nothing unless LeanScript has changed.

The dev server compiles the app, and reloads the page when you edit any of its Lean files.

`pnpm build` builds the app into `dist/`, and `pnpm preview` serves the build.

## Updating LeanScript

Change the `rev` of LeanScript in `lakefile.toml`, and run `lake update leanscript`.

## License

This template is licensed under [MIT-0](LICENSE), so apps made from it don't need to keep its copyright notice, and can use any license.
