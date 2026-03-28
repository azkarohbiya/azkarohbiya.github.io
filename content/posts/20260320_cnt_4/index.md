---
title: "Material Sectors after Iran Escalation"
highlight: true
categories: ["general"]
date : "2026-03-20"
result: ""
summary: ""
weight: 8
showTableOfContents: true
---

{{< alert >}}
**Note** 
Data sourced from Yahoo Finance. This content is for educational purposes only and does not constitute financial advice.
{{< /alert >}}


<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@300;400;600;700&family=IBM+Plex+Mono:wght@400;600&display=swap');
  .mat-wrap {
    --bg:                #1a1a1a;
    --surface:           #222222;
    --border:            #333333;
    --text:              #e0e0e0;
    --text-muted:        #888888;
    --text-label:        #636363;
    --zero-line:         #444444;
    --title-color:       #f0f0f0;
    --color-neg:         #e63946;
    --color-pos:         #f08a36;
    --color-bench:       #787878;
    --label-inside:      #ffffff;
    --label-outside-pos: #f08a36;
  }
  .mat-wrap.light {
    --bg:                #f7f6f3;
    --surface:           #ffffff;
    --border:            #dddddd;
    --text:              #1a1a1a;
    --text-muted:        #666666;
    --text-label:        #444444;
    --zero-line:         #444444;
    --title-color:       #111111;
    --color-neg:         #c0272d;
    --color-pos:         #d4721a;
    --color-bench:       #888888;
    --label-inside:      #ffffff;
    --label-outside-pos: #d4721a;
  }
  .mat-wrap * { box-sizing: border-box; }
  .mat-wrap {
    background: var(--bg);
    color: var(--text);
    font-family: 'IBM Plex Sans', sans-serif;
    padding: 32px 40px 28px;
    border-radius: 12px;
    margin: 2rem 0;
    transition: background 0.3s, color 0.3s;
  }
  .mat-wrap .toggle-wrap {
    display: flex;
    justify-content: flex-end;
    margin-bottom: 18px;
  }
  .mat-wrap .toggle-btn {
    font-family: 'IBM Plex Mono', monospace;
    font-size: 10px;
    font-weight: 600;
    letter-spacing: 0.8px;
    padding: 5px 12px;
    border-radius: 4px;
    border: 1px solid var(--border);
    background: var(--surface);
    color: var(--text-muted);
    cursor: pointer;
    transition: all 0.2s;
    text-transform: uppercase;
  }
  .mat-wrap .toggle-btn:hover { color: var(--text); border-color: var(--text-muted); }
  .mat-wrap .header { margin-bottom: 28px; }
  .mat-wrap .header h2 {
    font-size: 17px;
    font-weight: 700;
    line-height: 1.35;
    letter-spacing: -0.3px;
    color: var(--title-color);
    margin-bottom: 6px;
    max-width: 620px;
  }
  .mat-wrap .header p {
    font-size: 11.5px;
    color: var(--text-muted);
    line-height: 1.5;
  }
  .mat-wrap .chart { display: flex; flex-direction: column; gap: 6px; }
  .mat-wrap .row {
    display: flex;
    align-items: center;
    opacity: 0;
    transform: translateX(-6px);
    animation: matFadeIn 0.35s ease forwards;
  }
  .mat-wrap .row-label {
    width: 140px;
    min-width: 140px;
    font-size: 10.5px;
    color: var(--text-label);
    text-align: right;
    padding-right: 14px;
    line-height: 1.4;
    white-space: nowrap;
  }
  .mat-wrap .row-label .ticker {
    font-family: 'IBM Plex Mono', monospace;
    font-weight: 700;
    font-size: 10px;
    color: var(--text-muted);
    display: block;
  }
  .mat-wrap .bar-track {
    flex: 1;
    position: relative;
    height: 32px;
    display: flex;
    align-items: center;
  }
  .mat-wrap .bar-track::before {
    content: '';
    position: absolute;
    left: var(--zero-pos, 50%);
    top: 0; bottom: 0;
    width: 0;
    border-left: 1px dashed var(--zero-line);
    opacity: 0.5;
    z-index: 3;
  }
  .mat-wrap .bar {
    position: absolute;
    top: 4px; bottom: 4px;
    transition: opacity 0.2s;
    cursor: default;
    display: flex;
    align-items: center;
  }
  .mat-wrap .bar:hover { opacity: 0.82; }
  .mat-wrap .bar-label {
    font-family: 'IBM Plex Mono', monospace;
    font-size: 8.5px;
    font-weight: 700;
    white-space: nowrap;
    position: absolute;
    pointer-events: none;
  }
  .mat-wrap .divider {
    height: 1px;
    background: var(--border);
    margin: 4px 0 4px 140px;
    border: none;
    opacity: 0.6;
    border-top: 1px dashed var(--border);
  }
  .mat-wrap .footer {
    margin-top: 20px;
    padding-top: 12px;
    border-top: 1px solid var(--border);
    font-size: 10px;
    color: var(--text-muted);
    line-height: 1.7;
  }
  .mat-wrap .footer .source { font-style: italic; }
  @keyframes matFadeIn { to { opacity: 1; transform: translateX(0); } }
