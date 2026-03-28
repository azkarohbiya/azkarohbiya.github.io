---
title: "How Other Sectors Respond to Three Middle East Conflicts"
highlight: true
categories: ["general"]
date : "2026-03-19"
result: ""
summary: ""
weight: 7
showTableOfContents: true
---

{{< alert >}}
**Note** 
Data sourced from Yahoo Finance. This content is for educational purposes only and does not constitute financial advice.
{{< /alert >}}


<style>
  @import url('https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;700&family=DM+Mono:wght@400;500&display=swap');
  .conflict-wrap {
    --bg:          #141414;
    --surface:     #1e1e1e;
    --border:      #2e2e2e;
    --text:        #e2e2e2;
    --text-muted:  #777777;
    --text-dim:    #555555;
    --title-color: #f0f0f0;
    --vline-color: rgba(255,255,255,0.18);
    --panel-bg:    #1a1a1a;
    --c0: #60a5fa;
    --c1: #f59e0b;
    --c2: #f87171;
  }
  .conflict-wrap.light {
    --bg:          #f5f4f1;
    --surface:     #ffffff;
    --border:      #e0ddd8;
    --text:        #1a1a1a;
    --text-muted:  #666666;
    --text-dim:    #999999;
    --title-color: #111111;
    --vline-color: rgba(0,0,0,0.18);
    --panel-bg:    #fafaf8;
    --c0: #2563eb;
    --c1: #d97706;
    --c2: #dc2626;
  }
  .conflict-wrap * { box-sizing: border-box; }
  .conflict-wrap {
    background: var(--bg);
    color: var(--text);
    font-family: 'DM Sans', sans-serif;
    padding: 32px 40px 28px;
    border-radius: 12px;
    margin: 2rem 0;
    transition: background 0.3s, color 0.3s;
  }
  .conflict-wrap .top-bar {
    display: flex;
    justify-content: flex-end;
    margin-bottom: 16px;
  }
  .conflict-wrap .toggle-btn {
    font-family: 'DM Mono', monospace;
    font-size: 10px;
    font-weight: 500;
    letter-spacing: 0.6px;
    padding: 4px 11px;
    border-radius: 3px;
    border: 1px solid var(--border);
    background: var(--surface);
    color: var(--text-muted);
    cursor: pointer;
    transition: all 0.2s;
    text-transform: uppercase;
  }
  .conflict-wrap .toggle-btn:hover { color: var(--text); border-color: var(--text-muted); }
  .conflict-wrap .header { margin-bottom: 24px; }
  .conflict-wrap .header h2 {
    font-size: 17px;
    font-weight: 700;
    letter-spacing: -0.3px;
    color: var(--title-color);
    margin-bottom: 5px;
    line-height: 1.3;
  }
  .conflict-wrap .header p {
    font-size: 11.5px;
    color: var(--text-muted);
    line-height: 1.5;
  }
  .conflict-wrap .panels {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 12px;
    margin-bottom: 16px;
  }
  .conflict-wrap .panel {
    background: var(--panel-bg);
    border: 1px solid var(--border);
    border-radius: 6px;
    padding: 14px 10px 10px;
    opacity: 0;
    transform: translateY(6px);
    animation: conflictRiseIn 0.4s ease forwards;
  }
  .conflict-wrap .panel-title {
    font-size: 11px;
    font-weight: 700;
    color: var(--title-color);
    text-align: center;
    margin-bottom: 2px;
  }
  .conflict-wrap .panel-ticker {
    font-family: 'DM Mono', monospace;
    font-size: 9px;
    color: var(--text-muted);
    text-align: center;
    margin-bottom: 10px;
  }
  .conflict-wrap .panel svg { display: block; width: 100%; overflow: visible; }
  .conflict-wrap .day-labels {
    display: flex;
    justify-content: space-between;
    padding: 4px 8px 0;
    font-size: 8.5px;
    color: var(--text-dim);
    font-family: 'DM Mono', monospace;
  }
  .conflict-wrap .legend {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    gap: 8px 20px;
    margin-top: 12px;
    font-size: 10px;
    color: var(--text-muted);
  }
  .conflict-wrap .legend-item { display: flex; align-items: center; gap: 7px; }
  .conflict-wrap .legend-swatch {
    width: 20px; height: 2.5px;
    border-radius: 2px;
    position: relative;
  }
  .conflict-wrap .legend-swatch::after {
    content: '';
    position: absolute;
    width: 6px; height: 6px;
    border-radius: 50%;
    top: -1.5px; left: 7px;
    background: inherit;
  }
  .conflict-wrap .footer {
    margin-top: 16px;
    padding-top: 10px;
    border-top: 1px solid var(--border);
    font-size: 9.5px;
    color: var(--text-muted);
    line-height: 1.7;
  }
  .conflict-wrap .footer .source { font-style: italic; }
  @keyframes conflictRiseIn { to { opacity: 1; transform: translateY(0); } }
