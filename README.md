# Stock Ledger

A single-page dashboard for tracking diamond/gemstone stock across **Inventory**, **Sales**, and **Inward** shipment records.

**Live app:** https://justjd7.github.io/stock-ledger-app/

## What it does

- Reads your `INVENTORY`, `SALES`, and `INWARD` Excel files directly from a local folder you choose, and watches them for changes every second — no upload, no server, no database. Everything runs client-side in your browser.
- Filter by **Shipment** (any INWARD file) and by **Remark** (a master category you assign to the raw remarks in your INWARD files) to see Available / On Memo / Hold / Sold / Other for exactly that slice of stock.
- Export the current selection as two Excel files — **sold stones** and **remaining stones** — in the exact same column layout as your INWARD files.
- A separate **Remark Mapping** page lets you group raw remarks into master categories, with Excel import/export for the mapping itself.

## Requirements

- **Google Chrome or Microsoft Edge on desktop.** Live folder syncing uses the File System Access API, which only those browsers support.
- Your data folder must contain three subfolders: `INVENTORY`, `INWARD`, and `SALES`, each with the relevant `.xlsx` files.

## Two ways to view it

**1. Your own live view (you, on your PC).**
Click **Connect data folder** and pick the folder that contains `INVENTORY`, `INWARD`, and `SALES`. The dashboard updates automatically whenever you edit or add files there — no need to refresh. This never leaves your machine; nothing is uploaded.

**2. The shared link (anyone else who opens it).**
"Connect data folder" only ever sees files on *whoever's* device clicks it — a link can't reach into your PC. So everyone else instead sees whatever you last **published**: a snapshot of your data baked into this repo as `data.json`. To update what they see:

1. On your dashboard (connected to your own folder), click **Publish live data**. This downloads a `data.json` file.
2. Double-click **`publish.bat`** in this folder. It moves that file into the repo and pushes it to GitHub.
3. Within a minute, anyone with the link sees your latest data when they open (or refresh) the page — including the same "export sold" / "export remaining" buttons, working off that snapshot.

There's no background sync — publishing is manual, on purpose, so you control exactly what goes out and when.

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
