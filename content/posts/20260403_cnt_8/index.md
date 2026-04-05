---
title: "Where energy companies's revenue goes "
highlight: true
categories: ["general"]
date : "2026-04-02"
result: ""
summary: ""
weight: 12
showTableOfContents: true
---

{{< alert >}}
**Note** Data sourced from Yahoo Finance via yfinance. This content is for educational purposes only and does not constitute financial advice.
{{< /alert >}}

<p> </p>

<div class="not-prose sankey-wrap" id="skWrap">
<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@300;400;600;700&family=IBM+Plex+Mono:wght@400;600&display=swap');
  /* ── Light (default) ── */
  .sankey-wrap {
    --bg:           #f5f4f0;
    --surface:      #ffffff;
    --border:       #e0ddd8;
    --text:         #1a1a1a;
    --text-muted:   #888888;
    --title-color:  #111111;
    --node-fill:    #678AA2;
    --node-stroke:  #9ec3f0;
    --link-color:   rgba(174,174,174,0.35);
    --link-hover:   rgba(103,138,162,0.55);
    --label-color:  #1a1a1a;
    --value-color:  #444444;
    --tooltip-bg:   rgba(255,255,255,0.97);
    --tooltip-bd:   #cccccc;
  }
  /* ── Dark ── */
  .sankey-wrap.dark {
    --bg:           #1a1a1a;
    --surface:      #222222;
    --border:       #333333;
    --text:         #e2e2e2;
    --text-muted:   #666666;
    --title-color:  #f0f0f0;
    --node-fill:    #678AA2;
    --node-stroke:  #9ec3f0;
    --link-color:   rgba(174,174,174,0.18);
    --link-hover:   rgba(103,138,162,0.45);
    --label-color:  #e0e0e0;
    --value-color:  #aaaaaa;
    --tooltip-bg:   rgba(20,20,20,0.96);
    --tooltip-bd:   #3a3a3a;
  }
  .sankey-wrap * { box-sizing: border-box; margin: 0; padding: 0; }
  .sankey-wrap {
    background: var(--bg);
    color: var(--text);
    font-family: 'IBM Plex Sans', sans-serif;
    padding: 24px 36px 20px;
    transition: background 0.3s, color 0.3s;
    border-radius: 8px;
  }
  .sankey-wrap .toggle-wrap { display: flex; justify-content: flex-end; margin-bottom: 12px; }
  .sankey-wrap .toggle-btn {
    font-family: 'IBM Plex Mono', monospace;
    font-size: 10px; font-weight: 600;
    letter-spacing: 0.8px; text-transform: uppercase;
    padding: 5px 12px; border-radius: 4px;
    border: 1px solid var(--border);
    background: var(--surface); color: var(--text-muted);
    cursor: pointer; transition: all 0.2s;
  }
  .sankey-wrap .toggle-btn:hover { color: var(--text); border-color: var(--text-muted); }
  /* ── Dropdown ── */
  .sankey-wrap .controls-wrap {
    display: flex; justify-content: space-between; align-items: center;
    margin-bottom: 16px; gap: 12px;
  }
  .sankey-wrap .dropdown-wrap { display: flex; align-items: center; gap: 8px; }
  .sankey-wrap .dropdown-label {
    font-family: 'IBM Plex Mono', monospace;
    font-size: 10px; font-weight: 600;
    letter-spacing: 0.6px; text-transform: uppercase;
    color: var(--text-muted);
  }
  .sankey-wrap .company-select {
    font-family: 'IBM Plex Mono', monospace;
    font-size: 11px; font-weight: 600;
    padding: 5px 28px 5px 10px;
    border-radius: 4px;
    border: 1px solid var(--border);
    background: var(--surface);
    color: var(--text);
    cursor: pointer;
    appearance: none;
    -webkit-appearance: none;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='6'%3E%3Cpath d='M0 0l5 6 5-6z' fill='%23888'/%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 8px center;
    transition: border-color 0.2s;
  }
  .sankey-wrap .company-select:hover { border-color: var(--text-muted); }
  .sankey-wrap .company-select:focus { outline: none; border-color: var(--node-fill); }
  .sankey-wrap .header { margin-bottom: 16px; }
  .sankey-wrap .header h2 {
    font-size: 17px; font-weight: 700;
    letter-spacing: -0.3px; line-height: 1.35;
    color: var(--title-color); margin-bottom: 4px;
  }
  .sankey-wrap .header p { font-size: 11px; color: var(--text-muted); line-height: 1.5; }
  #skChartWrap { width: 100%; }
  #skChartSvg  { width: 100%; display: block; overflow: visible; }
  /* ── Node + link styles ── */
  .sankey-wrap .node rect {
    fill: var(--node-fill);
    stroke: var(--node-stroke);
    stroke-width: 0.8px;
    cursor: default;
    transition: fill 0.2s;
  }
  .sankey-wrap .node rect:hover { filter: brightness(1.15); }
  .sankey-wrap .link {
    fill: none;
    stroke: var(--link-color);
    transition: stroke 0.2s;
    cursor: pointer;
  }
  .sankey-wrap .link:hover { stroke: var(--link-hover); }
  .sankey-wrap .node-label {
    font-family: 'IBM Plex Sans', sans-serif;
    font-size: 11px;
    font-weight: 600;
    fill: var(--label-color);
    pointer-events: none;
  }
  .sankey-wrap .node-value {
    font-family: 'IBM Plex Mono', monospace;
    font-size: 9.5px;
    fill: var(--value-color);
    pointer-events: none;
  }
  /* ── Tooltip ── */
  #skTooltip {
    position: fixed;
    display: none;
    background: var(--tooltip-bg);
    border: 1px solid var(--tooltip-bd);
    border-radius: 6px;
    padding: 8px 12px;
    font-size: 11px;
    pointer-events: none;
    z-index: 99;
    min-width: 140px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.18);
  }
  #skTooltip .tt-title {
    font-weight: 700; font-size: 11px; margin-bottom: 4px;
    color: var(--text);
  }
  #skTooltip .tt-row {
    font-size: 10px; color: var(--text-muted);
    display: flex; justify-content: space-between; gap: 10px;
    margin-top: 2px;
  }
  #skTooltip .tt-val {
    font-family: 'IBM Plex Mono', monospace;
    font-weight: 600; color: var(--text);
  }
  .sankey-wrap .footer {
    margin-top: 14px; padding-top: 10px;
    border-top: 1px solid var(--border);
    font-size: 10px; color: var(--text-muted); line-height: 1.7;
  }
  .sankey-wrap .footer .source { font-style: italic; }
