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

## Using it

1. Open the live app URL (or `index.html` locally).
2. Click **Connect data folder** and pick the folder that contains `INVENTORY`, `INWARD`, and `SALES`.
3. The dashboard updates automatically whenever you edit or add files in those folders — no need to refresh the page.

Your files never leave your computer. This repo only contains the static dashboard code — no business data is stored here.

## Updating the dashboard

This repo is just one file, `index.html`. To ship a change:

```
git add index.html
git commit -m "describe the change"
git push
```

GitHub Pages redeploys automatically after each push to `main`.
