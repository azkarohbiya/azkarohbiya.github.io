---
title: "Gross Margin Ranking, AI Competition, Q2 2021 – Q1 202"
highlight: true
categories: ["general"]
date : "2026-03-29"
result: ""
summary: ""
weight: 10
showTableOfContents: true
---

{{< alert >}}
**Note**
Data sourced from Yahoo Finance. This content is for educational purposes only and does not constitute financial advice.
{{< /alert >}}

<style>
  .gm-wrap {
    --bg:         #ffffff;
    --bg2:        #f5f5f5;
    --text:       #1a1a1a;
    --text-muted: #666666;
    --grid:       rgba(0,0,0,0.07);
    --border:     rgba(0,0,0,0.15);
    --tip-bg:     #ffffff;
  }
  .gm-wrap.dark {
    --bg:         #0f1117;
    --bg2:        #1e2030;
    --text:       #e0e0e0;
    --text-muted: #888888;
    --grid:       rgba(255,255,255,0.06);
    --border:     rgba(255,255,255,0.15);
    --tip-bg:     #1a1d2e;
  }
  .gm-wrap * { box-sizing: border-box; margin: 0; padding: 0; }
  .gm-wrap {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    background: var(--bg);
    color: var(--text);
    padding: 32px 24px;
    border-radius: 12px;
    margin: 2rem 0;
    transition: background 0.3s, color 0.3s;
  }
  .gm-wrap h2 { font-size: 20px; font-weight: 500; color: var(--text); margin-bottom: 4px; }
  .gm-wrap p.sub { font-size: 13px; color: var(--text-muted); margin-bottom: 20px; }
  .gm-wrap .legend { display: flex; flex-wrap: wrap; gap: 6px; margin-bottom: 14px; }
  .gm-wrap .legend-item { display: flex; align-items: center; gap: 5px; font-size: 11px; color: var(--text-muted); cursor: pointer; padding: 3px 8px; border-radius: 4px; border: 0.5px solid transparent; transition: border-color 0.15s, background 0.15s; }
  .gm-wrap .legend-item:hover { border-color: var(--border); }
  .gm-wrap .legend-item.active { border-color: var(--border); background: var(--bg2); }
  .gm-wrap .legend-dot { width: 9px; height: 9px; border-radius: 50%; flex-shrink: 0; }
  .gm-wrap .chart-wrap { position: relative; width: 100%; }
  .gm-wrap canvas { display: block; width: 100% !important; }
  .gm-wrap .tip { position: absolute; background: var(--tip-bg); border: 0.5px solid var(--border); border-radius: 8px; padding: 7px 12px; font-size: 12px; color: var(--text); pointer-events: none; white-space: nowrap; z-index: 10; display: none; }
  .gm-wrap .note { font-size: 11px; color: var(--text-muted); margin-top: 12px; }
  .gm-wrap .toggle-btn { display: flex; align-items: center; gap: 8px; font-size: 12px; color: var(--text-muted); cursor: pointer; padding: 5px 12px; border-radius: 20px; border: 0.5px solid var(--border); background: transparent; margin-bottom: 20px; transition: background 0.15s; }
  .gm-wrap .toggle-btn:hover { background: var(--bg2); }
  .gm-wrap .toggle-icon { font-size: 14px; }
</style>

<div class="not-prose gm-wrap" id="gmWrap">
  <div style="display:flex; justify-content:space-between; align-items:flex-start; flex-wrap:wrap; gap:12px; margin-bottom:4px;">
    <div>
      <h2>Gross Margin Ranking, AI Competition, Q2 2021 – Q1 2026</h2>
      <p class="sub">Quarterly gross margin rank across 15 AI-era tech companies. Rank 1 = highest gross margin. Click a ticker to highlight.</p>
    </div>
    <button class="toggle-btn" id="gmToggleBtn" onclick="gmToggleTheme()">
      <span class="toggle-icon" id="gmThemeIcon">☀️</span>
      <span id="gmThemeLabel">Light</span>
    </button>
  </div>
  <div class="legend" id="gmLegend"></div>
  <div class="chart-wrap" id="gmChartWrap">
    <canvas id="gmCanvas"></canvas>
    <div class="tip" id="gmTip"></div>
  </div>
  <p class="note">Source: Stockanalysis.com &nbsp;·&nbsp; Note: Rankings computed quarterly. Label shows Q1 2026 gross margin %.</p>
