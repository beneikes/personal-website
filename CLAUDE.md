# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

A minimal one-page website for Cosyne, Benedikt Neikes' motor control
engineering business. Plain static HTML and CSS: no framework, no build step,
no JavaScript, no tracking, no cookies, no third-party requests (no web fonts,
no CDNs).

## Structure

- `site/` — everything that gets deployed
  - `index.html` — the main page (intro, services, work, about, contact)
  - `legal.html` (Impressum), `privacy.html` — legal pages; they repeat the header and
    footer from `index.html`, so keep all three in sync when changing those
  - `style.css` — all styling; design tokens are CSS custom properties on `:root`
  - `favicon.ico`
- `drafts/` — unpublished article drafts and their images (not deployed)
- `assets/` — source material (photos, MATLAB/Jupyter files); not deployed

## Preview

Open `site/index.html` directly in a browser, or serve it locally:
`py -m http.server 8000 -d site` → http://localhost:8000

## Conventions

- Keep it minimal: hand-written HTML and CSS only; add nothing that needs a build
  step or loads resources from other domains
- System font stacks only (no web fonts) to keep the page fast and request-free
- Strictly light, clean, technical palette (see `:root` in `style.css`); no dark mode
- Must read well on mobile: single column, fluid type, no horizontal scrolling

## Deployment

Upload the contents of `site/` via FTP/SSH to the web root of the host.
Host: ALL-INKL.COM (managed via the KAS admin panel). Upload path not yet
recorded; fill it in here once set up.

## Open items

- None at the moment