</style>

<div class="controls-wrap">
  <div class="dropdown-wrap">
    <span class="dropdown-label">Company</span>
    <select class="company-select" id="skCompanySelect" onchange="skSwitchCompany(this.value)">
      <option value="BKR">BKR — Baker Hughes</option>
      <option value="SMR">SMR — NuScale Power</option>
      <option value="SLB">SLB — SLB</option>
      <option value="OXY">OXY — Occidental Petroleum</option>
      <option value="MPC">MPC — Marathon Petroleum</option>
      <option value="IREN">IREN — IREN</option>
      <option value="WMB">WMB — Williams Companies</option>
      <option value="EOSE">EOSE — Eos Energy</option>
      <option value="XOM">XOM — ExxonMobil</option>
      <option value="E">E — Eni</option>
      <option value="DVN">DVN — Devon Energy</option>
      <option value="CVX">CVX — Chevron</option>
      <option value="CEG">CEG — Constellation Energy</option>
      <option value="ENB">ENB — Enbridge</option>
      <option value="COP">COP — ConocoPhillips</option>
      <option value="EOG">EOG — EOG Resources</option>
      <option value="VLO">VLO — Valero Energy</option>
      <option value="TTE">TTE — TotalEnergies</option>
      <option value="SU">SU — Suncor Energy</option>
      <option value="CNQ">CNQ — Canadian Natural Resources</option>
      <option value="CVE">CVE — Cenovus Energy</option>
      <option value="PSX">PSX — Phillips 66</option>
      <option value="KMI">KMI — Kinder Morgan</option>
      <option value="HAL">HAL — Halliburton</option>
      <option value="EQNR">EQNR — Equinor</option>
      <option value="EC">EC — Ecopetrol</option>
      <option value="SHEL">SHEL — Shell</option>
      <option value="FANG">FANG — Diamondback Energy</option>
    </select>
  </div>
  <button class="toggle-btn" id="skToggleBtn" onclick="skToggleMode()">🌙 Dark Mode</button>
</div>
<div class="header">
  <h2 id="skChartTitle">BKR — Where Every Dollar Goes, FY2025</h2>
  <p id="skChartSubtitle">BKR returned $0.4B via buybacks vs $0.9B in dividends.</p>
</div>
<div id="skChartWrap">
  <svg id="skChartSvg"></svg>
</div>
<div id="skTooltip">
  <div class="tt-title" id="skTtTitle"></div>
  <div class="tt-row"><span>Value</span><span class="tt-val" id="skTtVal"></span></div>
  <div class="tt-row"><span>% of Revenue</span><span class="tt-val" id="skTtPct"></span></div>
</div>
<div class="footer">
  <div class="source">Source: Company financial statements</div>
  <div>Note: Values in USD. Production &amp; refining costs adjusted to absorb debt credits and balance to revenue. FY2025.</div>
</div>

