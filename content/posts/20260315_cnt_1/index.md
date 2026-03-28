---
title: "S&P Energy Stocks after Iran Conflict, Feb'26"
highlight: true
categories: ["general"]
date : "2026-03-15"
result: ""
summary: ""
weight: 5
showTableOfContents: true
---

{{< alert >}}
**Note** 
Data sourced from Yahoo Finance. This content is for educational purposes only and does not constitute financial advice.
{{< /alert >}}


<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@300;400;600;700&family=IBM+Plex+Mono:wght@400;600&display=swap');
  .energy-wrap {
    --bg:          #141414;
    --surface:     #1c1c1c;
    --border:      #2a2a2a;
    --text:        #e2e2e2;
    --text-muted:  #666666;
    --title-color: #f0f0f0;
    --grid:        rgba(255,255,255,0.045);
    --ref-line:    rgba(255,255,255,0.18);
    --zero-line:   rgba(255,255,255,0.10);
    --annot-bg:    rgba(20,20,20,0.85);
  }
  .energy-wrap.light {
    --bg:          #f5f4f0;
    --surface:     #ffffff;
    --border:      #dedbd5;
    --text:        #1a1a1a;
    --text-muted:  #888888;
    --title-color: #111111;
    --grid:        rgba(0,0,0,0.04);
    --ref-line:    rgba(0,0,0,0.20);
    --zero-line:   rgba(0,0,0,0.08);
    --annot-bg:    rgba(245,244,240,0.92);
  }
  .energy-wrap * { box-sizing: border-box; margin: 0; padding: 0; }
  .energy-wrap {
    background: var(--bg);
    color: var(--text);
    font-family: 'IBM Plex Sans', sans-serif;
    padding: 28px 36px 24px;
    border-radius: 12px;
    margin: 2rem 0;
    transition: background 0.3s, color 0.3s;
  }
  .energy-wrap .toggle-wrap { display: flex; justify-content: flex-end; margin-bottom: 14px; }
  .energy-wrap .toggle-btn {
    font-family: 'IBM Plex Mono', monospace;
    font-size: 10px; font-weight: 600;
    letter-spacing: 0.8px; text-transform: uppercase;
    padding: 5px 12px; border-radius: 4px;
    border: 1px solid var(--border);
    background: var(--surface); color: var(--text-muted);
    cursor: pointer; transition: all 0.2s;
  }
  .energy-wrap .toggle-btn:hover { color: var(--text); border-color: var(--text-muted); }
  .energy-wrap .header { margin-bottom: 16px; }
  .energy-wrap .header h2 {
    font-size: 16px; font-weight: 700;
    letter-spacing: -0.3px; line-height: 1.35;
    color: var(--title-color); margin-bottom: 5px;
  }
  .energy-wrap .header p { font-size: 11px; color: var(--text-muted); line-height: 1.5; }
  #energyChartWrap { width: 100%; position: relative; }
  #energySvg { width: 100%; display: block; overflow: visible; }
  .energy-wrap .footer {
    margin-top: 14px; padding-top: 10px;
    border-top: 1px solid var(--border);
    font-size: 10px; color: var(--text-muted); line-height: 1.7;
  }
  .energy-wrap .footer .source { font-style: italic; }
</style>

<div class="not-prose energy-wrap light" id="energyWrap">
  <div class="toggle-wrap">
    <button class="toggle-btn" id="energyToggleBtn" onclick="energyToggleMode()">🌙 Dark Mode</button>
  </div>
  <div class="header">
    <h2>Daily Price Change after the US–Iran Escalation, 2026</h2>
    <p>S&amp;P 500 energy constituents — indexed to zero at Feb 28, 2026 conflict onset</p>
  </div>
  <div id="energyChartWrap">
    <svg id="energySvg"></svg>
  </div>
  <div class="footer">
    <div class="source">Source: Yahoo Finance</div>
    <div>Note: Change index calculated relative to each stock's closing price at the conflict date (Feb 28, 2026).</div>
  </div>
</div>

