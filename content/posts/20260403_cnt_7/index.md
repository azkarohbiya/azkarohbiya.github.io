---
title: "P/E Ratio Distribution by Sector"
highlight: true
categories: ["general"]
date : "2026-04-02"
result: ""
summary: ""
weight: 8
showTableOfContents: true
---

{{< alert >}}
**Note** Data sourced from Yahoo Finance via yfinance. This content is for educational purposes only and does not constitute financial advice.
{{< /alert >}}

<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@300;400;600;700&family=IBM+Plex+Mono:wght@400;600&display=swap');
  .pe-wrap {
    --bg:           #141414;
    --surface:      #1c1c1c;
    --border:       #2a2a2a;
    --text:         #e2e2e2;
    --text-muted:   #666666;
    --title-color:  #f0f0f0;
    --grid:         rgba(255,255,255,0.045);
    --tooltip-bg:   rgba(20,20,20,0.95);
    --tooltip-bd:   #3a3a3a;
    --median-fill:  #ffffff;
    --median-stroke:#141414;
  }
  .pe-wrap.light {
    --bg:           #f5f4f0;
    --surface:      #ffffff;
    --border:       #e0ddd8;
    --text:         #1a1a1a;
    --text-muted:   #888888;
    --title-color:  #111111;
    --grid:         rgba(0,0,0,0.045);
    --tooltip-bg:   rgba(255,255,255,0.97);
    --tooltip-bd:   #cccccc;
    --median-fill:  #333333;
    --median-stroke:#f5f4f0;
  }
  .pe-wrap * { box-sizing: border-box; margin: 0; padding: 0; }
  .pe-wrap {
    background: var(--bg);
    color: var(--text);
    font-family: 'IBM Plex Sans', sans-serif;
    padding: 24px 32px 20px;
    border-radius: 12px;
    margin: 2rem 0;
    transition: background 0.3s, color 0.3s;
  }
  .pe-wrap .toggle-wrap { display: flex; justify-content: flex-end; margin-bottom: 12px; }
  .pe-wrap .toggle-btn {
    font-family: 'IBM Plex Mono', monospace;
    font-size: 10px; font-weight: 600;
    letter-spacing: 0.8px; text-transform: uppercase;
    padding: 5px 12px; border-radius: 4px;
    border: 1px solid var(--border);
    background: var(--surface); color: var(--text-muted);
    cursor: pointer; transition: all 0.2s;
  }
  .pe-wrap .toggle-btn:hover { color: var(--text); border-color: var(--text-muted); }
  .pe-wrap .header { margin-bottom: 14px; }
  .pe-wrap .header h2 {
    font-size: 16px; font-weight: 700;
    letter-spacing: -0.3px; line-height: 1.35;
    color: var(--title-color); margin-bottom: 4px;
  }
  .pe-wrap .header p { font-size: 11px; color: var(--text-muted); line-height: 1.5; }
  #peChartWrap { width: 100%; position: relative; }
  #peSvg { width: 100%; display: block; overflow: visible; }
  #peTooltip {
    position: fixed;
    display: none;
    background: var(--tooltip-bg);
    border: 1px solid var(--tooltip-bd);
    border-radius: 6px;
    padding: 8px 11px;
    font-size: 11px;
    pointer-events: none;
    z-index: 99;
    backdrop-filter: blur(4px);
    min-width: 130px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.3);
    transition: background 0.2s, border-color 0.2s;
    font-family: 'IBM Plex Sans', sans-serif;
    color: var(--text);
  }
  #peTooltip .tt-ticker {
    font-family: 'IBM Plex Mono', monospace;
    font-weight: 700; font-size: 12px;
    margin-bottom: 3px;
  }
  #peTooltip .tt-row {
    font-size: 10px; color: var(--text-muted);
    display: flex; justify-content: space-between; gap: 12px;
    margin-top: 2px;
  }
  #peTooltip .tt-val {
    font-family: 'IBM Plex Mono', monospace;
    font-weight: 600; color: var(--text);
  }
  .pe-wrap .footer {
    margin-top: 12px; padding-top: 10px;
    border-top: 1px solid var(--border);
    font-size: 10px; color: var(--text-muted); line-height: 1.7;
  }
  .pe-wrap .footer .source { font-style: italic; }
