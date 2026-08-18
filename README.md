# Stock Ledger

A single-page dashboard for tracking diamond/gemstone stock across **Inventory**, **Sales**, and **Inward** shipment records.

**Live app:** https://justjd7.github.io/stock-ledger-app/

## What it does

- Reads your `INVENTORY`, `SALES`, and `INWARD` Excel files directly from a local folder you choose, and watches them for changes every second — no upload, no server, no database. Everything runs client-side in your browser.
- Filter by **Shipment** (any INWARD file) and by **Remark** (a master category you assign to the raw remarks in your INWARD files) to see Available / On Memo / Hold / Sold / Other for exactly that slice of stock.
- Each of On Memo / Hold / Sold / Other also breaks down into **Client** vs **Sister Company**, based on how you classify each raw remark on the Entity Mapping page.
- Export the current selection as two Excel files — **sold stones** and **remaining stones** — in the exact same column layout as your INWARD files.
- A **Remark Mapping** page lets you group raw remarks into master categories, with Excel import/export for the mapping itself.
- An **Entity Mapping** page (same features as Remark Mapping — search, batch tags, Excel import/export, reset to defaults) lets you classify each raw remark as **Client** or **Sister Company**. New remarks default to "Client" until you reassign them.

## Requirements

- **Google Chrome or Microsoft Edge on desktop.** Live folder syncing uses the File System Access API, which only those browsers support.
- Your data folder must contain three subfolders: `INVENTORY`, `INWARD`, and `SALES`, each with the relevant `.xlsx` files.

## Two ways to view it

**1. Your own live view (you, on your PC).**
Click **Connect data folder** and pick the folder that contains `INVENTORY`, `INWARD`, and `SALES`. The dashboard updates automatically whenever you edit or add files there — no need to refresh. This never leaves your machine; nothing is uploaded.

**2. The shared link (anyone else who opens it).**
"Connect data folder" only ever sees files on *whoever's* device clicks it — a link can't reach into your PC. So everyone else instead sees whatever you last **published**: a snapshot of your data baked into this repo as `data.json`. There are two ways to publish, from easiest to most manual:

- **One-time setup, then one click forever after (recommended).** Double-click **`install-auto-publish.bat`** once — it installs a small background watcher on this PC (via Windows Task Scheduler) that keeps an eye on `data.json` in this folder. From then on, just click **Publish live data** on the dashboard: it writes `data.json` straight into this folder (the first time, it'll ask you to pick this folder so it can remember it), and the watcher commits + pushes it to GitHub automatically within a few seconds. Nothing else to do. A log of what it published is kept in `auto-publish.log`. To turn it off later, run `uninstall-auto-publish.bat`.
- **Fully manual (no background task installed).** Click **Publish live data** — if the browser can't write into your repo folder (e.g. you skip the folder picker, or you're on a browser without that capability), it falls back to downloading a `data.json` file instead. Double-click **`publish.bat`** to move it into the repo and push it to GitHub yourself.

Either way, within a minute anyone with the link sees your latest data when they open (or refresh) the page — including the same "export sold" / "export remaining" buttons, working off that snapshot.

Publishing itself is still only ever triggered by *you* clicking "Publish live data" — nothing publishes on its own without that click. The background watcher only automates the "get it onto GitHub" mechanics that used to require double-clicking `publish.bat` by hand.

## Privacy

This repo only contains the dashboard code and whatever snapshot you've chosen to publish via `data.json` — nothing else. Your raw INVENTORY/INWARD/SALES files never leave your computer; only the data you explicitly publish is visible to anyone with the link, and the repo is public.

## Updating the dashboard

This repo is just one file, `index.html`. To ship a change:

```
git add index.html
git commit -m "describe the change"
git push
```

GitHub Pages redeploys automatically after each push to `main`.
