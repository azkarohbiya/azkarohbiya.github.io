---
title: "Defense and Energy Stocks after Two Weeks of Conflict"
highlight: true
categories: ["general"]
date : "2026-03-17"
result: ""
summary: ""
weight: 6
showTableOfContents: true
---

{{< alert >}}
**Note** This project uses data that sources from Yahoo Finance. This content purposes to learn how market react because of global event not as financial advisors
{{< /alert >}}

<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@300;400;600;700&family=IBM+Plex+Mono:wght@400;600&display=swap');
  .scatter-wrap {
    --bg:          #151515;
    --surface:     #1e1e1e;
    --border:      #2a2a2a;
    --text:        #e0e0e0;
    --text-muted:  #777777;
    --title-color: #f2f2f2;
    --grid-line:   rgba(255,255,255,0.06);
    --ref-line:    rgba(255,255,255,0.20);
    --c-energy:    #38a3a5;
    --c-defense:   #c77dff;
    --c-label:     #cccccc;
    --c-arrow:     #8B8B8B;
  }
  .scatter-wrap.light {
    --bg:          #f5f4f0;
    --surface:     #ffffff;
    --border:      #e0ddd8;
    --text:        #1a1a1a;
    --text-muted:  #888888;
    --title-color: #111111;
    --grid-line:   rgba(0,0,0,0.05);
    --ref-line:    rgba(0,0,0,0.20);
    --c-energy:    #1a7a7c;
    --c-defense:   #7b2fd4;
    --c-label:     #333333;
    --c-arrow:     #aaaaaa;
  }
  .scatter-wrap * { box-sizing: border-box; }
  .scatter-wrap {
    background: var(--bg);
    color: var(--text);
    font-family: 'IBM Plex Sans', sans-serif;
    padding: 28px 36px 24px;
    border-radius: 12px;
    margin: 2rem 0;
    transition: background 0.3s, color 0.3s;
  }
  .scatter-wrap .toggle-wrap { display: flex; justify-content: flex-end; margin-bottom: 14px; }
  .scatter-wrap .toggle-btn {
    font-family: 'IBM Plex Mono', monospace;
    font-size: 10px; font-weight: 600;
    letter-spacing: 0.8px; text-transform: uppercase;
    padding: 5px 12px; border-radius: 4px;
    border: 1px solid var(--border);
    background: var(--surface); color: var(--text-muted);
    cursor: pointer; transition: all 0.2s;
  }
  .scatter-wrap .toggle-btn:hover { color: var(--text); border-color: var(--text-muted); }
  .scatter-wrap .header { margin-bottom: 18px; }
  .scatter-wrap .header h2 {
    font-size: 16px; font-weight: 700;
    letter-spacing: -0.3px; line-height: 1.35;
    color: var(--title-color); margin-bottom: 5px;
  }
  .scatter-wrap .header p { font-size: 11px; color: var(--text-muted); line-height: 1.5; }
  .scatter-wrap .chart-inner { position: relative; width: 100%; }
  .scatter-wrap .chart-inner svg { width: 100%; display: block; overflow: visible; }
  .scatter-wrap .footer {
    margin-top: 14px; padding-top: 10px;
    border-top: 1px solid var(--border);
    font-size: 10px; color: var(--text-muted); line-height: 1.7;
  }
  .scatter-wrap .footer .source { font-style: italic; }
</style>

<div class="not-prose scatter-wrap light" id="scatterWrap">
  <div class="toggle-wrap">
    <button class="toggle-btn" id="scatterToggleBtn" onclick="scatterToggleMode()">🌙 Dark Mode</button>
  </div>
  <div class="header">
    <h2>Return vs Risk in Energy and Defense Stocks</h2>
    <p>Each square represents an S&amp;P 500 constituent. Size reflects market capitalisation.</p>
  </div>
  <div class="chart-inner" id="scatterChartWrap">
    <svg id="scatterSvg"></svg>
  </div>
  <div class="footer">
    <div class="source">Source: Yahoo Finance</div>
    <div>Note: Volatility uses a pre-conflict baseline (1-year ending Feb 27, 2026). Returns measured from Feb 28, 2026 onward. Size = market cap.</div>
  </div>
</div>

