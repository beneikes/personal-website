# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

A minimal personal website built with Astro + TypeScript: a one-page profile/bio
on the home page, and a Markdown-based blog for technical articles (motor
control / control systems engineering topics).

## Commands

- `npm run dev` — start the dev server (http://localhost:4321)
- `npm run build` — build the static site to `dist/`
- `npm run preview` — serve the built `dist/` locally to sanity-check before deploying

No lint, format, or test scripts are configured — keep the project minimal.

## Structure

- `src/content.config.ts` — defines the `blog` content collection using the
  Content Layer `glob()` loader (Astro 5+ API: collections expose `id`, not `slug`)
- `src/content/blog/*.md` — blog posts (frontmatter: `title`, `description`, `pubDate`)
- `src/pages/index.astro` — home page (profile/bio) — contains `<!-- PLACEHOLDER -->`
  comments marking content (name, tagline, bio, contact links) to be replaced with real info
- `src/pages/blog/index.astro` — blog listing page
- `src/pages/blog/[...slug].astro` — individual post page; renders posts via
  `render(entry)` imported from `astro:content`, routes to `/blog/<id>/`
- `src/layouts/Layout.astro` — shared layout; defines the site's design tokens
  (CSS custom properties) and global typography in a single `<style is:global>` block
- `src/components/` — `Header.astro` (nav) and `Footer.astro`

## Conventions

- Styling is plain scoped CSS via Astro's `<style>` blocks — no CSS framework
  (deliberate choice for an "extremely minimal" site)
- Design is a strictly light, clean, technical palette (see `:root` custom
  properties in `Layout.astro`) — no dark mode
- Output mode is static (Astro's default) — `astro build` emits to `dist/`

## Deployment

Deploy by running `npm run build` and uploading the contents of `dist/` via
FTP/SSH to the target host. No platform adapter (Vercel/Netlify/etc.) is used.
Host/path details are not yet configured — fill in here once decided.

## Deliberately deferred

RSS (`@astrojs/rss`) and a sitemap (`@astrojs/sitemap`) were left out of the
initial build to keep scope tight for a 2-page site. Both are simple official
integrations to add later once there's enough blog content to justify them.