</div>

<script>
(function() {
  const DATA = [
    { ticker:'NVDA',  gm:75.00, ranks:[3,3,3,4,4,13,7,4,4,3,2,2,2,2,2,2,4,2,2,2] },
    { ticker:'AMD',   gm:54.30, ranks:[13,11,11,11,11,9,14,13,12,11,11,10,12,10,9,9,11,14,8,8] },
    { ticker:'INTC',  gm:36.15, ranks:[7,7,7,8,9,15,13,15,15,15,14,14,15,15,15,15,15,15,15,15] },
    { ticker:'QCOM',  gm:54.55, ranks:[5,5,5,5,5,5,5,6,7,6,6,5,6,6,7,7,7,7,7,7] },
    { ticker:'AVGO',  gm:68.13, ranks:[4,4,4,3,3,3,3,2,2,4,4,4,4,4,4,4,3,4,4,3] },
    { ticker:'MRVL',  gm:51.74, ranks:[10,15,10,10,8,6,9,9,13,14,15,12,14,14,14,10,10,10,10,10] },
    { ticker:'TSM',   gm:62.33, ranks:[9,9,8,9,7,7,4,5,5,7,7,7,7,7,6,5,6,6,6,5] },
    { ticker:'ASML',  gm:52.16, ranks:[8,8,9,7,10,8,8,8,8,8,8,8,8,8,8,8,8,8,9,9] },
    { ticker:'AMAT',  gm:48.99, ranks:[11,10,12,12,12,10,11,10,10,10,12,9,11,12,12,11,12,12,13,12] },
    { ticker:'LRCX',  gm:49.60, ranks:[12,12,13,13,13,11,10,11,14,12,10,11,10,11,11,12,13,11,12,11] },
    { ticker:'MSFT',  gm:68.04, ranks:[2,2,2,2,2,2,2,3,3,2,3,3,3,3,3,3,2,3,3,4] },
    { ticker:'GOOGL', gm:59.79, ranks:[6,6,6,6,6,4,6,7,6,5,5,6,5,5,5,6,5,5,5,6] },
    { ticker:'AMZN',  gm:48.47, ranks:[15,14,14,15,15,12,12,14,9,9,9,15,9,9,10,13,9,9,11,13] },
    { ticker:'META',  gm:81.79, ranks:[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1] },
    { ticker:'AAPL',  gm:48.16, ranks:[14,13,15,14,14,14,15,12,11,13,13,13,13,13,13,14,14,13,14,14] },
  ];
  const QUARTERS = ['Q221','Q321','Q421','Q122','Q222','Q322','Q422','Q123','Q223','Q323','Q423','Q124','Q224','Q324','Q424','Q125','Q225','Q325','Q425','Q126'];
  const nQ = QUARTERS.length;
  const COLORS = {
    NVDA:'#76b900', AMD:'#e9390a', INTC:'#0068b5', QCOM:'#3253dc',
    AVGO:'#ca0a14', MRVL:'#6600cc', TSM:'#00aaff', ASML:'#0071b9',
    AMAT:'#00b4e6', LRCX:'#d4008f', MSFT:'#00a4ef', GOOGL:'#4285f4',
    AMZN:'#ff9900', META:'#0082fb', AAPL:'#888888'
  };
  let highlighted = null;
  let isDark = false;

  function getCSSVar(name) {
    return getComputedStyle(document.getElementById('gmWrap')).getPropertyValue(name).trim();
  }
  function sigmoid(t) { return 1/(1+Math.exp(-t)); }
  function interpolate(x0,y0,x1,y1,steps=60) {
    const pts=[];
    for (let i=0;i<=steps;i++) {
      const t=i/steps, frac=sigmoid(-6+t*12);
      pts.push({ x:x0+t*(x1-x0), y:y0+frac*(y1-y0) });
    }
    return pts;
  }
  function layout(canvas) {
    const dpr = window.devicePixelRatio||1;
    const W = canvas.width/dpr;
    const H = canvas.height/dpr;
    const padL=38, padR=92, padT=16, padB=32;
    const cW=W-padL-padR, cH=H-padT-padB;
    const toX = i => padL+i*(cW/(nQ-1));
    const toY = r => padT+(r-1)*(cH/14);
    return { padL,padR,padT,padB,cW,cH,W,H,toX,toY };
  }
  function draw(canvas, ctx) {
    const dpr = window.devicePixelRatio||1;
    const L = layout(canvas);
    ctx.clearRect(0,0,canvas.width,canvas.height);
    ctx.save(); ctx.scale(dpr,dpr);
    const gridCol = getCSSVar('--grid');
    const textCol = getCSSVar('--text-muted');
    for (let i=0;i<nQ;i++) {
      const x=L.toX(i);
      ctx.strokeStyle=gridCol; ctx.lineWidth=0.5;
      ctx.beginPath(); ctx.moveTo(x,L.padT); ctx.lineTo(x,L.padT+L.cH); ctx.stroke();
      if (i%2===0) {
        ctx.fillStyle=textCol; ctx.textAlign='center'; ctx.font='10px sans-serif';
        ctx.fillText(QUARTERS[i], x, L.padT+L.cH+18);
      }
    }
    for (let r=1;r<=15;r++) {
      const y=L.toY(r);
      ctx.strokeStyle=gridCol; ctx.lineWidth=0.5;
      ctx.beginPath(); ctx.moveTo(L.padL,y); ctx.lineTo(L.padL+L.cW,y); ctx.stroke();
      ctx.fillStyle=textCol; ctx.textAlign='right'; ctx.font='10px sans-serif';
      ctx.fillText(r, L.padL-6, y+3.5);
    }
    DATA.forEach(({ticker,gm,ranks}) => {
      const color = COLORS[ticker];
      const isHl  = highlighted===ticker;
      const isDim = highlighted!==null && !isHl;
      ctx.globalAlpha = isDim ? 0.06 : 1;
      ctx.strokeStyle = color;
      ctx.lineWidth   = isHl ? 3 : 1.6;
      ctx.lineJoin    = 'round';
      ctx.beginPath();
      let first=true;
      for (let i=0;i<nQ-1;i++) {
        interpolate(L.toX(i),L.toY(ranks[i]),L.toX(i+1),L.toY(ranks[i+1])).forEach(p => {
          if (first) { ctx.moveTo(p.x,p.y); first=false; } else ctx.lineTo(p.x,p.y);
        });
      }
      ctx.stroke();
      ranks.forEach((r,i) => {
        ctx.fillStyle=color;
        ctx.beginPath();
        ctx.arc(L.toX(i),L.toY(r),isHl?4.5:3,0,Math.PI*2);
        ctx.fill();
      });
      const lx=L.toX(nQ-1)+7, ly=L.toY(ranks[nQ-1]);
      ctx.textAlign='left';
      ctx.font=`${isHl?'500 12px':'11px'} sans-serif`;
      ctx.fillStyle=color; ctx.globalAlpha=isDim?0.06:1;
      ctx.fillText(ticker, lx, ly-3);
      ctx.font='10px sans-serif'; ctx.globalAlpha=isDim?0.06:0.65;
      ctx.fillText(`${gm.toFixed(1)}%`, lx, ly+10);
      ctx.globalAlpha=1;
    });
    ctx.restore();
  }
  function applyTheme(dark) {
    const wrap = document.getElementById('gmWrap');
    if (dark) { wrap.classList.add('dark'); } else { wrap.classList.remove('dark'); }
    document.getElementById('gmThemeIcon').textContent  = dark ? '🌙' : '☀️';
    document.getElementById('gmThemeLabel').textContent = dark ? 'Dark' : 'Light';
  }
  function gmToggleTheme() {
    isDark = !isDark;
    applyTheme(isDark);
    draw(canvas, ctx);
  }
  window.gmToggleTheme = gmToggleTheme;

  const ASPECT = 520 / 600;
  function resize(canvas, ctx) {
    const dpr  = window.devicePixelRatio||1;
    const cssW = document.getElementById('gmChartWrap').clientWidth;
    const cssH = Math.round(cssW * ASPECT);
    canvas.style.height = cssH + 'px';
    canvas.width  = cssW * dpr;
    canvas.height = cssH * dpr;
    draw(canvas, ctx);
  }
  function initCanvas(canvas) {
    const dpr  = window.devicePixelRatio||1;
    const cssW = document.getElementById('gmChartWrap').clientWidth;
    const cssH = Math.round(cssW * ASPECT);
    canvas.style.height = cssH + 'px';
    canvas.width  = cssW * dpr;
    canvas.height = cssH * dpr;
    return canvas.getContext('2d');
  }
  function buildLegend(canvas, ctx) {
    const el = document.getElementById('gmLegend');
    DATA.forEach(({ticker}) => {
      const item=document.createElement('div');
      item.className='legend-item';
      item.innerHTML=`<div class="legend-dot" style="background:${COLORS[ticker]}"></div>${ticker}`;
      item.addEventListener('click', () => {
        highlighted = highlighted===ticker ? null : ticker;
        document.getElementById('gmWrap').querySelectorAll('.legend-item').forEach(l=>l.classList.remove('active'));
        if (highlighted) item.classList.add('active');
        draw(canvas,ctx);
      });
      el.appendChild(item);
    });
  }
  function setupHover(canvas, ctx) {
    const tip = document.getElementById('gmTip');
    canvas.addEventListener('mousemove', e => {
      const rect=canvas.getBoundingClientRect();
      const mx=e.clientX-rect.left, my=e.clientY-rect.top;
      const L=layout(canvas);
      let found=null, best=14;
      DATA.forEach(({ticker,gm,ranks}) => {
        ranks.forEach((r,i) => {
          const dx=mx-L.toX(i), dy=my-L.toY(r), d=Math.sqrt(dx*dx+dy*dy);
          if (d<best) { best=d; found={ticker,gm,q:QUARTERS[i],rank:r}; }
        });
      });
      if (found) {
        tip.style.display='block';
        tip.style.left=(mx+14)+'px'; tip.style.top=(my-10)+'px';
        tip.style.color=COLORS[found.ticker];
        tip.innerHTML=`<strong>${found.ticker}</strong> &nbsp;·&nbsp; ${found.q} &nbsp;·&nbsp; Rank <strong>${found.rank}</strong> &nbsp;·&nbsp; GM ${found.gm.toFixed(2)}%`;
        canvas.style.cursor='pointer';
      } else { tip.style.display='none'; canvas.style.cursor='default'; }
    });
    canvas.addEventListener('mouseleave', ()=>{ tip.style.display='none'; });
    canvas.addEventListener('click', e => {
      const rect=canvas.getBoundingClientRect();
      const mx=e.clientX-rect.left, my=e.clientY-rect.top;
      const L=layout(canvas);
      let found=null, best=14;
      DATA.forEach(({ticker,ranks}) => {
        ranks.forEach((r,i) => {
          const dx=mx-L.toX(i), dy=my-L.toY(r), d=Math.sqrt(dx*dx+dy*dy);
          if (d<best) { best=d; found=ticker; }
        });
      });
      if (found) {
        highlighted = highlighted===found ? null : found;
        document.getElementById('gmWrap').querySelectorAll('.legend-item').forEach(l => {
          l.classList.toggle('active', l.textContent.trim()===highlighted);
        });
        draw(canvas,ctx);
      }
    });
  }

  const canvas = document.getElementById('gmCanvas');
  const ctx    = initCanvas(canvas);
  applyTheme(false);
  buildLegend(canvas, ctx);
  setupHover(canvas, ctx);
  draw(canvas, ctx);

  let resizeTimer;
  window.addEventListener('resize', () => {
    clearTimeout(resizeTimer);
    resizeTimer = setTimeout(() => resize(canvas, ctx), 80);
  });
})();
</script>


{{< alert >}}
**Note**
The chart is clickable object
{{< /alert >}}

There's a moment in every market cycle where the data stops being noise and starts telling a story. For Nvidia, that moment is hiding in plain sight inside its gross margin history.
Back in Q2 2021, Nvidia sat comfortably at rank 3 among the fifteen most important tech companies in the AI era. Nothing extraordinary, just a solid chipmaker riding a wave of gaming and crypto demand. Then came Q3 2022. That wave broke hard. Crypto collapsed, gaming softened, and Nvidia's gross margin ranking fell to 13 out of 15. Nearly dead last. The kind of number that makes investors nervous.
Most people stopped paying attention at exactly the wrong moment.
Because six months later, ChatGPT launched — and everything changed. Data center orders exploded. Margins recovered. By Q4 2023, Nvidia had climbed back to rank 2, sitting just behind Meta, the only company in this universe with structurally superior margins. It has held that position ever since.
The fall wasn't a sign of weakness. It was the last quiet moment before the most dramatic margin recovery in modern semiconductor history.