<script>
(function() {
  const DATES = [
    '2026-02-25','2026-02-26','2026-02-27','2026-02-28',
    '2026-03-01','2026-03-02','2026-03-03','2026-03-04',
    '2026-03-05','2026-03-06','2026-03-07','2026-03-08',
    '2026-03-09','2026-03-10','2026-03-11','2026-03-12',
    '2026-03-13','2026-03-14',
  ];
  const RAW = {
    APA:  [-8.33,-4.18,0,0,0,4.35,4.87,2.40,6.62,7.61,7.61,7.61,7.31,4.77,8.56,10.67,13.50,13.50],
    BKR:  [-0.69,-0.55,0,0,0,-0.66,-4.17,-6.71,-7.77,-8.35,-8.35,-8.35,-7.91,-9.07,-9.64,-14.34,-16.86,-16.86],
    COP:  [-3.04,-2.43,0,0,0,4.21,4.46,1.93,2.96,3.18,3.18,3.18,3.15,0.61,3.15,5.99,7.43,7.43],
    CTRA: [-2.26,-1.90,0,0,0,3.01,1.01,-0.13,1.83,1.44,1.44,1.44,1.93,-0.59,3.23,5.31,5.87,5.87],
    CVX:  [-1.36,-1.39,0,0,0,1.52,1.08,-0.39,1.68,1.70,1.70,1.70,1.44,-0.25,2.69,5.47,5.39,5.39],
    DVN:  [-2.09,-2.00,0,0,0,3.26,1.08,-0.09,2.27,2.18,2.18,2.18,2.96,0.39,4.20,6.11,6.80,6.80],
    EOG:  [-1.27,-2.38,0,0,0,3.68,3.17,3.01,5.60,5.91,5.91,5.91,6.12,3.07,6.79,7.22,7.67,7.67],
    EQT:  [-3.32,-2.74,0,0,0,0.36,0.31,-0.18,0.41,0.88,0.88,0.88,1.32,0.67,3.92,5.24,4.80,4.80],
    EXE:  [-1.73,-1.51,0,0,0,0.53,0.06,-1.89,-0.62,-0.46,-0.46,-0.46,0.50,-2.48,1.16,0.46,-0.29,-0.29],
    FANG: [-3.62,-4.08,0,0,0,2.80,1.98,1.51,3.46,4.33,4.33,4.33,5.67,3.08,2.08,2.29,5.39,5.39],
    HAL:  [-2.03,-0.81,0,0,0,-0.08,-2.06,-3.90,-4.65,-4.96,-4.96,-4.96,-3.28,-1.36,0.29,-2.75,-5.96,-5.96],
    KMI:  [-1.50,-0.63,0,0,0,1.86,2.07,1.95,0.36,0.93,0.93,0.93,0.09,-0.93,-0.57,0.27,0.36,0.36],
    MPC:  [-1.23,1.44,0,0,0,5.86,6.95,11.38,9.66,11.64,11.64,11.64,8.82,8.59,14.39,16.07,14.11,14.11],
    OKE:  [-0.59,1.51,0,0,0,4.05,2.43,2.40,3.42,5.03,5.03,5.03,3.85,2.31,3.61,2.61,3.13,3.13],
    OXY:  [-4.03,-3.11,0,0,0,2.13,1.13,1.00,0.30,2.09,2.09,2.09,3.65,0.55,5.21,10.56,9.56,9.56],
    PSX:  [-1.57,-1.21,0,0,0,3.79,3.53,6.73,7.85,7.54,7.54,7.54,5.62,5.29,9.83,12.80,11.93,11.93],
    SLB:  [0.62,0.29,0,0,0,-0.14,-5.38,-6.72,-7.67,-8.65,-8.65,-8.65,-8.08,-6.29,-6.17,-13.21,-12.89,-12.89],
    TPL:  [-2.67,-2.24,0,0,0,1.41,-0.01,2.37,-0.07,0.26,0.26,0.26,3.07,-0.56,0.22,1.01,1.42,1.42],
    TRGP: [-2.40,-1.94,0,0,0,1.62,3.49,3.07,1.36,0.59,0.59,0.59,-0.45,-1.41,0.31,1.00,1.80,1.80],
    VLO:  [-2.44,-0.42,0,0,0,5.02,6.39,10.24,11.43,9.77,9.77,9.77,5.53,6.05,12.91,15.23,12.68,12.68],
    VST:  [0.85,1.68,0,0,0,-4.54,-7.01,-6.06,-3.73,-8.76,-8.76,-8.76,-5.91,-5.46,-8.47,-8.23,-8.59,-8.59],
    WMB:  [-1.00,0.07,0,0,0,2.06,1.55,1.41,0.07,-0.64,-0.64,-0.64,-2.06,-1.18,-0.43,-1.61,-1.14,-1.14],
    XOM:  [-2.26,-2.60,0,0,0,1.13,-0.44,-1.76,-1.14,-0.85,-0.85,-0.85,-1.35,-2.87,-0.60,0.68,2.37,2.37],
  };
  const COLS = ['MPC','APA','VLO','PSX','OXY','EOG','COP','DVN','CTRA','FANG',
                'CVX','EQT','OKE','XOM','TRGP','TPL','KMI','EXE','WMB','HAL',
                'VST','SLB','BKR'];
  const COLORS = [
    '#5778a4','#e49444','#d1615d','#85b6b2','#6a9f58',
    '#e7ca60','#a87c9f','#f1a2b1','#967662','#b8b0ac',
    '#c47596','#d3a7bc','#7abf73','#c4a444','#4d9490',
    '#82b4b0','#eec96a','#9dc6e0','#f5c07a','#979797',
    '#c9aac6','#82b4b0','#e0705a',
  ];
  const DIC_COLORS = {};
  COLS.forEach((c, i) => DIC_COLORS[c] = COLORS[i]);
  const HIGHLIGHT   = ['MPC','APA','VLO','PSX'];
  const CONFLICT_DT = '2026-02-28';
  const OFFSET_MAP = {
    MPC: [-150, -60],
    APA: [-70, -100],
    VLO: [-250, -25],
    PSX: [-150, -45],
  };
  const LOSERS_TEXT = `Top Losers\nEXE  -0.3%\nWMB  -1.1%\nHAL  -6.0%\nVST  -8.6%\nSLB  -12.9%\nBKR  -16.8%`;
  const PAD = { top: 20, right: 110, bottom: 44, left: 48 };

  function getCSSVar(n) {
    return getComputedStyle(document.getElementById('energyWrap')).getPropertyValue(n).trim();
  }
  function fmtDate(str) {
    const d = new Date(str);
    return d.toLocaleDateString('en-US', { month: 'short', day: 'numeric' });
  }

  function rebuild() {
    const wrap = document.getElementById('energyChartWrap');
    const svg  = document.getElementById('energySvg');
    const W    = wrap.clientWidth || 800;
    const H    = Math.round(W * 0.72);
    const cW   = W - PAD.left - PAD.right;
    const cH   = H - PAD.top  - PAD.bottom;
    svg.setAttribute('viewBox', `0 0 ${W} ${H}`);
    svg.setAttribute('height', H);
    svg.innerHTML = '';
    const ns = 'http://www.w3.org/2000/svg';
    const allVals = COLS.flatMap(c => RAW[c]);
    const Y_MIN   = Math.min(...allVals) - 2;
    const Y_MAX   = Math.max(...allVals) + 2;
    const X_MAX   = DATES.length - 1;
    function xS(i) { return PAD.left + (i / X_MAX) * cW; }
    function yS(v) { return PAD.top  + ((Y_MAX - v) / (Y_MAX - Y_MIN)) * cH; }
    // Grid
    [-15,-10,-5,0,5,10,15].forEach(v => {
      if (v < Y_MIN || v > Y_MAX) return;
      const l = document.createElementNS(ns, 'line');
      l.setAttribute('x1', PAD.left); l.setAttribute('x2', PAD.left + cW);
      l.setAttribute('y1', yS(v)); l.setAttribute('y2', yS(v));
      l.setAttribute('stroke', v === 0 ? getCSSVar('--zero-line') : getCSSVar('--grid'));
      l.setAttribute('stroke-width', v === 0 ? '1' : '0.8');
      svg.appendChild(l);
      const t = document.createElementNS(ns, 'text');
      t.setAttribute('x', PAD.left - 6);
      t.setAttribute('y', yS(v) + 3.5);
      t.setAttribute('text-anchor', 'end');
      t.setAttribute('font-size', '8.5');
      t.setAttribute('fill', getCSSVar('--text-muted'));
      t.setAttribute('font-family', 'IBM Plex Mono, monospace');
      t.textContent = `${v > 0 ? '+' : ''}${v}%`;
      svg.appendChild(t);
    });
    // X-axis ticks
    DATES.forEach((d, i) => {
      if (i % 3 !== 0) return;
      const t = document.createElementNS(ns, 'text');
      t.setAttribute('x', xS(i));
      t.setAttribute('y', PAD.top + cH + 14);
      t.setAttribute('text-anchor', 'middle');
      t.setAttribute('font-size', '8.5');
      t.setAttribute('fill', getCSSVar('--text-muted'));
      t.setAttribute('font-family', 'IBM Plex Mono, monospace');
      t.textContent = fmtDate(d);
      svg.appendChild(t);
    });
    // Conflict date vertical line
    const conflictIdx = DATES.indexOf(CONFLICT_DT);
    const conflictX   = xS(conflictIdx);
    const vl = document.createElementNS(ns, 'line');
    vl.setAttribute('x1', conflictX); vl.setAttribute('x2', conflictX);
    vl.setAttribute('y1', PAD.top);   vl.setAttribute('y2', PAD.top + cH);
    vl.setAttribute('stroke', getCSSVar('--ref-line'));
    vl.setAttribute('stroke-width', '1.2');
    vl.setAttribute('stroke-dasharray', '4,3');
    svg.appendChild(vl);
    const cl = document.createElementNS(ns, 'text');
    cl.setAttribute('x', conflictX + 5);
    cl.setAttribute('y', yS(Y_MIN) - 24);
    cl.setAttribute('font-size', '8.5');
    cl.setAttribute('fill', getCSSVar('--text-muted'));
    cl.setAttribute('font-family', 'IBM Plex Sans, sans-serif');
    cl.textContent = 'conflict starts (Feb 28)';
    svg.appendChild(cl);
    // Background lines (faint)
    COLS.forEach(col => {
      const pts = RAW[col].map((v, i) => `${xS(i)},${yS(v)}`).join(' ');
      const pl  = document.createElementNS(ns, 'polyline');
      pl.setAttribute('points', pts);
      pl.setAttribute('fill', 'none');
      pl.setAttribute('stroke', DIC_COLORS[col]);
      pl.setAttribute('stroke-width', '1');
      pl.setAttribute('opacity', '0.12');
      svg.appendChild(pl);
    });
    // Highlighted lines
    HIGHLIGHT.forEach(col => {
      const pts = RAW[col].map((v, i) => `${xS(i)},${yS(v)}`).join(' ');
      const pl  = document.createElementNS(ns, 'polyline');
      pl.setAttribute('points', pts);
      pl.setAttribute('fill', 'none');
      pl.setAttribute('stroke', DIC_COLORS[col]);
      pl.setAttribute('stroke-width', '2.2');
      pl.setAttribute('opacity', '1');
      svg.appendChild(pl);
    });
    // Annotations on highlighted tickers
    HIGHLIGHT.forEach(col => {
      const vals  = RAW[col];
      const endX  = xS(DATES.length - 1);
      const endY  = yS(vals[vals.length - 1]);
      const endV  = vals[vals.length - 1];
      const label = `${col}  ${endV > 0 ? '+' : ''}${endV.toFixed(1)}%`;
      const color = DIC_COLORS[col];
      const [ox, oy] = OFFSET_MAP[col];
      const scale = W / 800;
      const tx    = endX + ox * scale;
      const ty    = endY + oy * scale;
      const dx = tx - endX, dy = ty - endY;
      const mx = endX + dx * 0.5, my = endY + dy * 0.5;
      const cpx = mx - dy * 0.3, cpy = my + dx * 0.3;
      const path = document.createElementNS(ns, 'path');
      path.setAttribute('d', `M ${endX} ${endY} Q ${cpx} ${cpy} ${tx} ${ty}`);
      path.setAttribute('fill', 'none');
      path.setAttribute('stroke', color);
      path.setAttribute('stroke-width', '1.2');
      path.setAttribute('opacity', '0.25');
      path.setAttribute('marker-end', `url(#arrow-${col})`);
      svg.appendChild(path);
      const defs = svg.querySelector('defs') || (() => {
        const d = document.createElementNS(ns, 'defs');
        svg.insertBefore(d, svg.firstChild);
        return d;
      })();
      const marker = document.createElementNS(ns, 'marker');
      marker.setAttribute('id', `arrow-${col}`);
      marker.setAttribute('markerWidth', '6'); marker.setAttribute('markerHeight', '6');
      marker.setAttribute('refX', '3'); marker.setAttribute('refY', '3');
      marker.setAttribute('orient', 'auto');
      const tri = document.createElementNS(ns, 'path');
      tri.setAttribute('d', 'M 0 0 L 6 3 L 0 6 Z');
      tri.setAttribute('fill', color); tri.setAttribute('opacity', '0.4');
      marker.appendChild(tri);
      defs.appendChild(marker);
      const chars  = label.length;
      const bW     = chars * 6.2 + 10, bH = 16;
      const rect   = document.createElementNS(ns, 'rect');
      rect.setAttribute('x', tx - bW/2); rect.setAttribute('y', ty - bH/2);
      rect.setAttribute('width', bW); rect.setAttribute('height', bH);
      rect.setAttribute('rx', '3');
      rect.setAttribute('fill', color); rect.setAttribute('opacity', '0.12');
      svg.appendChild(rect);
      const t = document.createElementNS(ns, 'text');
      t.setAttribute('x', tx); t.setAttribute('y', ty + 4);
      t.setAttribute('text-anchor', 'middle');
      t.setAttribute('font-size', '10'); t.setAttribute('font-weight', '700');
      t.setAttribute('fill', color);
      t.setAttribute('font-family', 'IBM Plex Mono, monospace');
      t.textContent = label;
      svg.appendChild(t);
    });
    // Top Losers annotation
    const loserLines = LOSERS_TEXT.split('\n');
    const lx = PAD.left + cW - 8;
    const ly = yS(Y_MIN) - loserLines.length * 13 + 6;
    loserLines.forEach((line, i) => {
      const t = document.createElementNS(ns, 'text');
      t.setAttribute('x', lx);
      t.setAttribute('y', ly + i * 13);
      t.setAttribute('text-anchor', 'end');
      t.setAttribute('font-size', i === 0 ? '9' : '8.5');
      t.setAttribute('font-weight', i === 0 ? '600' : '400');
      t.setAttribute('fill', getCSSVar('--text-muted'));
      t.setAttribute('opacity', '0.65');
      t.setAttribute('font-family', 'IBM Plex Mono, monospace');
      t.textContent = line;
      svg.appendChild(t);
    });
    // Watermark
    const wm = document.createElementNS(ns, 'text');
    wm.setAttribute('x', PAD.left + cW);
    wm.setAttribute('y', yS(0) + 14);
    wm.setAttribute('text-anchor', 'end');
    wm.setAttribute('font-size', '10');
    wm.setAttribute('fill', getCSSVar('--text-muted'));
    wm.setAttribute('opacity', '0.10');
    wm.setAttribute('font-family', 'IBM Plex Sans, sans-serif');
    wm.textContent = '@thechartroom31';
    svg.appendChild(wm);
    // Y-axis label
    const yl = document.createElementNS(ns, 'text');
    yl.setAttribute('transform', `rotate(-90, 12, ${PAD.top + cH/2})`);
    yl.setAttribute('x', 12); yl.setAttribute('y', PAD.top + cH/2);
    yl.setAttribute('text-anchor', 'middle');
    yl.setAttribute('font-size', '9');
    yl.setAttribute('fill', getCSSVar('--text-muted'));
    yl.setAttribute('font-family', 'IBM Plex Sans, sans-serif');
    yl.textContent = 'Price Change (%)';
    svg.appendChild(yl);
    // Inline legend (right side)
    const legendY = PAD.top + 10;
    HIGHLIGHT.forEach((col, i) => {
      const color = DIC_COLORS[col];
      const ly2   = legendY + i * 16;
      const line = document.createElementNS(ns, 'line');
      line.setAttribute('x1', PAD.left + cW + 8); line.setAttribute('x2', PAD.left + cW + 22);
      line.setAttribute('y1', ly2 + 4); line.setAttribute('y2', ly2 + 4);
      line.setAttribute('stroke', color); line.setAttribute('stroke-width', '2');
      svg.appendChild(line);
      const t = document.createElementNS(ns, 'text');
      t.setAttribute('x', PAD.left + cW + 26);
      t.setAttribute('y', ly2 + 7.5);
      t.setAttribute('font-size', '8.5');
      t.setAttribute('fill', color);
      t.setAttribute('font-family', 'IBM Plex Mono, monospace');
      t.textContent = col;
      svg.appendChild(t);
    });
  }

  function energyToggleMode() {
    const wrap = document.getElementById('energyWrap');
    const btn  = document.getElementById('energyToggleBtn');
    const isLight = wrap.classList.toggle('light');
    btn.textContent = isLight ? '🌙 Dark Mode' : '☀ Light Mode';
    rebuild();
  }
  window.energyToggleMode = energyToggleMode;

  rebuild();
  window.addEventListener('resize', rebuild);
})();
</script>

