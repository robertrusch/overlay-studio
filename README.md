# Overlay Studio (hosted copy)

The same app as the claude.ai artifact, built to run as a normal web page so the
**Export transparent .mov** button can save the file straight from the browser.

The export is Apple ProRes 4444 with transparency, 25 fps, made in your browser:

1. FFmpeg (bundled in `vendor/ffmpeg`) encodes the frames.
2. The app then rewrites each frame the way Apple's own encoder writes it.
   FFmpeg's version marks the alpha in a way Apple's decoder ignores, so Premiere
   and CapCut on a Mac would otherwise show a solid background.

The first export loads the encoder (about 30 MB). After that, exports start straight away.

## Open it on this Mac

Double-click **Open Overlay Studio.command**. It starts a small web server, visible
to this Mac only, and opens the app in your browser.

- If macOS asks whether to open it, choose Open.
- The server keeps running in the background until you log out or restart.

An internet connection is still needed: React and Remotion load from cdn.jsdelivr.net.

## Put it on a web host instead

Upload the whole folder, keeping its structure, to any static web host that serves
over https:

- `index.html`
- `maps/world-detail.svg`
- `vendor/ffmpeg/…`

No server code or database is needed.

- **Serve `.wasm` files as `application/wasm`.** Most hosts already do.
- **Allow files of 31 MB.** `vendor/ffmpeg/core/ffmpeg-core.wasm` is that size.
  - GitHub Pages and Netlify both handle it.
  - Cloudflare Pages does not: its limit is 25 MB per file.
- **Search engines are told not to index the page** (`noindex`). Anyone who has the
  link can still use it, so put it behind a login if that matters.

Opening `index.html` by double-clicking it (a `file://` address) does not work. The
map and the encoder must be loaded over http(s).

## Updating

This folder is generated from the artifact's source; don't edit `index.html` by hand.
Ask Claude to rebuild it after changing templates.