<!-- D3 v7 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/d3/7.8.5/d3.min.js"></script>
<!-- D3 Sankey plugin -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/d3-sankey/0.12.3/d3-sankey.min.js"></script>
<script>
(function () {
  // ── Outer-scoped REVENUE so showTip can always access the current value ──
  let REVENUE = 0;

  // ── Multi-company data ──────────────────────────────────────────────────
  const NODE_NAMES = [
    'Revenue',                       // 0
    'Production & refining costs',   // 1
    'Taxes & royalties',             // 2
    'Exploration & capex',           // 3
    'Shareholder returns',           // 4
    'Dividends',                     // 5
    'Buybacks',                      // 6
  ];
  const COMPANIES = {
    BKR:  { title: "BKR — Where Every Dollar Goes, FY2025",  subtitle: "BKR returned $0.4B via buybacks vs $0.9B in dividends.",           flows: [21189000000,253000000,-222000000,1273000000,1294000000,910000000,384000000],         nodes: [27733000000,21189000000,253000000,-222000000,1273000000,1294000000,910000000,384000000] },
    SMR:  { title: "SMR — Where Every Dollar Goes, FY2025",  subtitle: "SMR returned N/A via buybacks vs N/A in dividends.",               flows: [20048000,342000,0,508000,0,0,0],                                                       nodes: [31479000,20048000,342000,0,508000,0,0,0] },
    SLB:  { title: "SLB — Where Every Dollar Goes, FY2025",  subtitle: "SLB returned $2.4B via buybacks vs $1.6B in dividends.",           flows: [29201000000,840000000,-558000000,1946000000,4016000000,1602000000,2414000000],         nodes: [35708000000,29201000000,840000000,-558000000,1946000000,4016000000,1602000000,2414000000] },
    OXY:  { title: "OXY — Where Every Dollar Goes, FY2025",  subtitle: "OXY returned N/A via buybacks vs $1.6B in dividends.",             flows: [14050000000,1021000000,-1079000000,6427000000,1594000000,1594000000,0],                nodes: [21593000000,14050000000,1021000000,-1079000000,6427000000,1594000000,1594000000,0] },
    MPC:  { title: "MPC — Where Every Dollar Goes, FY2025",  subtitle: "MPC returned $3.5B via buybacks vs $1.1B in dividends.",           flows: [122697000000,1137000000,-1412000000,3486000000,4628000000,1140000000,3488000000],      nodes: [132699000000,122697000000,1137000000,-1412000000,3486000000,4628000000,1140000000,3488000000] },
    IREN: { title: "IREN — Where Every Dollar Goes, FY2025", subtitle: "IREN returned N/A via buybacks vs N/A in dividends.",              flows: [158992000,6560000,-11045000,1372627000,0,0,0],                                         nodes: [501023000,158992000,6560000,-11045000,1372627000,0,0,0] },
    WMB:  { title: "WMB — Where Every Dollar Goes, FY2025",  subtitle: "WMB returned N/A via buybacks vs $2.4B in dividends.",             flows: [4546000000,857000000,-1442000000,4999000000,2442000000,2442000000,0],                  nodes: [11950000000,4546000000,857000000,-1442000000,4999000000,2442000000,2442000000,0] },
    EOSE: { title: "EOSE — Where Every Dollar Goes, FY2025", subtitle: "EOSE returned $0.0B via buybacks vs N/A in dividends.",            flows: [258040000,24000,-23255000,54691000,488000,0,488000],                                   nodes: [114203000,258040000,24000,-23255000,54691000,488000,0,488000] },
    XOM:  { title: "XOM — Where Every Dollar Goes, FY2025",  subtitle: "XOM returned $20.3B via buybacks vs $17.2B in dividends.",         flows: [252665000000,11504000000,-603000000,28358000000,37504000000,17231000000,20273000000],   nodes: [323905000000,252665000000,11504000000,-603000000,28358000000,37504000000,17231000000,20273000000] },
    E:    { title: "E — Where Every Dollar Goes, FY2025",    subtitle: "E returned $1.9B via buybacks vs $3.1B in dividends.",             flows: [74405000000,3020000000,-8170000000,9229000000,4976000000,3080000000,1896000000],       nodes: [82151000000,74405000000,3020000000,-8170000000,9229000000,4976000000,3080000000,1896000000] },
    DVN:  { title: "DVN — Where Every Dollar Goes, FY2025",  subtitle: "DVN returned $1.1B via buybacks vs $0.6B in dividends.",           flows: [12797000000,785000000,-497000000,3914000000,1669000000,619000000,1050000000],          nodes: [17188000000,12797000000,785000000,-497000000,3914000000,1669000000,619000000,1050000000] },
    CVX:  { title: "CVX — Where Every Dollar Goes, FY2025",  subtitle: "CVX returned $12.1B via buybacks vs $12.8B in dividends.",         flows: [128346000000,7258000000,-1217000000,17347000000,24830000000,12751000000,12079000000],   nodes: [184432000000,128346000000,7258000000,-1217000000,17347000000,24830000000,12751000000,12079000000] },
    CEG:  { title: "CEG — Where Every Dollar Goes, FY2025",  subtitle: "CEG returned $0.4B via buybacks vs $0.5B in dividends.",           flows: [20840000000,1187000000,-511000000,2949000000,886000000,486000000,400000000],           nodes: [25533000000,20840000000,1187000000,-511000000,2949000000,886000000,486000000,400000000] },
    ENB:  { title: "ENB — Where Every Dollar Goes, FY2025",  subtitle: "ENB returned N/A via buybacks vs $8.2B in dividends.",             flows: [43697000000,2004000000,-4992000000,9165000000,8220000000,8220000000,0],                nodes: [65194000000,43697000000,2004000000,-4992000000,9165000000,8220000000,8220000000,0] },
    COP:  { title: "COP — Where Every Dollar Goes, FY2025",  subtitle: "COP returned $5.1B via buybacks vs $4.0B in dividends.",           flows: [44156000000,4668000000,-1233000000,12553000000,9113000000,3995000000,5118000000],      nodes: [58944000000,44156000000,4668000000,-1233000000,12553000000,9113000000,3995000000,5118000000] },
    EOG:  { title: "EOG — Where Every Dollar Goes, FY2025",  subtitle: "EOG returned $2.6B via buybacks vs $2.2B in dividends.",           flows: [8270000000,1382000000,-235000000,6594000000,4725000000,2161000000,2564000000],         nodes: [22582000000,8270000000,1382000000,-235000000,6594000000,4725000000,2161000000,2564000000] },
    VLO:  { title: "VLO — Where Every Dollar Goes, FY2025",  subtitle: "VLO returned $2.6B via buybacks vs $1.4B in dividends.",           flows: [117318000000,759000000,-556000000,796000000,4003000000,1405000000,2598000000],         nodes: [122687000000,117318000000,759000000,-556000000,796000000,4003000000,1405000000,2598000000] },
    TTE:  { title: "TTE — Where Every Dollar Goes, FY2025",  subtitle: "TTE returned $7.7B via buybacks vs $8.1B in dividends.",           flows: [130497000000,9092000000,-2558000000,16953000000,15835000000,8121000000,7714000000],    nodes: [182344000000,130497000000,9092000000,-2558000000,16953000000,15835000000,8121000000,7714000000] },
    SU:   { title: "SU — Where Every Dollar Goes, FY2025",   subtitle: "SU returned $3.1B via buybacks vs $2.8B in dividends.",            flows: [30703000000,2030000000,-743000000,5856000000,5938000000,2809000000,3129000000],        nodes: [52377000000,30703000000,2030000000,-743000000,5856000000,5938000000,2809000000,3129000000] },
    CNQ:  { title: "CNQ — Where Every Dollar Goes, FY2025",  subtitle: "CNQ returned $1.4B via buybacks vs $4.9B in dividends.",           flows: [34766000000,2421000000,-1039000000,6791000000,6320000000,4871000000,1449000000],       nodes: [44167000000,34766000000,2421000000,-1039000000,6791000000,6320000000,4871000000,1449000000] },
    CVE:  { title: "CVE — Where Every Dollar Goes, FY2025",  subtitle: "CVE returned $2.5B via buybacks vs N/A in dividends.",             flows: [40935000000,547000000,-661000000,4907000000,2500000000,0,2500000000],                  nodes: [52751000000,40935000000,547000000,-661000000,4907000000,2500000000,0,2500000000] },
    PSX:  { title: "PSX — Where Every Dollar Goes, FY2025",  subtitle: "PSX returned $1.2B via buybacks vs $1.9B in dividends.",           flows: [119344000000,892000000,-1086000000,2233000000,3129000000,1922000000,1207000000],       nodes: [132376000000,119344000000,892000000,-1086000000,2233000000,3129000000,1922000000,1207000000] },
    KMI:  { title: "KMI — Where Every Dollar Goes, FY2025",  subtitle: "KMI returned N/A via buybacks vs $2.6B in dividends.",             flows: [7982000000,832000000,0,3026000000,2604000000,2604000000,0],                           nodes: [16937000000,7982000000,832000000,0,3026000000,2604000000,2604000000,0] },
    HAL:  { title: "HAL — Where Every Dollar Goes, FY2025",  subtitle: "HAL returned $1.0B via buybacks vs $0.6B in dividends.",           flows: [18700000000,479000000,-352000000,1254000000,1586000000,579000000,1007000000],          nodes: [22184000000,18700000000,479000000,-352000000,1254000000,1586000000,579000000,1007000000] },
    EQNR: { title: "EQNR — Where Every Dollar Goes, FY2025", subtitle: "EQNR returned $5.9B via buybacks vs $4.8B in dividends.",          flows: [67482000000,20030000000,-832000000,13994000000,10707000000,4791000000,5916000000],     nodes: [105828000000,67482000000,20030000000,-832000000,13994000000,10707000000,4791000000,5916000000] },
    EC:   { title: "EC — Where Every Dollar Goes, FY2025",   subtitle: "EC returned N/A via buybacks vs $15565.1B in dividends.",          flows: [86481154000000,12208540000000,-9842686000000,20927585000000,15565064000000,15565064000000,0], nodes: [133330428000000,86481154000000,12208540000000,-9842686000000,20927585000000,15565064000000,15565064000000,0] },
    SHEL: { title: "SHEL — Where Every Dollar Goes, FY2025", subtitle: "SHEL returned $13.9B via buybacks vs $8.5B in dividends.",         flows: [224391000000,11637000000,-4741000000,18947000000,22351000000,8472000000,13879000000],   nodes: [266886000000,224391000000,11637000000,-4741000000,18947000000,22351000000,8472000000,13879000000] },
    FANG: { title: "FANG — Where Every Dollar Goes, FY2025", subtitle: "FANG returned $2.0B via buybacks vs $1.2B in dividends.",          flows: [9708000000,327000000,-265000000,9461000000,3166000000,1156000000,2010000000],          nodes: [14929000000,9708000000,327000000,-265000000,9461000000,3166000000,1156000000,2010000000] },
  };

  let currentCompany = 'BKR';

  function getNodesLinks(key) {
    const d       = COMPANIES[key];
    const revenue = d.nodes[0];
    const [prodRaw, taxes, debt, capex, returns, dividends, buybacks] = d.flows;
    const prodAdj = revenue - taxes - capex - returns;
    const useAdj  = prodAdj > 0;
    const nodeValues = useAdj
      ? [revenue, prodAdj, taxes, capex, returns, dividends, buybacks]
      : [revenue, 0,       taxes, capex, returns, dividends, buybacks];
    const NODES = NODE_NAMES.map((name, i) => ({
      id: i, name, value: nodeValues[i] ?? 0
    }));
    const rawLinks = [
      { source: 0, target: 1, value: useAdj ? prodAdj : 0 },
      { source: 0, target: 2, value: taxes   },
      { source: 0, target: 3, value: capex   },
      { source: 0, target: 4, value: returns },
      { source: 4, target: 5, value: dividends },
      { source: 4, target: 6, value: buybacks  },
    ];
    const LINKS = rawLinks.filter(l => l.value > 0);
    return { NODES, LINKS, REVENUE: revenue };
  }

  // ── Format helpers ──────────────────────────────────────────────────────
  function bestFmt(v) {
    const a = Math.abs(v);
    if (a >= 1e9) return `${(v/1e9).toFixed(1)} Bn`;
    if (a >= 1e6) return `${(v/1e6).toFixed(1)} Mn`;
    if (a >= 1e3) return `${(v/1e3).toFixed(1)} K`;
    return `${v.toFixed(1)}`;
  }

  // ── Tooltip ─────────────────────────────────────────────────────────────
  const tooltip = document.getElementById('skTooltip');
  function showTip(evt, name, value) {
    document.getElementById('skTtTitle').textContent = name;
    document.getElementById('skTtVal').textContent   = bestFmt(value);
    document.getElementById('skTtPct').textContent   = `${((Math.abs(value)/REVENUE)*100).toFixed(1)}%`;
    tooltip.style.display = 'block';
    moveTip(evt);
  }
  function moveTip(evt) {
    tooltip.style.left = `${evt.clientX + 14}px`;
    tooltip.style.top  = `${evt.clientY - 10}px`;
  }
  function hideTip() { tooltip.style.display = 'none'; }

  // ── Main build ──────────────────────────────────────────────────────────
  function rebuild() {
    const result = getNodesLinks(currentCompany);
    REVENUE = result.REVENUE;
    const { NODES, LINKS } = result;

    const wrap = document.getElementById('skChartWrap');
    const svg  = d3.select('#skChartSvg');
    svg.selectAll('*').remove();

    const W = wrap.clientWidth || 800;
    const H = Math.round(W * 0.82);
    const PAD = { top: 20, right: 160, bottom: 20, left: 20 };
    svg.attr('viewBox', `0 0 ${W} ${H}`).attr('height', H);

    const root = svg.append('g').attr('transform', `translate(${PAD.left},${PAD.top})`);
    const iW   = W - PAD.left - PAD.right;
    const iH   = H - PAD.top  - PAD.bottom;

    // ── Sankey layout ──
    const sankey = d3.sankey()
      .nodeId(d => d.id)
      .nodeWidth(14)
      .nodePadding(18)
      .extent([[0, 0], [iW, iH]]);

    const graph = sankey({
      nodes: NODES.map(d => ({ ...d })),
      links: LINKS.map(d => ({ ...d })),
    });

    // ── Links ──
    root.append('g')
      .selectAll('path')
      .data(graph.links)
      .join('path')
        .attr('class', 'link')
        .attr('d', d3.sankeyLinkHorizontal())
        .attr('stroke-width', d => Math.max(1, d.width))
        .on('mouseenter', function(evt, d) {
          showTip(evt, `${d.source.name} \u2192 ${d.target.name}`, d.value);
        })
        .on('mousemove', moveTip)
        .on('mouseleave', hideTip);

    // ── Nodes ──
    const node = root.append('g')
      .selectAll('g')
      .data(graph.nodes)
      .join('g')
        .attr('class', 'node')
        .attr('transform', d => `translate(${d.x0},${d.y0})`);

    node.append('rect')
      .attr('width',  d => d.x1 - d.x0)
      .attr('height', d => Math.max(1, d.y1 - d.y0))
      .attr('rx', 3)
      .on('mouseenter', function(evt, d) { showTip(evt, d.name, d.value); })
      .on('mousemove',  moveTip)
      .on('mouseleave', hideTip);

    // ── Labels ──
    graph.nodes.forEach(d => {
      const nodeH  = Math.max(1, d.y1 - d.y0);
      const midY   = nodeH / 2;
      const nodeW  = d.x1 - d.x0;
      const isLeft = d.x0 < iW * 0.4;
      const g = root.append('g')
        .attr('transform', `translate(${d.x0},${d.y0})`);

      const xLabel = isLeft ? -8 : nodeW + 8;
      const anchor = isLeft ? 'end' : 'start';

      g.append('text')
        .attr('class', 'node-label')
        .attr('x', xLabel)
        .attr('y', midY - 5)
        .attr('dy', '0.35em')
        .attr('text-anchor', anchor)
        .text(d.name);

      g.append('text')
        .attr('class', 'node-value')
        .attr('x', xLabel)
        .attr('y', midY + 9)
        .attr('dy', '0.35em')
        .attr('text-anchor', anchor)
        .text(bestFmt(d.value));
    });
  }

  // ── Switch company ──────────────────────────────────────────────────────
  function skSwitchCompany(key) {
    currentCompany = key;
    const d = COMPANIES[key];
    document.getElementById('skChartTitle').textContent    = d.title;
    document.getElementById('skChartSubtitle').textContent = d.subtitle;
    rebuild();
  }

  // ── Toggle ──────────────────────────────────────────────────────────────
  function skToggleMode() {
    const wrap = document.getElementById('skWrap');
    wrap.classList.toggle('dark');
    const isDark = wrap.classList.contains('dark');
    document.getElementById('skToggleBtn').textContent = isDark ? '\u2600 Light Mode' : '\uD83C\uDF19 Dark Mode';
    rebuild();
  }

  window.skToggleMode    = skToggleMode;
  window.skSwitchCompany = skSwitchCompany;

  rebuild();
  window.addEventListener('resize', rebuild);
})();
</script>
</div>