</style>

<div class="not-prose mat-wrap light" id="matWrap">
  <div class="toggle-wrap">
    <button class="toggle-btn" id="matToggleBtn" onclick="matToggleMode()">🌙 Dark Mode</button>
  </div>
  <div class="header">
    <h2>Higher Oil Price Doesn't Just Hurt Your Bill, But Also Material Stocks</h2>
    <p>Material stocks plunged within two weeks. This is what it looks like.</p>
  </div>
  <div class="chart" id="matChart"></div>
  <div class="footer">
    <div class="source">Source: Yahoo Finance</div>
    <div>Note: % change since Feb 27, 2026. Brent surge follows Strait of Hormuz closure.</div>
  </div>
</div>

<script>
  (function() {
    const rows = [
      { name: 'PPG Industries',        ticker: 'PPG', value: -18.24, type: 'neg'   },
      { name: 'Smurfit Westrock',      ticker: 'SW',  value: -17.93, type: 'neg'   },
      { name: 'International Paper',   ticker: 'IP',  value: -17.57, type: 'neg'   },
      { name: 'Vulcan Materials',      ticker: 'VMC', value: -16.66, type: 'neg'   },
      { name: 'S&P 500 Materials ETF', ticker: 'XLB', value:  -9.23, type: 'bench' },
      { name: 'Brent Crude',           ticker: '',    value:  48.15, type: 'pos'   },
    ];
    const DIVIDER_BEFORE = 'Brent Crude';
    const MAX_NEG        = -20;
    const MAX_POS        =  55;
    const AXIS_RANGE     = MAX_POS - MAX_NEG;

    function getCSSVar(name) {
      return getComputedStyle(document.getElementById('matWrap')).getPropertyValue(name).trim();
    }
    function colorFor(type) {
      if (type === 'neg')   return getCSSVar('--color-neg');
      if (type === 'pos')   return getCSSVar('--color-pos');
      return getCSSVar('--color-bench');
    }
    function valToPct(v) {
      return ((v - MAX_NEG) / AXIS_RANGE) * 100;
    }
    const ZERO_PCT = valToPct(0);

    function matRebuildChart() {
      const chart = document.getElementById('matChart');
      chart.innerHTML = '';
      rows.forEach((row, idx) => {
        if (row.name === DIVIDER_BEFORE) {
          const hr = document.createElement('hr');
          hr.className = 'divider';
          chart.appendChild(hr);
        }
        const rowEl = document.createElement('div');
        rowEl.className = 'row';
        rowEl.style.animationDelay = `${idx * 50}ms`;
        const labelEl = document.createElement('div');
        labelEl.className = 'row-label';
        labelEl.innerHTML = `${row.name}${row.ticker ? `<span class="ticker">${row.ticker}</span>` : ''}`;
        rowEl.appendChild(labelEl);
        const track = document.createElement('div');
        track.className = 'bar-track';
        track.style.setProperty('--zero-pos', `${ZERO_PCT}%`);
        const color    = colorFor(row.type);
        const valuePct = valToPct(row.value);
        const bar = document.createElement('div');
        bar.className = 'bar';
        bar.style.background = color;
        bar.title = `${row.value > 0 ? '+' : ''}${row.value.toFixed(2)}%`;
        if (row.value < 0) {
          bar.style.left  = `${valuePct}%`;
          bar.style.width = `${ZERO_PCT - valuePct}%`;
        } else {
          bar.style.left  = `${ZERO_PCT}%`;
          bar.style.width = `${valuePct - ZERO_PCT}%`;
        }
        const lbl = document.createElement('span');
        lbl.className = 'bar-label';
        if (row.value < 0) {
          lbl.style.left  = '4px';
          lbl.style.color = getCSSVar('--label-inside');
          lbl.textContent = `${row.value.toFixed(1)}%`;
        } else {
          lbl.style.left  = `calc(${valuePct - ZERO_PCT}% + 6px)`;
          lbl.style.color = getCSSVar('--label-outside-pos');
          lbl.textContent = `+${row.value.toFixed(1)}%`;
        }
        bar.appendChild(lbl);
        if (row.type === 'pos') {
          const ann = document.createElement('div');
          ann.style.cssText = `
            position: absolute;
            left: calc(${ZERO_PCT}% + 16px);
            top: -32px;
            font-size: 9px;
            color: ${getCSSVar('--color-pos')};
            font-family: 'IBM Plex Sans', sans-serif;
            line-height: 1.4;
            white-space: nowrap;
            pointer-events: none;
          `;
          ann.innerHTML = `Brent surged +${row.value.toFixed(0)}%<br>after Strait of Hormuz closure`;
          track.appendChild(ann);
        }
        track.appendChild(bar);
        rowEl.appendChild(track);
        chart.appendChild(rowEl);
      });
    }

    function matToggleMode() {
      const wrap = document.getElementById('matWrap');
      const btn  = document.getElementById('matToggleBtn');
      const isLight = wrap.classList.toggle('light');
      btn.textContent = isLight ? '🌙 Dark Mode' : '☀ Light Mode';
      matRebuildChart();
    }
    window.matToggleMode = matToggleMode;

    matRebuildChart();
  })();
