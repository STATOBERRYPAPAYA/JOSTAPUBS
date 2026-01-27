<section class="home-hero" aria-label="josta hero">
  <h1 class="home-title">Journal of Sustainable Technology in Agriculture</h1>
    </section>
    
    <style>
    /* palette */
    :root{
      --j-navy:#1f345c;
        --j-brown:#8b6a3a;
        --j-rule:#e7e2d4;   /* soft beige line */
        --j-beige:#fdf6ec;  /* warm beige bg */
        --j-ink:#325d88;    /* title blue */
    }
  
  /* hero */
    .home-hero{
      text-align:center;
      padding:1.5rem 0 .75rem;
      border-bottom:2px solid var(--j-rule);
      background:linear-gradient(180deg,var(--j-beige) 0%, #fff 100%);
    }
  .home-title{
    font-family:Georgia,"Times New Roman",serif;
    font-weight:700;
    font-size:clamp(1.5rem,3.5vw,2rem);
    color:var(--j-ink);
    margin:0;
    letter-spacing:.5px;
  }
  
  /* banner */
    .hero-banner{ text-align:center; margin:.75rem 0 1rem; }
  .hero-banner img{
    width:100%; max-height:220px; object-fit:cover; border-radius:8px;
    box-shadow:0 2px 6px rgba(0,0,0,.06);
  }
  
  /* slim icon strip (section shortcuts) */
    .icon-strip{
      display:flex; flex-wrap:wrap; justify-content:center; align-items:center;
      gap:.9rem 1.1rem;
      background:linear-gradient(180deg,#fff 0%, var(--j-beige) 90%);
                                 border:1px solid var(--j-rule);
                                 border-radius:10px;
                                 padding:.6rem .9rem;
                                 margin:0 auto 1rem;
                                 max-width:1100px;
    }
  .icon-strip a{
    font-size:1.25rem; line-height:1; color:var(--j-navy); text-decoration:none;
    display:inline-flex; align-items:center; justify-content:center;
    width:38px; height:38px; border-radius:50%;
    border:1px solid var(--j-rule); background:#fff;
      transition:transform .2s ease, box-shadow .2s ease, color .2s ease, border-color .2s ease;
  }
  .icon-strip a:hover, .icon-strip a:focus{
    color:var(--j-brown);
    border-color:var(--j-brown);
    transform:translateY(-2px);
    box-shadow:0 2px 6px rgba(0,0,0,.08);
    outline:none;
  }
  
  /* primary action buttons */
    .home-buttons{
      display:flex; flex-wrap:wrap; justify-content:center; gap:.75rem 1rem;
      background:#fff; /* cleaner plate under buttons */
        border-top:1px solid var(--j-rule);
      border-bottom:1px solid var(--j-rule);
      padding:1rem;
      margin:0 auto 1rem;
      max-width:1100px;
      box-shadow:inset 0 1px 3px rgba(0,0,0,.04);
    }
  .home-buttons a.btn{
    min-width:130px; font-weight:500; border-radius:8px; transition:all .2s ease;
  }
  .home-buttons a.btn:hover{
    transform:translateY(-1px);
    box-shadow:0 2px 6px rgba(0,0,0,.08);
  }
  
  /* responsive tweaks */
    @media (max-width:700px){
      .icon-strip{ gap:.7rem .8rem; }
      .icon-strip a{ width:40px; height:40px; font-size:1.3rem; }
      .home-buttons{ flex-direction:column; align-items:center; }
      .home-buttons a.btn{ width:88%; }
    }
  </style>
    
    <div class="hero-banner">
    <img src="bannernew.webp" alt="JOSTA cover">
    </div>  
    
    
    <!-- JOSTA credibility & indexing marquee-->
    <div class="josta-ribbon" aria-label="journal indexing and credibility badges">
    <div class="jr-track">
    
    <!-- ========== PRIMARY CHIP SET (START) ========== -->
    
    <!-- Open Access (inline vector) -->
    <span class="jr-chip jr-oa" aria-label="Open Access">
    <svg class="jr-icon" viewBox="0 0 24 24" aria-hidden="true">
    <path d="M7 10V7a5 5 0 0 1 10 0" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
    <rect x="5" y="10" width="14" height="10" rx="2" fill="none" stroke="currentColor" stroke-width="2"/>
    <circle cx="12" cy="15" r="1.8" fill="currentColor"/>
    </svg>
    <span>Open Access</span>
    </span>
    
    <!-- Peer-reviewed (inline vector) -->
    <span class="jr-chip jr-peer" aria-label="Peer-reviewed">
    <svg class="jr-icon" viewBox="0 0 24 24" aria-hidden="true">
    <path d="M3 20a6 6 0 0 1 9-5m9 5a6 6 0 0 0-9-5" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
    <path d="M6 9.5a3 3 0 1 0 6 0a3 3 0 0 0-6 0" fill="none" stroke="currentColor" stroke-width="2"/>
    <path d="M14 8l2 2 4-4" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
    </svg>
    <span>Peer-reviewed</span>
    </span>
    
    <!-- OpenAIRE (image logo) -->
    <a class="jr-chip jr-openaire"
  href="https://www.openaire.eu/"
  target="_blank"
  rel="noopener"
  aria-label="OpenAIRE indexed">
    <img class="jr-icon jr-img" src="www/openaire.png" alt="OpenAIRE">
    <span>indexed</span>
    </a>
    
    <!-- Zenodo (image logo) -->
    <a class="jr-chip jr-zenodo"
  href="https://zenodo.org/communities/josta/"
  target="_blank"
  rel="noopener"
  aria-label="Zenodo archived">
    <img class="jr-icon jr-img" src="www/zenodo.png" alt="Zenodo">
    <span>archived</span>
    </a>
    
    <!-- Crossref (image logo) -->
    <a class="jr-chip jr-crossref"
  href="https://www.crossref.org/"
  target="_blank"
  rel="noopener"
  aria-label="Crossref DOI">
    <img class="jr-icon jr-img" src="www/crossref.png" alt="Crossref">
    <span>Crossref DOI</span>
    </a>
    
    <!-- CODEN (styled like other chips) -->
    <span class="jr-chip jr-coden" aria-label="CODEN JSTACI">
    <svg class="jr-icon" viewBox="0 0 24 24" aria-hidden="true">
    <rect x="3" y="6" width="18" height="12" rx="2"
  fill="none" stroke="currentColor" stroke-width="2"/>
    <path d="M7 10h10M7 14h6" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
    </svg>
    <span>CODEN: JSTACI</span>
    </span>
    
    <!-- Google Scholar (image logo, white background) -->
    <a class="jr-chip jr-gscholar"
  href="https://scholar.google.com/scholar?hl=en&q=JOSTA+Journal+of+Sustainable+Technology+in+Agriculture"
  target="_blank"
  rel="noopener"
  aria-label="Google Scholar indexed">
    <img class="jr-icon jr-img" src="www/gscholar.webp" alt="Google Scholar">
    <span>indexed</span>
    </a>
    
    <!-- Internet Archive (image logo) -->
    <a class="jr-chip jr-intarch"
  href="https://archive.org/details/@josta_open-access_journal"
  target="_blank"
  rel="noopener"
  aria-label="Internet Archive preserved">
    <img class="jr-icon jr-img" src="www/intarch.webp" alt="Internet Archive">
    <span>preserved</span>
    </a>
    
    <!-- ========== PRIMARY CHIP SET (END) ========== -->
    
    
    <!-- ========== DUPLICATE CHIP SET FOR SEAMLESS SCROLL (START) ========== -->
    
    <!-- Open Access (inline vector) - duplicate -->
    <span class="jr-chip jr-oa" aria-label="Open Access">
    <svg class="jr-icon" viewBox="0 0 24 24" aria-hidden="true">
    <path d="M7 10V7a5 5 0 0 1 10 0" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
    <rect x="5" y="10" width="14" height="10" rx="2" fill="none" stroke="currentColor" stroke-width="2"/>
    <circle cx="12" cy="15" r="1.8" fill="currentColor"/>
    </svg>
    <span>Open Access</span>
    </span>
    
    <!-- Peer-reviewed (inline vector) - duplicate -->
    <span class="jr-chip jr-peer" aria-label="Peer-reviewed">
    <svg class="jr-icon" viewBox="0 0 24 24" aria-hidden="true">
    <path d="M3 20a6 6 0 0 1 9-5m9 5a6 6 0 0 0-9-5" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
    <path d="M6 9.5a3 3 0 1 0 6 0a3 3 0 0 0-6 0" fill="none" stroke="currentColor" stroke-width="2"/>
    <path d="M14 8l2 2 4-4" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
    </svg>
    <span>Peer-reviewed</span>
    </span>
    
    <!-- OpenAIRE (image logo) - duplicate -->
    <a class="jr-chip jr-openaire"
  href="https://www.openaire.eu/"
  target="_blank"
  rel="noopener"
  aria-label="OpenAIRE indexed">
    <img class="jr-icon jr-img" src="www/openaire.png" alt="OpenAIRE">
    <span>indexed</span>
    </a>
    
    <!-- Zenodo (image logo) - duplicate -->
    <a class="jr-chip jr-zenodo"
  href="https://zenodo.org/communities/josta/"
  target="_blank"
  rel="noopener"
  aria-label="Zenodo archived">
    <img class="jr-icon jr-img" src="www/zenodo.png" alt="Zenodo">
    <span>archived</span>
    </a>
    
    <!-- Crossref (image logo) - duplicate -->
    <a class="jr-chip jr-crossref"
  href="https://www.crossref.org/"
  target="_blank"
  rel="noopener"
  aria-label="Crossref DOI">
    <img class="jr-icon jr-img" src="www/crossref.png" alt="Crossref">
    <span>Crossref DOI</span>
    </a>
    
    <!-- CODEN (styled like other chips) - duplicate -->
    <span class="jr-chip jr-coden" aria-label="CODEN JSTACI">
    <svg class="jr-icon" viewBox="0 0 24 24" aria-hidden="true">
    <rect x="3" y="6" width="18" height="12" rx="2"
  fill="none" stroke="currentColor" stroke-width="2"/>
    <path d="M7 10h10M7 14h6" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
    </svg>
    <span>CODEN: JSTACI</span>
    </span>
    
    <!-- Google Scholar (image logo, white background) - duplicate -->
    <a class="jr-chip jr-gscholar"
  href="https://scholar.google.com/scholar?hl=en&q=JOSTA+Journal+of+Sustainable+Technology+in+Agriculture"
  target="_blank"
  rel="noopener"
  aria-label="Google Scholar indexed">
    <img class="jr-icon jr-img" src="www/gscholar.webp" alt="Google Scholar">
    <span>indexed</span>
    </a>
    
    <!-- Internet Archive (image logo) - duplicate -->
    <a class="jr-chip jr-intarch"
  href="https://archive.org/details/@josta_open-access_journal"
  target="_blank"
  rel="noopener"
  aria-label="Internet Archive preserved">
    <img class="jr-icon jr-img" src="www/intarch.webp" alt="Internet Archive">
    <span>preserved</span>
    </a>
    
    <!-- ========== DUPLICATE CHIP SET (END) ========== -->
    
    </div>
    </div>
    
    <style>
    :root {
      --navy:#1f345c;
        --teal:#0b5a56;
        --sand:#8b6a3a;
        --bg: rgba(0,0,0,.05);
    }
  
  /* container */
    .josta-ribbon {
      --speed: 28s;
      --gap: 1rem;
      background: var(--bg);
      border-radius: 16px;
      overflow: hidden;
      padding: .5rem 0;
    }
  .jr-track {
    display: inline-flex;
    align-items: center;
    gap: var(--gap);
    animation: jr-scroll var(--speed) linear infinite;
    will-change: transform;
  }
  .josta-ribbon:hover .jr-track {
    animation-play-state: paused;
  }
  
  /* chips - base style */
    .jr-chip {
      display: inline-flex;
      align-items: center;
      gap: .5rem;
      padding: .45rem .9rem;
      border-radius: 999px;
      font: 600 .95rem/1 "Segoe UI", system-ui, sans-serif;
      color: #fff;
        white-space: nowrap;
      text-decoration: none;
      box-shadow: 0 1px 3px rgba(0,0,0,.1);
      position: relative;
      overflow: hidden;
    }
  .jr-chip::after {
    content: "";
    position: absolute;
    inset: 0 -50% 0 0;
    background: linear-gradient(
      110deg,
      transparent 0%,
      rgba(255,255,255,.25) 40%,
      transparent 80%
    );
    transform: translateX(-120%);
    animation: jr-shine 5s ease-in-out infinite;
  }
  
  /* icons */
    .jr-icon {
      height: 22px;
      width: auto;
      color: #fff;
        filter: drop-shadow(0 0 2px rgba(255,255,255,.35));
      transition: transform .3s ease;
    }
  .jr-img {
    filter: none; /* keep original logo colours */
  }
  .jr-chip:hover .jr-icon {
    transform: scale(1.1);
  }
  
  /* gradients (service-specific) */
    .jr-oa {
      background: linear-gradient(90deg,#ff9a3d,#ff6a00);
    }
  .jr-peer {
    background: linear-gradient(90deg,#4bb543,#1fa26e);
  }
  .jr-openaire {
    background: linear-gradient(90deg,#fc6726,#f28150);
  }
  .jr-zenodo {
    background: linear-gradient(90deg,#00aaff,#0077cc);
  }
  .jr-crossref {
    background: linear-gradient(90deg,#6969fa,#060696);
  }
  .jr-coden {
    background: linear-gradient(90deg,#7e7e7e,#4f4f4f);
  }
  
  /* Google Scholar chip */
    .jr-gscholar {
      background: #ffffff;                    /* pure white background */
        color: #1f345c;                         /* JOSTA navy for text */
        border: 1px solid rgba(0,0,0,.12);      /* light border for contrast */
    }
  .jr-gscholar .jr-icon {
    height: 22px;
    width: auto;
    filter: none;                           /* keep original Google Scholar colours */
  }
  
  /* Internet Archive chip */
    .jr-intarch {
      background: linear-gradient(90deg,#f2f2ed,#949403); /* dark archival look */
                                  color: #ffffff;
    }
  .jr-intarch .jr-icon {
    height: 22px;
    width: auto;
    filter: none; /* keep original Internet Archive logo colours */
  }
  
  /* animations */
    @keyframes jr-scroll {
      from { transform: translateX(0); }
      to   { transform: translateX(-50%); }
    }
  @keyframes jr-shine {
    0%, 70% { transform: translateX(-120%); }
    100%    { transform: translateX(120%); }
  }

/* responsive */
  @media (max-width: 520px) {
    .jr-chip {
      padding: .35rem .7rem;
      font-size: .9rem;
    }
    .jr-icon {
      height: 18px;
    }
  }

/* accessibility */
  @media (prefers-reduced-motion: reduce) {
    .jr-track,
    .jr-chip::after {
      animation: none !important;
    }
  }
</style>
  
  
  
  <!-- icon-only, unobtrusive quick links -->
  <nav class="icon-strip" aria-label="section shortcuts">
    <a href="#about" title="About"><i class="bi bi-info-circle-fill" aria-hidden="true"></i></a>
      <a href="#journal-info" title="Journal info"><i class="bi bi-journal-text" aria-hidden="true"></i></a>
        <a href="#journalmetrics" title="Metrics"><i class="bi bi-bar-chart-line-fill" aria-hidden="true"></i></a>
          <a href="#peerpolicy" title="Peer policy"><i class="bi bi-people-fill" aria-hidden="true"></i></a>
            <a href="#apc" title="APC"><i class="bi bi-cash-coin" aria-hidden="true"></i></a>
              <a href="#copyright-info" title="Copyright"><i class="bi bi-c-circle-fill" aria-hidden="true"></i></a>
                </nav>  
                
                
                <!-- primary actions -->
                <div class="home-buttons">
                  <a href="submit.qmd" class="btn btn-outline-success"><i class="bi bi-upload"></i> Submit</a>
                    <a href="published.qmd" class="btn btn-outline-info"><i class="bi bi-book"></i> Read</a>
                      <a href="editorial.qmd" class="btn btn-outline-warning"><i class="bi bi-people"></i> Editorial</a>
                        <a href="jostasubmission.qmd" class="btn btn-outline-primary"><i class="bi bi-person-lock"></i> Author login</a>
                          <a href="https://zenodo.org/communities/josta/records" class="btn btn-outline-secondary"><i class="bi bi-cloud-arrow-down"></i> Zenodo</a>
                            </div> 