You bought energy stocks expecting a price rally. The Iran conflict was supposed to be the catalyst, oil supply shock, sector rotation, the whole thesis.

But markets are unpredictable. The rally hasn't come the way you expected. Your position is flat or underwater, and patience is wearing thin.

Here's what most retail investors miss in that moment, you're still getting paid.

Chevron and ExxonMobil, the two largest energy names in the watchlist, have been writing dividend checks for over 35 consecutive years without a single cut. CVX yields 3.58%, XOM yields 2.56%. On a $10,000 position, that's $100–$358 landing in your account annually just for holding.

The ceasefire rally may still come. But while you wait, Chevron pays you more than ExxonMobil does.

Price return is the goal. Dividends are the floor.



<div class="not-prose div-wrap light" id="divWrap">
<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@300;400;600;700&family=IBM+Plex+Mono:wght@400;600&display=swap');
  /* ── Dark (default) ── */
  .div-wrap {
    --bg:          #141414;
    --surface:     #1c1c1c;
    --border:      #2a2a2a;
    --text:        #e2e2e2;
    --text-muted:  #666666;
    --title-color: #f0f0f0;
    --grid:        rgba(255,255,255,0.06);
    --ref-line:    rgba(255,255,255,0.18);
    --label-color: #cccccc;
    --dot-color:   rgba(87,120,164,0.5);
    --dot-border:  rgba(87,120,164,0.85);
    --nd-color:    rgba(136,136,136,0.3);
    --nd-border:   rgba(136,136,136,0.6);
    --q1-color:    rgba(180,180,100,0.8);
    --q2-color:    rgba(80,190,120,0.9);
    --q3-color:    rgba(150,150,150,0.6);
    --q4-color:    rgba(180,140,80,0.8);
    --tooltip-bg:  rgba(20,20,20,0.96);
    --tooltip-bd:  #3a3a3a;
  }
  /* ── Light ── */
  .div-wrap.light {
    --bg:          #f5f4f0;
    --surface:     #ffffff;
    --border:      #e0ddd8;
    --text:        #1a1a1a;
    --text-muted:  #888888;
    --title-color: #111111;
    --grid:        rgba(0,0,0,0.05);
    --ref-line:    rgba(0,0,0,0.13);
    --label-color: #333333;
    --dot-color:   rgba(87,120,164,0.55);
    --dot-border:  rgba(87,120,164,0.9);
    --nd-color:    rgba(136,136,136,0.25);
    --nd-border:   rgba(136,136,136,0.5);
    --q1-color:    rgba(140,140,40,0.75);
    --q2-color:    rgba(30,140,70,0.85);
    --q3-color:    rgba(120,120,120,0.55);
    --q4-color:    rgba(150,100,20,0.75);
    --tooltip-bg:  rgba(255,255,255,0.97);
    --tooltip-bd:  #cccccc;
  }
  .div-wrap * { box-sizing: border-box; margin: 0; padding: 0; }
  .div-wrap {
    background: var(--bg);
    color: var(--text);
    font-family: 'IBM Plex Sans', sans-serif;
    padding: 24px 32px 20px;
    transition: background 0.3s, color 0.3s;
    border-radius: 8px;
  }
  /* ── Controls ── */
  .div-wrap .controls-wrap {
    display: flex; justify-content: space-between;
    align-items: center; margin-bottom: 14px;
  }
  .div-wrap .toggle-btn {
    font-family: 'IBM Plex Mono', monospace;
    font-size: 10px; font-weight: 600;
    letter-spacing: 0.8px; text-transform: uppercase;
    padding: 5px 12px; border-radius: 4px;
    border: 1px solid var(--border);
    background: var(--surface); color: var(--text-muted);
    cursor: pointer; transition: all 0.2s;
  }
  .div-wrap .toggle-btn:hover { color: var(--text); border-color: var(--text-muted); }
  /* ── Header ── */
  .div-wrap .header { margin-bottom: 14px; }
  .div-wrap .header h2 {
    font-size: 16px; font-weight: 700;
    letter-spacing: -0.3px; line-height: 1.35;
    color: var(--title-color); margin-bottom: 4px;
  }
  .div-wrap .header p { font-size: 11px; color: var(--text-muted); }
  /* ── Chart ── */
  .div-wrap .chart-wrap { position: relative; height: 500px; }
  .div-wrap canvas { width: 100% !important; }
  /* ── Legend ── */
  .div-wrap .legend {
    display: flex; gap: 20px; margin-top: 10px;
    font-size: 11px; color: var(--text-muted);
    flex-wrap: wrap; align-items: center;
  }
  .div-wrap .legend-item { display: flex; align-items: center; gap: 5px; }
  .div-wrap .legend-dot {
    width: 10px; height: 10px;
    border-radius: 50%; display: inline-block;
  }
  /* ── Footer ── */
  .div-wrap .footer {
    margin-top: 14px; padding-top: 10px;
    border-top: 1px solid var(--border);
    font-size: 10px; color: var(--text-muted); line-height: 1.7;
  }
  .div-wrap .footer .source { font-style: italic; }
