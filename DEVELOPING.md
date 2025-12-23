# How this works

There are 2 main parts of the app:

1. renderer: this is the HTML/Javascript-based UI rendered within the Electron container. This runs Vue.js, a React-like Javascript framework for rendering front-end.
2. main: includes the main app (written in Electron). Handles keyboard shortcuts, brings up the UI and overlays.

Note that these 2 both depend on each other, and one cannot run without the other.

# How to develop

The most up-to-date instructions can always be derived from CI:

[.github/workflows/main.yml](https://github.com/SnosMe/awakened-poe-trade/blob/master/.github/workflows/main.yml)

Here's what that looks like as of 2023-12-03.

```shell
cd renderer
npm i
npm run make-index-files
npm run dev

# In a second shell
cd main
npm i
npm run dev
```

# How to build

```shell
make build   # Build using Docker
make release # Complete release build
make clean   # Remove build artifacts and Docker cache
```

Output: `dist/` in project root

# Maintaining a fork

```shell
make sync  # Sync with original repository
```
