---
title: "Negative and Positive Return Distribution in All S&P500 Sectors"
highlight: true
categories: ["general"]
date : "2026-03-21"
result: ""
summary: ""
weight: 9
showTableOfContents: true
---


{{< alert >}}
**Note** 
Data sourced from Yahoo Finance. This content is for educational purposes only and does not constitute financial advice.
{{< /alert >}}


<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@300;400;600;700&family=IBM+Plex+Mono:wght@400;600&display=swap');
  .sp500-wrap {
    --bg:          #1a1a1a;
    --surface:     #222222;
    --border:      #333333;
    --text:        #e0e0e0;
    --text-muted:  #888888;
    --zero-line:   #555555;
    --title-color: #f0f0f0;
    --neg-large:   #99d98c;
    --neg-mid:     #b5e48c;
    --neg-small:   #d9ed92;
    --pos-large:   #1e6091;
    --pos-mid:     #1a759f;
    --pos-small:   #168aad;
    --label-neg:   #313131;
    --label-pos:   #dcdcdc;
  }
  .sp500-wrap.light {
    --bg:          #f8f8f6;
    --surface:     #ffffff;
    --border:      #dddddd;
    --text:        #222222;
    --text-muted:  #666666;
    --zero-line:   #aaaaaa;
    --title-color: #111111;
    --neg-large:   #52b788;
    --neg-mid:     #74c69d;
    --neg-small:   #b7e4c7;
    --pos-large:   #1e6091;
    --pos-mid:     #1a759f;
    --pos-small:   #168aad;
    --label-neg:   #ffffff;
    --label-pos:   #ffffff;
  }
  .sp500-wrap * { box-sizing: border-box; }
  .sp500-wrap {
    background: var(--bg);
    color: var(--text);
    font-family: 'IBM Plex Sans', sans-serif;
    padding: 32px 40px 28px;
    border-radius: 12px;
    margin: 2rem 0;
    transition: background 0.3s, color 0.3s;
  }
  .sp500-wrap .toggle-wrap {
    display: flex;
    justify-content: flex-end;
    margin-bottom: 20px;
  }
  .sp500-wrap .toggle-btn {
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
  .sp500-wrap .toggle-btn:hover { color: var(--text); border-color: var(--text-muted); }
  .sp500-wrap .header { margin-bottom: 28px; }
  .sp500-wrap .header h2 {
    font-size: 18px;
    font-weight: 700;
    line-height: 1.3;
    letter-spacing: -0.3px;
    color: var(--title-color);
    margin-bottom: 6px;
  }
  .sp500-wrap .header p {
    font-size: 12px;
    color: var(--text-muted);
    line-height: 1.5;
  }
  .sp500-wrap .direction-labels {
    display: flex;
    justify-content: space-between;
    padding: 0 0 8px 160px;
    font-size: 11px;
    font-weight: 700;
    font-family: 'IBM Plex Mono', monospace;
    letter-spacing: 0.5px;
  }
  .sp500-wrap .dir-neg { color: var(--neg-large); }
  .sp500-wrap .dir-pos { color: var(--pos-large); }
  .sp500-wrap .chart { display: flex; flex-direction: column; gap: 5px; }
  .sp500-wrap .row {
    display: flex;
    align-items: center;
    opacity: 0;
    transform: translateX(-8px);
    animation: sp500FadeIn 0.4s ease forwards;
  }
  .sp500-wrap .sector-label {
    width: 155px;
    min-width: 155px;
    font-size: 11px;
    color: var(--text-muted);
    text-align: right;
    padding-right: 12px;
    letter-spacing: 0.2px;
    white-space: nowrap;
  }
  .sp500-wrap .bars-wrap {
    flex: 1;
    display: flex;
    align-items: center;
    position: relative;
    height: 28px;
  }
  .sp500-wrap .bars-wrap::before {
    content: '';
    position: absolute;
    left: 50%;
    top: 0; bottom: 0;
    width: 1px;
    background: var(--zero-line);
    z-index: 2;
  }
  .sp500-wrap .neg-side {
    position: absolute;
    right: 50%;
    top: 3px; bottom: 3px;
    display: flex;
    flex-direction: row-reverse;
    overflow: hidden;
  }
  .sp500-wrap .pos-side {
    position: absolute;
    left: 50%;
    top: 3px; bottom: 3px;
    display: flex;
    overflow: hidden;
  }
  .sp500-wrap .bar-seg {
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 9px;
    font-weight: 700;
    font-family: 'IBM Plex Mono', monospace;
    transition: opacity 0.2s;
    cursor: default;
    position: relative;
    overflow: visible;
    flex-shrink: 0;
  }
  .sp500-wrap .bar-seg:hover { opacity: 0.8; }
  .sp500-wrap .bar-seg .seg-label {
    position: absolute;
    white-space: nowrap;
    pointer-events: none;
    z-index: 3;
  }
  .sp500-wrap .legend {
    display: flex;
    flex-wrap: wrap;
    gap: 12px 20px;
    margin-top: 20px;
    padding-left: 160px;
    font-size: 10.5px;
    color: var(--text-muted);
  }
  .sp500-wrap .legend-item { display: flex; align-items: center; gap: 6px; }
  .sp500-wrap .legend-dot { width: 10px; height: 10px; border-radius: 2px; flex-shrink: 0; }
  .sp500-wrap .footer {
    margin-top: 24px;
    padding-top: 14px;
    border-top: 1px solid var(--border);
    font-size: 10px;
    color: var(--text-muted);
    line-height: 1.7;
  }
  .sp500-wrap .footer .source { font-style: italic; }
  @keyframes sp500FadeIn { to { opacity: 1; transform: translateX(0); } }
</style>

<div class="not-prose sp500-wrap light" id="sp500Wrap">
  <div class="toggle-wrap">
    <button class="toggle-btn" id="sp500ToggleBtn" onclick="sp500ToggleMode()">🌙 Dark Mode</button>
  </div>
  <div class="header">
    <h2>S&amp;P 500 Sectors: Winners vs. Losers Since Iran Conflict</h2>
    <p>Count of tickers by return direction and market cap size, Feb 27 – Mar 19, 2026</p>
  </div>
  <div class="direction-labels">
    <span class="dir-neg">◀ Negative</span>
    <span class="dir-pos">Positive ▶</span>
  </div>
  <div class="chart" id="sp500Chart"></div>
  <div class="legend" id="sp500Legend"></div>
  <div class="footer">
    <div class="source">Source: Yahoo Finance</div>
    <div>Note: 'Small' = S&amp;P 500 members with market cap &lt; $40B. 'Mid' = $40B–$200B. 'Large' = &gt; $200B.</div>
  </div>
</div>

<script>
  (function() {
    function sp500ToggleMode() {
      const wrap = document.getElementById('sp500Wrap');
      const btn  = document.getElementById('sp500ToggleBtn');
      const isLight = wrap.classList.toggle('light');
      btn.textContent = isLight ? '🌙 Dark Mode' : '☀ Light Mode';
      sp500RebuildChart();
    }
    window.sp500ToggleMode = sp500ToggleMode;

    const data = [
      { sector: "Energy",            neg_Large:  0, neg_Mid: -5,  neg_Small:  -1, pos_Small: 10, pos_Mid: 10, pos_Large: 2 },
      { sector: "Communication Svcs",neg_Large: -7, neg_Mid: -3,  neg_Small: -18, pos_Small:  5, pos_Mid:  1, pos_Large: 0 },
      { sector: "Technology",        neg_Large: -8, neg_Mid: -13, neg_Small: -12, pos_Small:  7, pos_Mid:  4, pos_Large: 4 },
      { sector: "Utilities",         neg_Large:  0, neg_Mid: -8,  neg_Small: -26, pos_Small:  4, pos_Mid:  1, pos_Large: 0 },
      { sector: "Materials",         neg_Large: -1, neg_Mid: -4,  neg_Small: -32, pos_Small:  7, pos_Mid:  1, pos_Large: 0 },
      { sector: "Real Estate",       neg_Large:  0, neg_Mid: -6,  neg_Small: -35, pos_Small:  3, pos_Mid:  2, pos_Large: 0 },
      { sector: "Consumer Staples",  neg_Large: -6, neg_Mid: -5,  neg_Small: -31, pos_Small:  2, pos_Mid:  0, pos_Large: 0 },
      { sector: "Consumer Disc.",    neg_Large: -4, neg_Mid: -15, neg_Small: -32, pos_Small:  5, pos_Mid:  3, pos_Large: 0 },
      { sector: "Financials",        neg_Large: -7, neg_Mid: -23, neg_Small: -24, pos_Small:  1, pos_Mid:  0, pos_Large: 0 },
      { sector: "Healthcare",        neg_Large: -5, neg_Mid: -23, neg_Small: -26, pos_Small:  2, pos_Mid:  0, pos_Large: 0 },
      { sector: "Industrials",       neg_Large: -2, neg_Mid: -27, neg_Small: -25, pos_Small:  2, pos_Mid:  3, pos_Large: 1 },
    ];
    data.sort((a, b) => {
      const aN = a.neg_Large + a.neg_Mid + a.neg_Small;
      const bN = b.neg_Large + b.neg_Mid + b.neg_Small;
      return bN - aN;
    });

    const PX_PER_UNIT = 3.2;

    function getCSSVar(name) {
      return getComputedStyle(document.getElementById('sp500Wrap')).getPropertyValue(name).trim();
    }

    function sp500RebuildChart() {
      const chart = document.getElementById('sp500Chart');
      chart.innerHTML = '';
      const NEG = [
        { key: 'neg_Large', colorVar: '--neg-large', labelVar: '--label-neg' },
        { key: 'neg_Mid',   colorVar: '--neg-mid',   labelVar: '--label-neg' },
        { key: 'neg_Small', colorVar: '--neg-small', labelVar: '--label-neg' },
      ];
      const POS = [
        { key: 'pos_Small', colorVar: '--pos-small', labelVar: '--label-pos' },
        { key: 'pos_Mid',   colorVar: '--pos-mid',   labelVar: '--label-pos' },
        { key: 'pos_Large', colorVar: '--pos-large', labelVar: '--label-pos' },
      ];
      data.forEach((row, idx) => {
        const div = document.createElement('div');
        div.className = 'row';
        div.style.animationDelay = `${idx * 45}ms`;
        const label = document.createElement('div');
        label.className = 'sector-label';
        label.textContent = row.sector;
        div.appendChild(label);
        const wrap = document.createElement('div');
        wrap.className = 'bars-wrap';
        const negSide = document.createElement('div');
        negSide.className = 'neg-side';
        NEG.forEach(col => {
          const v = Math.abs(row[col.key]);
          if (v === 0) return;
          const seg = document.createElement('div');
          seg.className = 'bar-seg';
          seg.style.width = `${v * PX_PER_UNIT}px`;
          seg.style.background = getCSSVar(col.colorVar);
          seg.title = `${col.key}: ${row[col.key]}`;
          const lbl = document.createElement('span');
          lbl.className = 'seg-label';
          lbl.style.color = getCSSVar(col.labelVar);
          lbl.textContent = v;
          seg.appendChild(lbl);
          negSide.appendChild(seg);
        });
        const posSide = document.createElement('div');
        posSide.className = 'pos-side';
        POS.forEach(col => {
          const v = row[col.key];
          if (v === 0) return;
          const seg = document.createElement('div');
          seg.className = 'bar-seg';
          seg.style.width = `${v * PX_PER_UNIT}px`;
          seg.style.background = getCSSVar(col.colorVar);
          seg.title = `${col.key}: ${v}`;
          const lbl = document.createElement('span');
          lbl.className = 'seg-label';
          lbl.style.color = getCSSVar(col.labelVar);
          lbl.textContent = v;
          seg.appendChild(lbl);
          posSide.appendChild(seg);
        });
        wrap.appendChild(negSide);
        wrap.appendChild(posSide);
        div.appendChild(wrap);
        chart.appendChild(div);
      });
      const legend = document.getElementById('sp500Legend');
      legend.innerHTML = '';
      const allCols = [
        { label: 'neg Large', colorVar: '--neg-large' },
        { label: 'neg Mid',   colorVar: '--neg-mid'   },
        { label: 'neg Small', colorVar: '--neg-small' },
        { label: 'pos Small', colorVar: '--pos-small' },
        { label: 'pos Mid',   colorVar: '--pos-mid'   },
        { label: 'pos Large', colorVar: '--pos-large' },
      ];
      allCols.forEach(c => {
        const item = document.createElement('div');
        item.className = 'legend-item';
        item.innerHTML = `<div class="legend-dot" style="background:${getCSSVar(c.colorVar)}"></div>${c.label}`;
        legend.appendChild(item);
      });
    }
    sp500RebuildChart();
  })();
</script>

Zooming out across all eleven sectors draws a clear insight, Iran 2026 was a universal selloff, with one sector exception. 

Energy stood alone, 22 of 28 (~79% hit rate) energy companies finished in positive territory over the two week period. No other sector came close. It wasn't just that energy did well, it was that losing was the exception rather than a market rule.

Beyond energy, the story told differently. Tech was the most resilient of the remaining sectors, 15 of 48 companies managing to finish higher, roughly 1/3. Considering the broad risk-off environment, that's a relatively respectable showing, though still firmly a minority.

The hardest hit was financials. Only 1 firm out of 55 finished in positive area. Healthcare told a nearly identical story, with just 2 survivors out of 54. In both sectors, the selloff was deep, broad, and showed very little discrimination between large and small names.

The takeaway is straightforward. Iran 2026 didn't just shake the markets, it rattled virtually every corner of them. Energy was the sole sector gaining. Everywhere else, surviving the two weeks in positive area was the exception.