</script>


Within the materials sector, the selloff was sharp and broadly felt. PPG Industries was the hardest hit, falling 18.2%, followed closely by Smurfit Westrock (-17.9%) and International Paper (-17.6%). Vulcan Materials also declined, shedding 16.7%. Even the sector benchmark, the S&P 500 Materials ETF, was not spared — XLB dropped 9.2% over the two-week period, confirming that the weakness was widespread rather than isolated to individual names. The one outlier was Brent Crude, which surged 48.2% — moving in the opposite direction entirely. While materials companies struggled across the board, oil prices climbed sharply, reflecting how differently the market priced raw energy commodities versus the companies that depend on them.

## Attachment 

| Ticker | Name | Description |
|--------|------|-------------|
| PPG | PPG Industries | A global manufacturer of paints, coatings, and specialty materials. Products are used in construction, automotive, aerospace, and industrial applications. One of the largest coatings companies in the world alongside Sherwin-Williams. |
| SW | Smurfit Westrock | A leading global packaging company formed by the 2024 merger of Smurfit Kappa and WestRock. Specializes in corrugated packaging, cardboard boxes, and paper-based packaging solutions. Major beneficiary of e-commerce growth driving demand for packaging. |
| IP | International Paper | One of the world's largest paper and packaging companies. Produces containerboard, corrugated packaging, and pulp. Recently went through major restructuring by spinning off its printing papers business into a separate company. |
| VMC | Vulcan Materials | The largest US producer of construction aggregates — crushed stone, sand, and gravel. Core materials used in roads, highways, bridges, and infrastructure projects. A major beneficiary of US infrastructure spending bills. |
| XLB | Materials Select Sector SPDR Fund | An ETF tracking the materials sector of the S&P 500. Holds companies across chemicals, mining, paper, packaging, and construction materials. Good proxy for overall materials sector health and commodity demand cycles. |
| Brent Crude | Brent Crude Oil | Not a stock or ETF — it's a global oil price benchmark. Represents crude oil extracted from the North Sea. Used as the primary international pricing reference for oil. Ticker in yfinance: BZ=F. Directly impacts costs for materials and chemical companies. |
