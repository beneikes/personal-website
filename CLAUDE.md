# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

A minimal one-page website for Control Systems Neikes (tagline "Motor Control
Engineering"), Benedikt Neikes' motor control engineering business. "Cosyne" is
the old short form; it remains in the imprint and the email kontakt@cosyne.de.
Plain static HTML and CSS: no framework, no build step, no JavaScript, no
tracking, no cookies, no third-party requests (no web fonts, no CDNs).

Purpose: a clear, credible place for referrals and past contacts to land. It is
not expected to generate leads on its own; keep it minimal and finished, not
perfect. English only for now.

## Structure

- `site/` — everything that gets deployed
  - `index.html` — the main page (intro, services, work, about, contact)
  - `legal.html` (Impressum), `privacy.html` — legal pages; they repeat the header and
    footer from `index.html`, so keep all three in sync when changing those
  - `style.css` — all styling; design tokens are CSS custom properties on `:root`
  - `favicon.ico`
  - `.htaccess` — redirects http and the bare domain to `https://www.`
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
- Make the requested change, nothing more; no redesigns or refactors unless asked

## Content rules

- American English spelling and Oxford commas throughout
- Tone: calm and factual; confident, not salesy or boastful
- Never invent projects, numbers, clients, certifications, or skills; only use
  what Benedikt has confirmed
- Don't claim C++, ROS2, impedance/admittance control, functional safety
  (ISO 26262), or fault diagnostics; no industry claims beyond what the Work
  section backs up; don't position the site toward defense unless asked
- Client names are never shown; keep the note that details and references are
  available on request, under NDA if needed
- Work entries: title, an "Industry · Client type" meta line, and short technical
  bullets; no bold "result" lines. Keep the classes `work`, `points`, and `meta`
- No hourly rate on the site; the note on availability (hourly, daily, fixed
  price, joining the team) sits at the bottom of Services
- Services entries: title; a `summary` paragraph that opens with the client's
  problem (usually as a question); a second `summary` paragraph with a lead-in
  ending in a colon (e.g., "I cover:"); and `points` bullets in the form
  "<b>Label</b>: …". Draft copy lives in `services.md` (repo root) before it
  goes on the site
- "Book a call" links to the Microsoft Teams booking page (30-minute intro call)

## Deployment

Upload the contents of `site/` via FTP/SSH to the web root of the host,
including the hidden `.htaccess` (some FTP clients skip dotfiles).
Host: ALL-INKL.COM (managed via the KAS admin panel). Upload path not yet
recorded; fill it in here once set up.

Absolute URLs use `https://www.cosyne.de/`: canonical and `og:` tags and
JSON-LD in `index.html`, plus `sitemap.xml`, `robots.txt`, and `.htaccess`.
Keep them in sync.

## Open items

- Optional: LinkedIn link in Contact (only once Benedikt provides a URL)
- Optional, Benedikt's choice: one personal sentence in About; a photo of his own
  hardware; vary the strict three-bullet pattern in a place or two
- Later: German version with DE/EN switch, formal "Sie", footer link "Impressum"