</style>

<div class="not-prose pe-wrap light" id="peWrap">
  <div class="toggle-wrap">
    <button class="toggle-btn" id="peToggleBtn" onclick="peToggleMode()">&#127769; Dark Mode</button>
  </div>
  <div class="header">
    <h2>P/E Ratio Distribution by Sector</h2>
    <p>Each dot represents one stock. Outliers beyond 100x trimmed for readability. Size = market cap.</p>
  </div>
  <div id="peChartWrap">
    <svg id="peSvg"></svg>
  </div>
  <div id="peTooltip">
    <div class="tt-ticker" id="peTicker"></div>
    <div class="tt-row"><span>P/E Ratio</span><span class="tt-val" id="pePe"></span></div>
    <div class="tt-row"><span>Sector</span><span class="tt-val" id="peCat"></span></div>
    <div class="tt-row"><span>Mkt Cap</span><span class="tt-val" id="peMkt"></span></div>
  </div>
  <div class="footer">
    <div class="source">Source: Yahoo Finance via yfinance</div>
    <div>Note: Uses trailing P/E. Negative, missing, or P/E &gt; 100x excluded.</div>
  </div>
</div>

<script>
(function() {
  const RAW = [
    {t:'XOM',c:'Energy',pe:23.98,m:669473898496},
    {t:'CVX',c:'Energy',pe:30.0,m:397701414912},
    {t:'COP',c:'Energy',pe:20.55,m:159509151744},
    {t:'EOG',c:'Energy',pe:15.66,m:76514410496},
    {t:'SLB',c:'Energy',pe:21.03,m:74201022464},
    {t:'MPC',c:'Energy',pe:18.29,m:71251959808},
    {t:'PSX',c:'Energy',pe:16.35,m:70619111424},
    {t:'VLO',c:'Energy',pe:32.19,m:72962400256},
    {t:'OXY',c:'Energy',pe:46.64,m:62437126144},
    {t:'HAL',c:'Energy',pe:25.45,m:32124887040},
    {t:'DVN',c:'Energy',pe:11.87,m:30690678784},
    {t:'FANG',c:'Energy',pe:33.78,m:54689472512},
    {t:'BKR',c:'Energy',pe:23.22,m:59882311680},
    {t:'APA',c:'Energy',pe:10.54,m:14850693120},
    {t:'EQT',c:'Energy',pe:18.04,m:37269155840},
    {t:'TRGP',c:'Energy',pe:28.79,m:52536369152},
    {t:'WMB',c:'Energy',pe:33.65,m:88051810304},
    {t:'OKE',c:'Energy',pe:16.29,m:55603597312},
    {t:'KMI',c:'Energy',pe:24.06,m:73340739584},
    {t:'LNG',c:'Energy',pe:11.64,m:60498190336},
    {t:'CVI',c:'Energy',pe:117.22,m:3181793536},
    {t:'PBF',c:'Energy',pe:12.12,m:5329931264},
    {t:'MTDR',c:'Energy',pe:10.33,m:7814760960},
    {t:'CTRA',c:'Energy',pe:15.43,m:26248056832},
    {t:'PR',c:'Energy',pe:16.55,m:17957992448},
    {t:'SUN',c:'Energy',pe:28.43,m:12212862976},
    {t:'AAPL',c:'Technology',pe:32.39,m:3761492983808},
    {t:'MSFT',c:'Technology',pe:23.36,m:2775695753216},
    {t:'NVDA',c:'Technology',pe:36.2,m:4311464017920},
    {t:'AVGO',c:'Technology',pe:61.2,m:1491367493632},
    {t:'AMD',c:'Technology',pe:83.33,m:354614378496},
    {t:'ORCL',c:'Technology',pe:26.23,m:420997365760},
    {t:'CRM',c:'Technology',pe:23.99,m:175359541248},
    {t:'ACN',c:'Technology',pe:16.5,m:123856322560},
    {t:'IBM',c:'Technology',pe:22.28,m:232884977664},
    {t:'INTC',c:'Technology',pe:50.78,m:252958507008},
    {t:'QCOM',c:'Technology',pe:25.56,m:135428120576},
    {t:'TXN',c:'Technology',pe:35.69,m:177421991936},
    {t:'AMAT',c:'Technology',pe:35.7,m:276549238784},
    {t:'LRCX',c:'Technology',pe:44.95,m:274367184896},
    {t:'MU',c:'Technology',pe:17.28,m:413021306880},
    {t:'ADI',c:'Technology',pe:58.09,m:155414904832},
    {t:'KLAC',c:'Technology',pe:44.16,m:199301152768},
    {t:'CSCO',c:'Technology',pe:28.42,m:312215470080},
    {t:'GLW',c:'Technology',pe:80.36,m:127018401792},
    {t:'GE',c:'Industrials',pe:34.92,m:296529264640},
    {t:'CAT',c:'Industrials',pe:38.08,m:335784706048},
    {t:'RTX',c:'Industrials',pe:39.48,m:264107065344},
    {t:'HON',c:'Industrials',pe:33.06,m:145855791104},
    {t:'UNP',c:'Industrials',pe:20.41,m:145249320960},
    {t:'LMT',c:'Industrials',pe:28.98,m:143535259648},
    {t:'BA',c:'Industrials',pe:83.66,m:163695263744},
    {t:'DE',c:'Industrials',pe:32.44,m:155535884288},
    {t:'ETN',c:'Industrials',pe:34.54,m:140313395200},
    {t:'GD',c:'Industrials',pe:22.57,m:94525202432},
    {t:'NOC',c:'Industrials',pe:24.17,m:100232298496},
    {t:'FDX',c:'Industrials',pe:19.33,m:86332694528},
    {t:'UPS',c:'Industrials',pe:14.97,m:83429384192},
    {t:'DAL',c:'Industrials',pe:8.72,m:43603005440},
    {t:'PWR',c:'Industrials',pe:82.69,m:83879641088},
    {t:'BRK-B',c:'Financials',pe:15.37,m:1029582356480},
    {t:'JPM',c:'Financials',pe:14.71,m:794734559232},
    {t:'BAC',c:'Financials',pe:12.96,m:354241019904},
    {t:'WFC',c:'Financials',pe:12.88,m:248733089792},
    {t:'GS',c:'Financials',pe:16.81,m:256200146944},
    {t:'MS',c:'Financials',pe:16.25,m:263235469312},
    {t:'BLK',c:'Financials',pe:27.36,m:150340222976},
    {t:'AXP',c:'Financials',pe:19.53,m:206080344064},
    {t:'C',c:'Financials',pe:16.48,m:201539043328},
    {t:'CB',c:'Financials',pe:12.79,m:128449372160},
    {t:'PGR',c:'Financials',pe:10.15,m:114427518976},
    {t:'CME',c:'Financials',pe:27.34,m:110696374272},
    {t:'SPGI',c:'Financials',pe:29.39,m:130570387456},
    {t:'COF',c:'Financials',pe:54.13,m:113123131392},
    {t:'LLY',c:'Healthcare',pe:40.85,m:837531729920},
    {t:'UNH',c:'Healthcare',pe:20.95,m:251616804864},
    {t:'JNJ',c:'Healthcare',pe:22.03,m:585701851136},
    {t:'ABBV',c:'Healthcare',pe:88.47,m:369308729344},
    {t:'MRK',c:'Healthcare',pe:16.65,m:299184160768},
    {t:'TMO',c:'Healthcare',pe:27.68,m:182517645312},
    {t:'ABT',c:'Healthcare',pe:27.65,m:178755452928},
    {t:'DHR',c:'Healthcare',pe:37.9,m:135198883840},
    {t:'BMY',c:'Healthcare',pe:17.23,m:121687425024},
    {t:'AMGN',c:'Healthcare',pe:24.43,m:187563196416},
    {t:'PFE',c:'Healthcare',pe:20.83,m:161151139840},
    {t:'ISRG',c:'Healthcare',pe:57.59,m:160561561600},
    {t:'GILD',c:'Healthcare',pe:20.61,m:173408583680},
    {t:'HCA',c:'Healthcare',pe:16.65,m:105532907520},
    {t:'AMZN',c:'Consumer Disc.',pe:29.22,m:2251864408064},
    {t:'TSLA',c:'Consumer Disc.',pe:337.0,m:1353089417216},
    {t:'HD',c:'Consumer Disc.',pe:22.58,m:320277446656},
    {t:'MCD',c:'Consumer Disc.',pe:25.7,m:219119370240},
    {t:'TJX',c:'Consumer Disc.',pe:33.06,m:179572670464},
    {t:'BKNG',c:'Consumer Disc.',pe:25.31,m:135198621696},
    {t:'LOW',c:'Consumer Disc.',pe:19.5,m:129630273536},
    {t:'SBUX',c:'Consumer Disc.',pe:75.31,m:102958538752},
    {t:'UBER',c:'Consumer Disc.',pe:15.18,m:147813892096},
    {t:'MAR',c:'Consumer Disc.',pe:34.94,m:87956324352},
    {t:'RCL',c:'Consumer Disc.',pe:17.54,m:74622451712},
    {t:'ROST',c:'Consumer Disc.',pe:33.33,m:71543275520},
    {t:'WMT',c:'Consumer Staples',pe:46.08,m:1002848518144},
    {t:'PG',c:'Consumer Staples',pe:21.23,m:334409924608},
    {t:'KO',c:'Consumer Staples',pe:25.23,m:330171580416},
    {t:'PEP',c:'Consumer Staples',pe:26.17,m:214623387648},
    {t:'COST',c:'Consumer Staples',pe:52.78,m:450509701120},
    {t:'PM',c:'Consumer Staples',pe:21.74,m:246341287936},
    {t:'MO',c:'Consumer Staples',pe:15.96,m:110364270592},
    {t:'MDLZ',c:'Consumer Staples',pe:30.44,m:74247233536},
    {t:'CL',c:'Consumer Staples',pe:32.36,m:68275888128},
    {t:'MNST',c:'Consumer Staples',pe:37.3,m:70797451264},
    {t:'SYY',c:'Consumer Staples',pe:19.17,m:34066335744},
    {t:'LIN',c:'Materials',pe:34.38,m:232901902336},
    {t:'SHW',c:'Materials',pe:31.0,m:78796095488},
    {t:'APD',c:'Materials',pe:20.91,m:65349537792},
    {t:'ECL',c:'Materials',pe:36.31,m:74655899648},
    {t:'NEM',c:'Materials',pe:17.85,m:124079661056},
    {t:'FCX',c:'Materials',pe:40.36,m:88165138432},
    {t:'PPG',c:'Materials',pe:14.92,m:23109449728},
    {t:'VMC',c:'Materials',pe:34.36,m:36566425600},
    {t:'MLM',c:'Materials',pe:36.51,m:36006293504},
    {t:'NUE',c:'Materials',pe:22.93,m:39279730688},
    {t:'NEE',c:'Utilities',pe:28.24,m:194163408896},
    {t:'SO',c:'Utilities',pe:24.85,m:109051092992},
    {t:'DUK',c:'Utilities',pe:20.95,m:102895812608},
    {t:'AEP',c:'Utilities',pe:19.92,m:72119992320},
    {t:'SRE',c:'Utilities',pe:36.07,m:64804057088},
    {t:'D',c:'Utilities',pe:18.09,m:55163826176},
    {t:'EXC',c:'Utilities',pe:18.07,m:50473230336},
    {t:'XEL',c:'Utilities',pe:23.61,m:50371813376},
    {t:'ETR',c:'Utilities',pe:29.38,m:52596482048},
    {t:'AWK',c:'Utilities',pe:24.28,m:26979901440},
    {t:'PLD',c:'Real Estate',pe:37.57,m:124695166976},
    {t:'AMT',c:'Real Estate',pe:32.17,m:81338130432},
    {t:'EQIX',c:'Real Estate',pe:72.81,m:98291277824},
    {t:'CCI',c:'Real Estate',pe:33.62,m:36948250624},
    {t:'PSA',c:'Real Estate',pe:31.13,m:49243996160},
    {t:'O',c:'Real Estate',pe:53.17,m:58007752704},
    {t:'DLR',c:'Real Estate',pe:50.89,m:63555969024},
    {t:'SPG',c:'Real Estate',pe:13.33,m:61325185024},
    {t:'EXR',c:'Real Estate',pe:29.23,m:29662763008},
    {t:'META',c:'Communication Svcs',pe:24.42,m:1453128548352},
    {t:'GOOGL',c:'Communication Svcs',pe:27.39,m:3577929793536},
    {t:'NFLX',c:'Communication Svcs',pe:39.0,m:418504835072},
    {t:'DIS',c:'Communication Svcs',pe:14.23,m:171380113408},
    {t:'CMCSA',c:'Communication Svcs',pe:5.18,m:101773975552},
    {t:'VZ',c:'Communication Svcs',pe:12.16,m:208227057664},
    {t:'T',c:'Communication Svcs',pe:9.31,m:198221348864},
    {t:'TMUS',c:'Communication Svcs',pe:20.72,m:225267220480},
    {t:'EA',c:'Communication Svcs',pe:76.25,m:50951655424},
    {t:'LYV',c:'Communication Svcs',pe:68.72,m:36599750656},
  ];

  const COLORS = [
    '#4e79a7','#f28e2b','#e15759','#76b7b2','#59a14f',
    '#edc948','#b07aa1','#ff9da7','#9c755f','#bab0ac','#d37295'
  ];
  const X_MAX = 100;
  const PAD   = { top: 16, right: 28, bottom: 36, left: 130 };
  const ROW_H = 46;

  function getCSSVar(n) {
    return getComputedStyle(document.getElementById('peWrap')).getPropertyValue(n).trim();
  }
  function fmtMktCap(v) {
    if (v >= 1e12) return '$' + (v/1e12).toFixed(2) + 'T';
    if (v >= 1e9)  return '$' + (v/1e9).toFixed(1)  + 'B';
    if (v >= 1e6)  return '$' + (v/1e6).toFixed(0)  + 'M';
    return '$' + v;
  }

  const filtered = RAW.filter(d => d.pe > 0 && d.pe <= X_MAX && d.m > 0);
  const cats = [...new Set(filtered.map(d => d.c))];
  cats.sort((a, b) => {
    const mA = filtered.filter(d => d.c === a).map(d => d.pe).sort((x,y)=>x-y);
    const mB = filtered.filter(d => d.c === b).map(d => d.pe).sort((x,y)=>x-y);
    return mB[Math.floor(mB.length/2)] - mA[Math.floor(mA.length/2)];
  });
  const colorMap = {};
  cats.forEach((c, i) => colorMap[c] = COLORS[i % COLORS.length]);

  const allM = filtered.map(d => d.m);
  const minM = Math.min(...allM), maxM = Math.max(...allM);
  function dotRadius(m) {
    return Math.sqrt(3 + ((m - minM) / (maxM - minM)) * 180);
  }
  function seededRand(seed) {
    let s = seed;
    return () => {
      s = (s * 1664525 + 1013904223) & 0xffffffff;
      return (s >>> 0) / 0xffffffff;
    };
  }

  const tooltip = document.getElementById('peTooltip');
  function showTooltip(evt, d) {
    document.getElementById('peTicker').textContent = d.t;
    document.getElementById('peTicker').style.color = colorMap[d.c];
    document.getElementById('pePe').textContent     = d.pe.toFixed(2) + 'x';
    document.getElementById('peCat').textContent    = d.c;
    document.getElementById('peMkt').textContent    = fmtMktCap(d.m);
    tooltip.style.display = 'block';
    moveTooltip(evt);
  }
  function moveTooltip(evt) {
    tooltip.style.left = (evt.clientX + 14) + 'px';
    tooltip.style.top  = (evt.clientY - 10) + 'px';
  }
  function hideTooltip() { tooltip.style.display = 'none'; }

  function rebuild() {
    const wrap = document.getElementById('peChartWrap');
    const svg  = document.getElementById('peSvg');
    const W    = wrap.clientWidth || 700;
    const H    = PAD.top + cats.length * ROW_H + PAD.bottom;
    const cW   = W - PAD.left - PAD.right;
    svg.setAttribute('viewBox', '0 0 ' + W + ' ' + H);
    svg.setAttribute('height', H);
    svg.innerHTML = '';
    const ns = 'http://www.w3.org/2000/svg';
    function xS(v) { return PAD.left + (v / X_MAX) * cW; }
    function yS(i) { return PAD.top + i * ROW_H + ROW_H / 2; }

    [0,10,20,30,40,50,60,70,80,90,100].forEach(v => {
      const l = document.createElementNS(ns, 'line');
      l.setAttribute('x1', xS(v)); l.setAttribute('x2', xS(v));
      l.setAttribute('y1', PAD.top); l.setAttribute('y2', PAD.top + cats.length * ROW_H);
      l.setAttribute('stroke', getCSSVar('--grid'));
      l.setAttribute('stroke-width', '1');
      svg.appendChild(l);
      const t = document.createElementNS(ns, 'text');
      t.setAttribute('x', xS(v));
      t.setAttribute('y', PAD.top + cats.length * ROW_H + 16);
      t.setAttribute('text-anchor', 'middle');
      t.setAttribute('font-size', '8.5');
      t.setAttribute('fill', getCSSVar('--text-muted'));
      t.setAttribute('font-family', 'IBM Plex Mono, monospace');
      t.textContent = v + 'x';
      svg.appendChild(t);
    });

    cats.forEach((cat, i) => {
      if (i % 2 === 0) {
        const band = document.createElementNS(ns, 'rect');
        band.setAttribute('x', PAD.left);
        band.setAttribute('y', PAD.top + i * ROW_H);
        band.setAttribute('width', cW);
        band.setAttribute('height', ROW_H);
        band.setAttribute('fill', getCSSVar('--grid'));
        svg.appendChild(band);
      }
      const t = document.createElementNS(ns, 'text');
      t.setAttribute('x', PAD.left - 10);
      t.setAttribute('y', yS(i) + 4);
      t.setAttribute('text-anchor', 'end');
      t.setAttribute('font-size', '10.5');
      t.setAttribute('font-weight', '300');
      t.setAttribute('fill', getCSSVar('--text-muted'));
      t.setAttribute('font-family', 'IBM Plex Sans, sans-serif');
      t.textContent = cat;
      svg.appendChild(t);
    });

    cats.forEach((cat, i) => {
      const subset = filtered.filter(d => d.c === cat);
      const rng    = seededRand(i * 42 + 7);
      const cy     = yS(i);
      const color  = colorMap[cat];
      subset.forEach(d => {
        const jitter = (rng() - 0.5) * (ROW_H * 0.55);
        const circle = document.createElementNS(ns, 'circle');
        circle.setAttribute('cx', xS(d.pe));
        circle.setAttribute('cy', cy + jitter);
        circle.setAttribute('r',  dotRadius(d.m));
        circle.setAttribute('fill', color);
        circle.setAttribute('opacity', '0.62');
        circle.setAttribute('stroke', getCSSVar('--bg'));
        circle.setAttribute('stroke-width', '0.5');
        circle.style.cursor = 'pointer';
        circle.addEventListener('mouseenter', evt => showTooltip(evt, d));
        circle.addEventListener('mousemove',  evt => moveTooltip(evt));
        circle.addEventListener('mouseleave', hideTooltip);
        svg.appendChild(circle);
      });

      const vals = subset.map(d => d.pe).sort((a,b) => a-b);
      const mid  = Math.floor(vals.length / 2);
      const medianPE = vals.length % 2 ? vals[mid] : (vals[mid-1]+vals[mid])/2;
      const mx   = xS(medianPE);
      const size = 6;
      const diamond = document.createElementNS(ns, 'polygon');
      diamond.setAttribute('points',
        mx + ',' + (cy-size) + ' ' + (mx+size) + ',' + cy + ' ' + mx + ',' + (cy+size) + ' ' + (mx-size) + ',' + cy
      );
      diamond.setAttribute('fill', getCSSVar('--median-fill'));
      diamond.setAttribute('stroke', color);
      diamond.setAttribute('stroke-width', '1.5');
      diamond.setAttribute('opacity', '0.95');
      diamond.style.cursor = 'pointer';
      diamond.addEventListener('mouseenter', evt => {
        document.getElementById('peTicker').textContent = cat + ' median';
        document.getElementById('peTicker').style.color = color;
        document.getElementById('pePe').textContent     = medianPE.toFixed(2) + 'x';
        document.getElementById('peCat').textContent    = cat;
        document.getElementById('peMkt').textContent    = '—';
        tooltip.style.display = 'block';
        moveTooltip(evt);
      });
      diamond.addEventListener('mousemove',  evt => moveTooltip(evt));
      diamond.addEventListener('mouseleave', hideTooltip);
      svg.appendChild(diamond);
    });

    const xl = document.createElementNS(ns, 'text');
    xl.setAttribute('x', PAD.left + cW / 2);
    xl.setAttribute('y', H - 4);
    xl.setAttribute('text-anchor', 'middle');
    xl.setAttribute('font-size', '9.5');
    xl.setAttribute('fill', getCSSVar('--text-muted'));
    xl.setAttribute('font-family', 'IBM Plex Sans, sans-serif');
    xl.textContent = 'Price-to-Earnings Ratio (P/E)';
    svg.appendChild(xl);
  }

  function peToggleMode() {
    const wrap    = document.getElementById('peWrap');
    const isLight = wrap.classList.toggle('light');
    document.getElementById('peToggleBtn').textContent = isLight ? '\uD83C\uDF19 Dark Mode' : '\u2600 Light Mode';
    rebuild();
  }
  window.peToggleMode = peToggleMode;

  rebuild();
  window.addEventListener('resize', rebuild);
})();
</script>

{{< alert >}}
**Note** Point the scatter to see the details 
{{< /alert >}}

Every sector has a price. But markets don't price them equally.
P/E ratios reveal how much investors are willing to pay for a dollar of earnings and the gap between sectors is wider than most people realize. Technology and Consumer Discretionary carry some of the richest multiples in the market, driven by growth expectations and AI tailwinds. Meanwhile, Financials and Energy trade at a significant discount, reflecting cyclic, rate sensitivity, and a market that still views them as slow-moving businesses.
The most telling detail isn't the sector median, but the dispersion within each sector. Healthcare stretches from single-digit multiples in managed care all the way past 100x in biotech. Real Estate shows a similar spread. That internal range tells you something the average never could: not every company in a sector gets the same growth story priced in.
