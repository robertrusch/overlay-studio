# Overlay Studio (hosted copy)

**Live at https://robertrusch.github.io/overlay-studio/**

- It's published by GitHub Pages from the `main` branch of the public repo
  [robertrusch/overlay-studio](https://github.com/robertrusch/overlay-studio).
- It started as a claude.ai artifact (since deleted) and now runs as a normal web page,
  so the **Export transparent .mov** button can save the file straight from the browser.

The export is Apple ProRes 4444 with transparency, 25 fps, made in your browser:

1. FFmpeg (bundled in `vendor/ffmpeg`) encodes the frames.
2. The app then rewrites each frame the way Apple's own encoder writes it.
   FFmpeg's version marks the alpha in a way Apple's decoder ignores, so Premiere
   and CapCut on a Mac would otherwise show a solid background.

The first export loads the encoder (about 30 MB). After that, exports start straight away.

## Open it on this Mac instead

Double-click **Open Overlay Studio.command**. It starts a small web server, visible
to this Mac only, and opens this folder's copy of the app in your browser.

- If macOS asks whether to open it, choose Open.
- The server keeps running in the background until you log out or restart.

An internet connection is still needed: React and Remotion load from cdn.jsdelivr.net.

## Hosting notes

The folder is a plain static site that needs https and no server code:

- `index.html`
- `maps/world-detail.svg`
- `vendor/ffmpeg/…`

What to know when hosting it:

- **The encoder is split into four parts.** The 31 MB `ffmpeg-core.wasm` is stored as
  `ffmpeg-core.wasm.part1`–`part4`, each about 8 MB, so it can be uploaded through
  GitHub's website (25 MB limit per file). The page joins the parts before loading.
- **Search engines are told not to index the page** (`noindex`). Anyone who has the
  link can still use it.
- **It must be served over http(s).** Opening `index.html` by double-clicking it (a
  `file://` address) does not work, because the map and the encoder can't load.

## Updating

`index.html` in this folder is the app's source: the whole app is in that one file.

This folder is a git clone of the repo. Claude pushes to it with a deploy key that
works for this one repo only:

- The key is `~/.ssh/overlay-studio-deploy` on this Mac.
- On GitHub it's listed under the repo's Settings › Deploy keys as "This Mac (Claude Code)".
- Commits use your GitHub noreply address, so your email stays out of the history.

To change the app:

1. Ask Claude for the change.
2. Claude edits `index.html`, tests it locally, commits and pushes.

GitHub Pages republishes the site about a minute later.

To take Claude's access away, delete the deploy key on GitHub.