## Insight

When Iran escalation started on 28 February, nearly every sector fell sharply, except energy. The strength was surprising enough to push investors toward this sector. 

17 of 23 energy names closed higher over the two week period, meaning around 75% companies moved in the positive direction. The top gainers were led by MPC (14.1%), APA (+13.5%), VLO (+12.7%), and PSX (+11.9%), all crossing the 10% mark by 13 March. Interestingly, oil refining companies led the charge, suggesting the market expected tighter fuel supply, not just higher oil prices.

Pipeline companies told a more different story. Some, like KMI and OKE, gained small throughout the period.

On the losing side, oil services companies struggled the most, SLB plummeted by 12.9% and BKR fell even harder at 16.8%. Even when the broader sector was rising, some firms could still fall behind.

## Attachment

Table ticker's abbreviation

| Ticker | Company Name | Category | Subcategory |
|--------|-------------|----------|-------------|
| APA | APA Corporation | Energy | Oil & Gas Exploration & Production |
| BKR | Baker Hughes Company | Energy | Oil & Gas Equipment & Services |
| COP | ConocoPhillips | Energy | Oil & Gas Exploration & Production |
| CTRA | Coterra Energy | Energy | Oil & Gas Exploration & Production |
| CVX | Chevron Corporation | Energy | Integrated Oil & Gas |
| DVN | Devon Energy | Energy | Oil & Gas Exploration & Production |
| EOG | EOG Resources | Energy | Oil & Gas Exploration & Production |
| EQT | EQT Corporation | Energy | Oil & Gas Exploration & Production |
| EXE | Expand Energy Corporation | Energy | Oil & Gas Exploration & Production |
| FANG | Diamondback Energy | Energy | Oil & Gas Exploration & Production |
| HAL | Halliburton Company | Energy | Oil & Gas Equipment & Services |
| KMI | Kinder Morgan | Energy | Oil & Gas Midstream |
| MPC | Marathon Petroleum | Energy | Oil & Gas Refining & Marketing |
| OKE | ONEOK Inc | Energy | Oil & Gas Midstream |
| OXY | Occidental Petroleum | Energy | Integrated Oil & Gas |
| PSX | Phillips 66 | Energy | Oil & Gas Refining & Marketing |
| SLB | SLB (Schlumberger) | Energy | Oil & Gas Equipment & Services |
| TPL | Texas Pacific Land Corporation | Energy | Oil & Gas Land & Royalties |
| TRGP | Targa Resources | Energy | Oil & Gas Midstream |
| VLO | Valero Energy | Energy | Oil & Gas Refining & Marketing |
| VST | Vistra Corp | Utilities | Independent Power Producer |
| WMB | Williams Companies | Energy | Oil & Gas Midstream |
| XOM | Exxon Mobil Corporation | Energy | Integrated Oil & Gas |