</style>

<div class="not-prose conflict-wrap light" id="conflictWrap">
  <div class="top-bar">
    <button class="toggle-btn" id="conflictToggleBtn" onclick="conflictToggleMode()">🌙 Dark Mode</button>
  </div>
  <div class="header">
    <h2>Market Response Across Three Conflict Events</h2>
    <p>Price levels at Day 0 vs Day 13 — Gold, Tech, Financials, Benchmark</p>
  </div>
  <div class="panels" id="conflictPanels"></div>
  <div class="legend"  id="conflictLegend"></div>
  <div class="footer">
    <div class="source">Source: Yahoo Finance</div>
    <div>Note: Day 0 = conflict start date. Day 13 = 13 trading days after. % change shown at midpoint of each slope line.</div>
  </div>
</div>

<script>
  (function() {
    const dfSlope = [
      { conflict: "Iraq War 2003",     ticker: "GC=F", name: "Gold",       index_day_0: 332.9,  index_day_13: 321.5,  rebase_day_13: -3.4 },
      { conflict: "Iraq War 2003",     ticker: "QQQ",  name: "Tech",       index_day_0: 22.64,  index_day_13: 22.04,  rebase_day_13: -2.6 },
      { conflict: "Iraq War 2003",     ticker: "XLF",  name: "Financials", index_day_0: 11.09,  index_day_13: 11.34,  rebase_day_13:  2.3 },
      { conflict: "Iraq War 2003",     ticker: "SPY",  name: "Benchmark",  index_day_0: 57.57,  index_day_13: 57.74,  rebase_day_13:  0.3 },
      { conflict: "Oct 7 Attack 2023", ticker: "GC=F", name: "Gold",       index_day_0: 1849.5, index_day_13: 1984.1, rebase_day_13:  7.3 },
      { conflict: "Oct 7 Attack 2023", ticker: "QQQ",  name: "Tech",       index_day_0: 361.64, index_day_13: 345.64, rebase_day_13: -4.4 },
      { conflict: "Oct 7 Attack 2023", ticker: "XLF",  name: "Financials", index_day_0: 31.94,  index_day_13: 31.02,  rebase_day_13: -2.9 },
      { conflict: "Oct 7 Attack 2023", ticker: "SPY",  name: "Benchmark",  index_day_0: 419.01, index_day_13: 404.73, rebase_day_13: -3.4 },
      { conflict: "Iran Conflict 2026",ticker: "GC=F", name: "Gold",       index_day_0: 5294.4, index_day_13: 4889.9, rebase_day_13: -7.6 },
      { conflict: "Iran Conflict 2026",ticker: "QQQ",  name: "Tech",       index_day_0: 608.09, index_day_13: 594.9,  rebase_day_13: -2.2 },
      { conflict: "Iran Conflict 2026",ticker: "XLF",  name: "Financials", index_day_0: 51.3,   index_day_13: 48.97,  rebase_day_13: -4.5 },
      { conflict: "Iran Conflict 2026",ticker: "SPY",  name: "Benchmark",  index_day_0: 684.51, index_day_13: 659.63, rebase_day_13: -3.6 },
    ];
    const SECTORS = [
      { name: "Gold",       ticker: "GC=F" },
      { name: "Tech",       ticker: "QQQ"  },
      { name: "Financials", ticker: "XLF"  },
      { name: "Benchmark",  ticker: "SPY"  },
    ];
    const CONFLICTS    = [...new Set(dfSlope.map(d => d.conflict))];
    const CONFLICT_VAR = { "Iraq War 2003": '--c0', "Oct 7 Attack 2023": '--c1', "Iran Conflict 2026": '--c2' };

    function bestFormat(v) {
      const a = Math.abs(v);
      if (a >= 1e9) return `${(v/1e9).toFixed(1)}B`;
      if (a >= 1e6) return `${(v/1e6).toFixed(1)}M`;
      if (a >= 1e3) return `${(v/1e3).toFixed(1)}K`;
      return v.toFixed(1);
    }
    function css(name) {
      return getComputedStyle(document.getElementById('conflictWrap')).getPropertyValue(name).trim();
    }

    function drawPanel(sector) {
      const rows = dfSlope.filter(d => d.name === sector.name);
      const allY = rows.flatMap(r => [r.index_day_0, r.index_day_13]);
      const yMin = Math.min(...allY);
      const yMax = Math.max(...allY);
      const yPad = (yMax - yMin) * 0.30;
      const yLo  = yMin - yPad;
      const yHi  = yMax + yPad;
      const W = 160, H = 130;
      const x0 = 44, x1 = W - 44;
      const PT = 8,  PB = 8;
      function toSVG(v) {
        return PT + (1 - (v - yLo) / (yHi - yLo)) * (H - PT - PB);
      }
      const ns  = 'http://www.w3.org/2000/svg';
      const svg = document.createElementNS(ns, 'svg');
      svg.setAttribute('viewBox', `0 0 ${W} ${H}`);
      svg.setAttribute('height', H);
      [x0, x1].forEach(x => {
        const l = document.createElementNS(ns, 'line');
        l.setAttribute('x1', x); l.setAttribute('x2', x);
        l.setAttribute('y1', 0); l.setAttribute('y2', H);
        l.setAttribute('stroke', css('--vline-color'));
        l.setAttribute('stroke-width', '0.8');
        l.setAttribute('stroke-dasharray', '3 3');
        svg.appendChild(l);
      });
      rows.forEach(row => {
        const color = css(CONFLICT_VAR[row.conflict]);
        const sy0   = toSVG(row.index_day_0);
        const sy1   = toSVG(row.index_day_13);
        const midX  = (x0 + x1) / 2;
        const midY  = (sy0 + sy1) / 2;
        const line = document.createElementNS(ns, 'line');
        line.setAttribute('x1', x0); line.setAttribute('y1', sy0);
        line.setAttribute('x2', x1); line.setAttribute('y2', sy1);
        line.setAttribute('stroke', color);
        line.setAttribute('stroke-width', '2');
        svg.appendChild(line);
        [{ x: x0, y: sy0 }, { x: x1, y: sy1 }].forEach(pt => {
          const c = document.createElementNS(ns, 'circle');
          c.setAttribute('cx', pt.x); c.setAttribute('cy', pt.y);
          c.setAttribute('r', '3.2');
          c.setAttribute('fill', color);
          svg.appendChild(c);
        });
        const t0 = document.createElementNS(ns, 'text');
        t0.setAttribute('x', x0 - 4);
        t0.setAttribute('y', sy0);
        t0.setAttribute('text-anchor', 'end');
        t0.setAttribute('dominant-baseline', 'middle');
        t0.setAttribute('font-size', '7');
        t0.setAttribute('fill', color);
        t0.setAttribute('font-family', 'DM Mono, monospace');
        t0.textContent = bestFormat(row.index_day_0);
        svg.appendChild(t0);
        const t1 = document.createElementNS(ns, 'text');
        t1.setAttribute('x', x1 + 4);
        t1.setAttribute('y', sy1);
        t1.setAttribute('text-anchor', 'start');
        t1.setAttribute('dominant-baseline', 'middle');
        t1.setAttribute('font-size', '7');
        t1.setAttribute('fill', color);
        t1.setAttribute('font-family', 'DM Mono, monospace');
        t1.textContent = bestFormat(row.index_day_13);
        svg.appendChild(t1);
        const sign  = row.rebase_day_13 >= 0 ? '+' : '';
        const badge = document.createElementNS(ns, 'text');
        badge.setAttribute('x', midX);
        badge.setAttribute('y', midY - 5);
        badge.setAttribute('text-anchor', 'middle');
        badge.setAttribute('font-size', '7.5');
        badge.setAttribute('font-weight', '700');
        badge.setAttribute('fill', color);
        badge.setAttribute('font-family', 'DM Sans, sans-serif');
        badge.textContent = `${sign}${row.rebase_day_13.toFixed(1)}%`;
        svg.appendChild(badge);
      });
      return svg;
    }

    function conflictRebuildChart() {
      const container = document.getElementById('conflictPanels');
      container.innerHTML = '';
      SECTORS.forEach((sector, si) => {
        const panel = document.createElement('div');
        panel.className = 'panel';
        panel.style.animationDelay = `${si * 80}ms`;
        panel.innerHTML = `
          <div class="panel-title">${sector.name}</div>
          <div class="panel-ticker">${sector.ticker}</div>
        `;
        panel.appendChild(drawPanel(sector));
        const dl = document.createElement('div');
        dl.className = 'day-labels';
        dl.innerHTML = '<span>Day 0</span><span>Day 13</span>';
        panel.appendChild(dl);
        container.appendChild(panel);
      });
      const legend = document.getElementById('conflictLegend');
      legend.innerHTML = '';
      CONFLICTS.forEach(conflict => {
        const color = css(CONFLICT_VAR[conflict]);
        const item  = document.createElement('div');
        item.className = 'legend-item';
        item.innerHTML = `
          <div class="legend-swatch" style="background:${color}"></div>
          <span>${conflict}</span>
        `;
        legend.appendChild(item);
      });
    }

    function conflictToggleMode() {
      const wrap = document.getElementById('conflictWrap');
      const btn  = document.getElementById('conflictToggleBtn');
      const isLight = wrap.classList.toggle('light');
      btn.textContent = isLight ? '🌙 Dark Mode' : '☀ Light Mode';
      conflictRebuildChart();
    }
    window.conflictToggleMode = conflictToggleMode;

    conflictRebuildChart();
  })();