</style>


<div class="controls-wrap">
  <div></div>
  <button class="toggle-btn" id="divToggleBtn" onclick="divToggleMode()">\uD83C\uDF19 Dark Mode</button>
</div>
<div class="header">
  <h2>Dividend Per Share vs Total Dividends Paid</h2>
  <p>Energy sector — bubble size represents market capitalisation</p>
</div>
<div class="chart-wrap">
  <canvas id="divSc"></canvas>
</div>
<div class="legend">
  <div class="legend-item">
    <span class="legend-dot" style="background:#5778a4;opacity:0.7"></span>
    Has dividend
  </div>
  <div class="legend-item">
    <span class="legend-dot" style="background:#888;opacity:0.5"></span>
    No dividend
  </div>
  <span style="color:var(--text-muted)">&middot; Bubble size = market cap &nbsp;&middot;&nbsp; Dashed lines = median</span>
</div>
<div class="footer">
  <div class="source">Source: Yahoo Finance via yfinance</div>
  <div>Note: Dividend yield based on trailing twelve months. Market cap in USD billions.</div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.js"></script>
<script>
(function () {
  const raw = [
    {t:'XOM',  x:4.12, y:17.17, mc:669.56, dy:2.56},
    {t:'CVX',  x:7.12, y:14.11, mc:397.81, dy:3.58},
    {t:'SHEL', x:2.98, y:8.35,  mc:260.96, dy:3.20},
    {t:'TTE',  x:3.66, y:7.82,  mc:198.16, dy:3.96},
    {t:'ENB',  x:2.84, y:6.20,  mc:118.19, dy:5.25},
    {t:'COP',  x:3.36, y:4.10,  mc:159.54, dy:2.57},
    {t:'EQNR', x:1.56, y:3.89,  mc:104.05, dy:3.74},
    {t:'CNQ',  x:1.82, y:3.80,  mc:99.39,  dy:3.83},
    {t:'E',    x:2.40, y:3.53,  mc:84.19,  dy:4.20},
    {t:'KMI',  x:1.17, y:2.60,  mc:73.35,  dy:3.55},
    {t:'WMB',  x:2.10, y:2.57,  mc:88.05,  dy:2.92},
    {t:'EOG',  x:4.08, y:2.19,  mc:76.53,  dy:2.86},
    {t:'SU',   x:1.74, y:2.07,  mc:78.47,  dy:2.65},
    {t:'PSX',  x:5.08, y:2.04,  mc:70.62,  dy:2.88},
    {t:'SLB',  x:1.18, y:1.77,  mc:74.22,  dy:2.39},
    {t:'VLO',  x:4.80, y:1.43,  mc:72.99,  dy:1.97},
    {t:'EC',   x:0.66, y:1.36,  mc:32.48,  dy:4.37},
    {t:'FANG', x:4.20, y:1.18,  mc:54.69,  dy:2.17},
    {t:'MPC',  x:3.82, y:1.12,  mc:71.25,  dy:1.58},
    {t:'CVE',  x:0.57, y:1.07,  mc:50.11,  dy:2.16},
    {t:'OXY',  x:1.04, y:1.03,  mc:62.45,  dy:1.65},
    {t:'BKR',  x:0.92, y:0.91,  mc:59.88,  dy:1.52},
    {t:'CEG',  x:1.71, y:0.62,  mc:98.84,  dy:0.63},
    {t:'DVN',  x:0.96, y:0.60,  mc:30.76,  dy:1.94},
    {t:'HAL',  x:0.68, y:0.57,  mc:32.12,  dy:1.78},
  ];
  const noDividend = [
    {t:'DIA',  mc:37.78},
    {t:'EOSE', mc:1.69},
    {t:'IREN', mc:11.54},
    {t:'SMR',  mc:3.23},
  ];
  const maxMC = 669.56;
  const toR   = mc => Math.max(5, Math.sqrt(mc / maxMC) * 38);
  const medX  = [...raw.map(d=>d.x)].sort((a,b)=>a-b)[Math.floor(raw.length/2)];
  const medY  = [...raw.map(d=>d.y)].sort((a,b)=>a-b)[Math.floor(raw.length/2)];

  function getCSSVar(name) {
    return getComputedStyle(document.getElementById('divWrap')).getPropertyValue(name).trim();
  }

  let divChart = null;

  function buildChart() {
    const gridC   = getCSSVar('--grid');
    const textC   = getCSSVar('--text-muted');
    const labelC  = getCSSVar('--label-color');
    const refLine = getCSSVar('--ref-line');
    const dotC    = getCSSVar('--dot-color');
    const dotB    = getCSSVar('--dot-border');
    const ndC     = getCSSVar('--nd-color');
    const ndB     = getCSSVar('--nd-border');
    const q1C     = getCSSVar('--q1-color');
    const q2C     = getCSSVar('--q2-color');
    const q3C     = getCSSVar('--q3-color');
    const q4C     = getCSSVar('--q4-color');

    if (divChart) { divChart.destroy(); divChart = null; }
    const ctx = document.getElementById('divSc').getContext('2d');
    divChart = new Chart(ctx, {
      type: 'bubble',
      data: {
        datasets: [
          {
            label: 'Has dividend',
            data: raw.map(d => ({ x: d.x, y: d.y, r: toR(d.mc), ticker: d.t, dy: d.dy, mc: d.mc })),
            backgroundColor: dotC,
            borderColor:     dotB,
            borderWidth: 1,
          },
          {
            label: 'No dividend',
            data: noDividend.map(d => ({ x: 0.1, y: 0.1, r: toR(d.mc), ticker: d.t, mc: d.mc })),
            backgroundColor: ndC,
            borderColor:     ndB,
            borderWidth: 1,
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: { display: false },
          tooltip: {
            backgroundColor: getCSSVar('--tooltip-bg'),
            borderColor:     getCSSVar('--tooltip-bd'),
            borderWidth: 1,
            titleColor:  getCSSVar('--text'),
            bodyColor:   getCSSVar('--text-muted'),
            callbacks: {
              label: ctx => {
                const d = ctx.raw;
                if (!d.dy) return `${d.ticker} \u2014 no dividend  |  MktCap: $${d.mc.toFixed(1)}B`;
                return [
                  `${d.ticker}`,
                  `Div/share: $${d.x.toFixed(2)}`,
                  `Total paid: $${d.y.toFixed(2)}B`,
                  `Yield: ${d.dy.toFixed(2)}%`,
                  `MktCap: $${d.mc.toFixed(1)}B`,
                ];
              }
            }
          },
        },
        scales: {
          x: {
            title: { display: true, text: 'Annual dividend per share ($)', color: textC, font: { size: 11 } },
            grid:  { color: gridC },
            ticks: { color: textC, font: { size: 10 }, callback: v => '$' + v.toFixed(1) },
            min: 0, max: 8,
          },
          y: {
            title: { display: true, text: 'Total dividends paid ($B)', color: textC, font: { size: 11 } },
            grid:  { color: gridC },
            ticks: { color: textC, font: { size: 10 }, callback: v => '$' + v + 'B' },
            min: 0, max: 20,
          },
        },
        animation: false,
      },
      plugins: [
        {
          id: 'quadrant',
          afterDraw(chart) {
            const { ctx, scales: { x, y }, chartArea: { left, right, top, bottom } } = chart;
            const qx = x.getPixelForValue(medX);
            const qy = y.getPixelForValue(medY);
            ctx.save();
            ctx.setLineDash([4,4]);
            ctx.strokeStyle = refLine;
            ctx.lineWidth   = 1;
            ctx.beginPath(); ctx.moveTo(qx, top);   ctx.lineTo(qx, bottom); ctx.stroke();
            ctx.beginPath(); ctx.moveTo(left, qy);  ctx.lineTo(right, qy);  ctx.stroke();
            ctx.setLineDash([]);
            const ql = [
              { text: 'Low per share,\nhigh total',     px: left+8, py: top+14,  c: q1C },
              { text: '\u2605 High per share\n& high total', px: qx+6,  py: top+14,  c: q2C },
              { text: 'Low per share,\nlow total',      px: left+8, py: qy+14,  c: q3C },
              { text: 'High per share,\nlow total',     px: qx+6,  py: qy+14,  c: q4C },
            ];
            ql.forEach(q => {
              ctx.font = '500 9px IBM Plex Sans, sans-serif';
              ctx.fillStyle = q.c;
              q.text.split('\n').forEach((line, i) => {
                ctx.fillText(line, q.px, q.py + i * 13);
              });
            });
            ctx.restore();
          }
        },
        {
          id: 'labels',
          afterDatasetsDraw(chart) {
            const { ctx } = chart;
            chart.data.datasets.forEach((ds, di) => {
              const meta = chart.getDatasetMeta(di);
              ds.data.forEach((pt, i) => {
                if (!pt.ticker) return;
                const el = meta.data[i];
                if (!el) return;
                ctx.save();
                ctx.font      = '500 9px IBM Plex Mono, monospace';
                ctx.fillStyle = labelC;
                ctx.textAlign = 'center';
                ctx.fillText(pt.ticker, el.x, el.y - el.options.radius - 3);
                ctx.restore();
              });
            });
          }
        }
      ]
    });
  }

  function divToggleMode() {
    const wrap = document.getElementById('divWrap');
    wrap.classList.toggle('light');
    const isLight = wrap.classList.contains('light');
    document.getElementById('divToggleBtn').textContent = isLight ? '\uD83C\uDF19 Dark Mode' : '\u2600 Light Mode';
    buildChart();
  }

  window.divToggleMode = divToggleMode;

  buildChart();
})();
</script>
</div>