<script>
  (function() {
    const energy = [
      { ticker:'APA',  ret:  8.77, vol: 54.84, mktcap: 14571623385.0   },
      { ticker:'BKR',  ret:-16.30, vol: 36.48, mktcap: 62990196806.12  },
      { ticker:'COP',  ret:  3.09, vol: 34.89, mktcap: 159826961788.21 },
      { ticker:'CTRA', ret:  2.77, vol: 31.02, mktcap: 26559359223.13  },
      { ticker:'CVX',  ret:  3.81, vol: 25.14, mktcap: 418164792609.46 },
      { ticker:'DVN',  ret:  3.43, vol: 41.80, mktcap: 31146572973.66  },
      { ticker:'EOG',  ret:  3.85, vol: 29.66, mktcap: 77727229108.5   },
      { ticker:'EQT',  ret:  4.43, vol: 36.91, mktcap: 41601618978.97  },
      { ticker:'EXE',  ret: -0.82, vol: 33.69, mktcap: 26809213148.20  },
      { ticker:'FANG', ret:  2.51, vol: 39.51, mktcap: 56286801411.75  },
      { ticker:'HAL',  ret: -5.88, vol: 44.34, mktcap: 32263755323.82  },
      { ticker:'KMI',  ret: -1.48, vol: 22.99, mktcap: 75865894742.91  },
      { ticker:'MPC',  ret:  7.80, vol: 34.71, mktcap: 72243762023.05  },
      { ticker:'OKE',  ret: -0.88, vol: 31.27, mktcap: 57725970198.78  },
      { ticker:'OXY',  ret:  7.28, vol: 38.48, mktcap: 61371054611.66  },
      { ticker:'PSX',  ret:  7.84, vol: 36.30, mktcap: 73139789253.87  },
      { ticker:'SLB',  ret:-12.78, vol: 38.07, mktcap: 76009882024.63  },
      { ticker:'TPL',  ret:  0.01, vol: 50.21, mktcap: 37204311299.24  },
      { ticker:'TRGP', ret:  0.18, vol: 35.28, mktcap: 52538518073.57  },
      { ticker:'VLO',  ret:  7.30, vol: 37.96, mktcap: 72172970089.87  },
      { ticker:'VST',  ret: -4.24, vol: 56.47, mktcap: 52001173317.54  },
      { ticker:'WMB',  ret: -3.14, vol: 25.17, mktcap: 91336269708.76  },
      { ticker:'XOM',  ret:  1.23, vol: 25.00, mktcap: 690766040151.96 },
    ];
    const defense = [
      { ticker:'BA',   ret: -8.64, vol: 37.62, mktcap: 153534298852.5  },
      { ticker:'GD',   ret: -3.64, vol: 22.32, mktcap: 93784689559.48  },
      { ticker:'GE',   ret:-13.19, vol: 31.53, mktcap: 303944622016.58 },
      { ticker:'HEI',  ret:-12.39, vol: 28.99, mktcap: 38829365285.07  },
      { ticker:'HII',  ret: -8.38, vol: 35.29, mktcap: 15664111485.79  },
      { ticker:'HON',  ret: -5.46, vol: 24.98, mktcap: 142308783976.47 },
      { ticker:'LHX',  ret: -4.83, vol: 23.93, mktcap: 64860574697.25  },
      { ticker:'LMT',  ret: -4.54, vol: 26.92, mktcap: 141849165185.70 },
      { ticker:'NOC',  ret: -4.47, vol: 28.64, mktcap: 97689742969.87  },
      { ticker:'RTX',  ret: -3.60, vol: 27.25, mktcap: 259665344057.85 },
      { ticker:'TDG',  ret: -7.72, vol: 28.10, mktcap: 64779409520.73  },
      { ticker:'TXT',  ret: -9.55, vol: 29.43, mktcap: 15672877333.58  },
    ];

    const X_MIN = -20, X_MAX = 20;
    const Y_MIN = 10,  Y_MAX = 60;
    const S_MIN = 6,   S_MAX = 38;
    const PAD = { top: 20, right: 30, bottom: 36, left: 44 };

    function getCSSVar(name) {
      return getComputedStyle(document.getElementById('scatterWrap')).getPropertyValue(name).trim();
    }
    function scaleSize(mktcap) {
      const all  = [...energy, ...defense].map(d => d.mktcap);
      const minM = Math.min(...all), maxM = Math.max(...all);
      const norm = (mktcap - minM) / (maxM - minM);
      return S_MIN + norm * (S_MAX - S_MIN);
    }
    function placeLabels(points) {
      const placed = [];
      const offsets = [
        [ 1.0,  0.0], [-1.0,  0.0], [ 0.0,  1.0], [ 0.0, -1.0],
        [ 0.7,  0.7], [-0.7,  0.7], [ 0.7, -0.7], [-0.7, -0.7],
      ];
      const BASE = 14;
      points.forEach(pt => {
        let best = null, bestScore = Infinity;
        offsets.forEach(([dx, dy]) => {
          const lx = pt.sx + dx * BASE;
          const ly = pt.sy + dy * BASE;
          let score = 0;
          placed.forEach(p => {
            const ddx = lx - p.lx, ddy = ly - p.ly;
            const dist = Math.sqrt(ddx*ddx + ddy*ddy);
            if (dist < 20) score += (20 - dist) * 3;
          });
          points.forEach(p2 => {
            const ddx = lx - p2.sx, ddy = ly - p2.sy;
            const dist = Math.sqrt(ddx*ddx + ddy*ddy);
            if (dist < 16) score += (16 - dist) * 2;
          });
          if (score < bestScore) { bestScore = score; best = { lx, ly }; }
        });
        placed.push({ ...pt, lx: best.lx, ly: best.ly });
      });
      return placed;
    }

    function scatterRebuild() {
      const wrap = document.getElementById('scatterChartWrap');
      const svg  = document.getElementById('scatterSvg');
      const W    = wrap.clientWidth || 700;
      const H    = Math.round(W * 0.88);
      const cW   = W - PAD.left - PAD.right;
      const cH   = H - PAD.top  - PAD.bottom;
      svg.setAttribute('viewBox', `0 0 ${W} ${H}`);
      svg.setAttribute('height', H);
      svg.innerHTML = '';
      const ns = 'http://www.w3.org/2000/svg';
      function xS(v) { return PAD.left + ((v - X_MIN) / (X_MAX - X_MIN)) * cW; }
      function yS(v) { return PAD.top  + ((Y_MAX - v) / (Y_MAX - Y_MIN)) * cH; }

      // Grid lines
      for (let x = -20; x <= 20; x += 5) {
        const l = document.createElementNS(ns, 'line');
        l.setAttribute('x1', xS(x)); l.setAttribute('x2', xS(x));
        l.setAttribute('y1', PAD.top); l.setAttribute('y2', PAD.top + cH);
        l.setAttribute('stroke', getCSSVar('--grid-line'));
        l.setAttribute('stroke-width', '1');
        svg.appendChild(l);
        const t = document.createElementNS(ns, 'text');
        t.setAttribute('x', xS(x)); t.setAttribute('y', PAD.top + cH + 14);
        t.setAttribute('text-anchor', 'middle'); t.setAttribute('font-size', '9');
        t.setAttribute('fill', getCSSVar('--text-muted'));
        t.setAttribute('font-family', 'IBM Plex Mono, monospace');
        t.textContent = `${x}%`;
        svg.appendChild(t);
      }
      for (let y = 10; y <= 60; y += 10) {
        const l = document.createElementNS(ns, 'line');
        l.setAttribute('x1', PAD.left); l.setAttribute('x2', PAD.left + cW);
        l.setAttribute('y1', yS(y)); l.setAttribute('y2', yS(y));
        l.setAttribute('stroke', getCSSVar('--grid-line'));
        l.setAttribute('stroke-width', '1');
        svg.appendChild(l);
        const t = document.createElementNS(ns, 'text');
        t.setAttribute('x', PAD.left - 6); t.setAttribute('y', yS(y) + 3.5);
        t.setAttribute('text-anchor', 'end'); t.setAttribute('font-size', '9');
        t.setAttribute('fill', getCSSVar('--text-muted'));
        t.setAttribute('font-family', 'IBM Plex Mono, monospace');
        t.textContent = `${y}%`;
        svg.appendChild(t);
      }

      // Median volatility reference line
      const allVols = [...energy, ...defense].map(d => d.vol).sort((a,b) => a-b);
      const m    = Math.floor(allVols.length / 2);
      const midY = allVols.length % 2 ? allVols[m] : (allVols[m-1] + allVols[m]) / 2;

      const vl = document.createElementNS(ns, 'line');
      vl.setAttribute('x1', xS(0)); vl.setAttribute('x2', xS(0));
      vl.setAttribute('y1', PAD.top); vl.setAttribute('y2', PAD.top + cH);
      vl.setAttribute('stroke', getCSSVar('--ref-line'));
      vl.setAttribute('stroke-width', '1');
      vl.setAttribute('stroke-dasharray', '4,4');
      svg.appendChild(vl);

      const hl = document.createElementNS(ns, 'line');
      hl.setAttribute('x1', PAD.left); hl.setAttribute('x2', PAD.left + cW);
      hl.setAttribute('y1', yS(midY)); hl.setAttribute('y2', yS(midY));
      hl.setAttribute('stroke', getCSSVar('--ref-line'));
      hl.setAttribute('stroke-width', '1');
      hl.setAttribute('stroke-dasharray', '4,4');
      svg.appendChild(hl);

      const ml = document.createElementNS(ns, 'text');
      ml.setAttribute('x', xS(15)); ml.setAttribute('y', yS(midY) - 4);
      ml.setAttribute('font-size', '8.5'); ml.setAttribute('fill', getCSSVar('--text-muted'));
      ml.setAttribute('font-family', 'IBM Plex Sans, sans-serif');
      ml.textContent = 'volatility median';
      svg.appendChild(ml);

      const wm = document.createElementNS(ns, 'text');
      wm.setAttribute('x', xS(0)); wm.setAttribute('y', yS(midY) + 16);
      wm.setAttribute('text-anchor', 'middle'); wm.setAttribute('font-size', '10');
      wm.setAttribute('fill', getCSSVar('--text-muted'));
      wm.setAttribute('font-family', 'IBM Plex Sans, sans-serif');
      wm.setAttribute('opacity', '0.18');
      wm.textContent = '@azkarohbiya';
      svg.appendChild(wm);

      const mn = document.createElementNS(ns, 'text');
      mn.setAttribute('x', xS(X_MIN) + 4); mn.setAttribute('y', yS(Y_MAX) + 14);
      mn.setAttribute('font-size', '8.5'); mn.setAttribute('fill', getCSSVar('--text-muted'));
      mn.setAttribute('font-family', 'IBM Plex Sans, sans-serif');
      mn.textContent = 'Note: size shows market cap';
      svg.appendChild(mn);

      // Axis labels
      const xl = document.createElementNS(ns, 'text');
      xl.setAttribute('x', PAD.left + cW / 2); xl.setAttribute('y', H - 4);
      xl.setAttribute('text-anchor', 'middle'); xl.setAttribute('font-size', '9.5');
      xl.setAttribute('fill', getCSSVar('--text-muted'));
      xl.setAttribute('font-family', 'IBM Plex Sans, sans-serif');
      xl.textContent = 'Returns (%)';
      svg.appendChild(xl);

      const yl = document.createElementNS(ns, 'text');
      yl.setAttribute('transform', `rotate(-90, 12, ${PAD.top + cH/2})`);
      yl.setAttribute('x', 12); yl.setAttribute('y', PAD.top + cH/2);
      yl.setAttribute('text-anchor', 'middle'); yl.setAttribute('font-size', '9.5');
      yl.setAttribute('fill', getCSSVar('--text-muted'));
      yl.setAttribute('font-family', 'IBM Plex Sans, sans-serif');
      yl.textContent = 'Volatility (%)';
      svg.appendChild(yl);

      // Scatter points
      const colorEnergy  = getCSSVar('--c-energy');
      const colorDefense = getCSSVar('--c-defense');
      const allPoints = [
        ...energy.map( d => ({ ...d, sector: 'energy',  color: colorEnergy  }) ),
        ...defense.map(d => ({ ...d, sector: 'defense', color: colorDefense }) ),
      ].map(d => ({ ...d, sx: xS(d.ret), sy: yS(d.vol), sz: scaleSize(d.mktcap) }));

      allPoints.forEach(d => {
        const half = d.sz / 2;
        const rect = document.createElementNS(ns, 'rect');
        rect.setAttribute('x', d.sx - half); rect.setAttribute('y', d.sy - half);
        rect.setAttribute('width', d.sz); rect.setAttribute('height', d.sz);
        rect.setAttribute('fill', d.color); rect.setAttribute('opacity', '0.75');
        rect.setAttribute('stroke', 'black'); rect.setAttribute('stroke-width', '0.7');
        rect.setAttribute('rx', '1');
        svg.appendChild(rect);
      });

      // Labels with collision avoidance
      const placed = placeLabels(allPoints);
      placed.forEach(d => {
        const dx = d.lx - d.sx, dy = d.ly - d.sy;
        const dist = Math.sqrt(dx*dx + dy*dy);
        if (dist > 8) {
          const line = document.createElementNS(ns, 'line');
          line.setAttribute('x1', d.sx); line.setAttribute('y1', d.sy);
          line.setAttribute('x2', d.lx); line.setAttribute('y2', d.ly);
          line.setAttribute('stroke', getCSSVar('--c-arrow'));
          line.setAttribute('stroke-width', '0.7');
          svg.appendChild(line);
        }
        const t = document.createElementNS(ns, 'text');
        t.setAttribute('x', d.lx); t.setAttribute('y', d.ly + 3.5);
        t.setAttribute('text-anchor', 'middle'); t.setAttribute('font-size', '9');
        t.setAttribute('font-weight', '600'); t.setAttribute('fill', getCSSVar('--c-label'));
        t.setAttribute('font-family', 'IBM Plex Mono, monospace');
        t.textContent = d.ticker;
        svg.appendChild(t);
      });

      // Legend
      const legendItems = [
        { label: 'Energy',  color: colorEnergy  },
        { label: 'Defense', color: colorDefense },
      ];
      const legX = PAD.left + 8, legY = PAD.top + 8;
      const legBg = document.createElementNS(ns, 'rect');
      legBg.setAttribute('x', legX - 4); legBg.setAttribute('y', legY - 4);
      legBg.setAttribute('width', 78); legBg.setAttribute('height', 38);
      legBg.setAttribute('rx', '4');
      legBg.setAttribute('fill', getCSSVar('--surface')); legBg.setAttribute('opacity', '0.6');
      legBg.setAttribute('stroke', getCSSVar('--border')); legBg.setAttribute('stroke-width', '0.8');
      svg.appendChild(legBg);

      const legTitle = document.createElementNS(ns, 'text');
      legTitle.setAttribute('x', legX + 2); legTitle.setAttribute('y', legY + 8);
      legTitle.setAttribute('font-size', '8'); legTitle.setAttribute('font-weight', '700');
      legTitle.setAttribute('fill', getCSSVar('--text-muted'));
      legTitle.setAttribute('font-family', 'IBM Plex Sans, sans-serif');
      legTitle.textContent = 'SECTOR';
      svg.appendChild(legTitle);

      legendItems.forEach((item, i) => {
        const iy = legY + 18 + i * 12;
        const r  = document.createElementNS(ns, 'rect');
        r.setAttribute('x', legX); r.setAttribute('y', iy - 5);
        r.setAttribute('width', 9); r.setAttribute('height', 9);
        r.setAttribute('rx', '1'); r.setAttribute('fill', item.color);
        r.setAttribute('opacity', '0.8');
        r.setAttribute('stroke', 'black'); r.setAttribute('stroke-width', '0.5');
        svg.appendChild(r);
        const lt = document.createElementNS(ns, 'text');
        lt.setAttribute('x', legX + 13); lt.setAttribute('y', iy + 3);
        lt.setAttribute('font-size', '8.5'); lt.setAttribute('fill', getCSSVar('--text-muted'));
        lt.setAttribute('font-family', 'IBM Plex Sans, sans-serif');
        lt.textContent = item.label;
        svg.appendChild(lt);
      });
    }

    function scatterToggleMode() {
      const wrap = document.getElementById('scatterWrap');
      const btn  = document.getElementById('scatterToggleBtn');
      const isLight = wrap.classList.toggle('light');
      btn.textContent = isLight ? '🌙 Dark Mode' : '☀ Light Mode';
      scatterRebuild();
    }
    window.scatterToggleMode = scatterToggleMode;

    scatterRebuild();
    window.addEventListener('resize', scatterRebuild);
  })();
</script>