</script>

Gold has long been a safe haven, the asset investors rush to when the world feels uncertain. But three Middle Eastern conflicts tell a more complicated story.

Turn the clock back to 2003, the Iraq War had a surprisingly muted impact on markets. The S&P500 held virtually flat at +0.03%, and gold slipped modestly by 3.4%. If anything, financials were quietly were the quiet winner, gaining +2.3% over the two-week window an unusual outcome for a wartime opening.

The October 7 Gaza Attack in 2023 followed a more familiar patter. Equities sold off broadly, SPY dropped by -3.4%, tech fell -4.4%, and financials declined by -2.9%. Gold, however, did exactly what market sense, it climbed by +7.3%.

Iran 2026 broke every pattern. The conflict triggered a broad and sharp selloff across all assets. SPY fell -3.6%, financial dropped -4.5%, and tech slipped -2.2%. But the real surprise was gold, which plummeted +7.6. 

Across three conflicts, investors weren't seeking safe haven, but raising cash.


## Attachment 

| Ticker | Name | Description |
|--------|------|-------------|
| GC=F | Gold Futures | A futures contract tracking the price of gold. The "=F" suffix means it's a futures contract, not a stock. Represents the agreed price to buy/sell gold at a future date. Commonly used as a safe haven hedge against inflation and market uncertainty. |
| XLF | Financial Select Sector SPDR Fund | An ETF tracking the financial sector of the S&P 500. Holds banks, insurance companies, and investment firms like JPMorgan, Berkshire Hathaway, and Visa. Good proxy for overall financial sector health. |
| QQQ | Invesco QQQ Trust | An ETF tracking the Nasdaq 100 index — the 100 largest non-financial companies listed on Nasdaq. Heavily weighted toward tech giants like Apple, Microsoft, Nvidia, and Amazon. Considered a pure play on tech and growth stocks. |
| SPY | SPDR S&P 500 ETF Trust | An ETF tracking the S&P 500 index — the 500 largest US companies across all sectors. The most traded ETF in the world. Considered the best single proxy for overall US stock market performance. |
