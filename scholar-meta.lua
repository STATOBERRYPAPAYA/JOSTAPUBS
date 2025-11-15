-- scholar-meta.lua : emit Google Scholar/Highwire tags + canonical + JSON-LD

local stringify = pandoc.utils.stringify

-- safely get a metadata field as string
local function meta_get(m, key)
  if not m[key] then return nil end
  return stringify(m[key])
end

-- basic HTML escaping
local function html_escape(s)
  if not s then return nil end
  s = s:gsub("&","&amp;"):gsub("<","&lt;"):gsub(">","&gt;")
  s = s:gsub('"',"&quot;"):gsub("'","&#39;")
  return s
end

-- add a <meta> tag if content is non-empty
local function add_tag(tags, name, content)
  if content and content ~= "" then
    table.insert(tags, string.format('<meta name="%s" content="%s">', name, html_escape(content)))
  end
end

-- normalize date to YYYY/MM/DD if possible
local function normalize_date(date_str)
  if not date_str or date_str == "" then
    return nil
  end

  -- try ISO: YYYY-MM-DD
  local y, m, d = date_str:match("^(%d%d%d%d)%-(%d%d)%-(%d%d)$")
  if y and m and d then
    return string.format("%s/%s/%s", y, m, d)
  end

  -- try already in YYYY/MM/DD
  y, m, d = date_str:match("^(%d%d%d%d)/(%d%d)/(%d%d)$")
  if y and m and d then
    return date_str
  end

  -- fallback: return original (Scholar will usually still cope)
  return date_str
end

-- clean author name for metadata (remove trailing * and trim spaces)
local function clean_author_name(nm)
  if not nm then return nil end
  -- remove trailing asterisks (e.g. "Name*" -> "Name")
  nm = nm:gsub("%*+$", "")
  -- trim leading/trailing whitespace
  nm = nm:gsub("^%s+", ""):gsub("%s+$", "")
  return nm
end

function Meta(m)
  local tags = {}

  -- journal-level defaults
  local journal_title = "JOSTA: Journal of Sustainable Technology in Agriculture"
  local issn = meta_get(m, "issn") or "3107-6882"
  local lang = "en"

  -- core fields
  local title = meta_get(m, "title")
  add_tag(tags, "citation_title", title)

  -- authors (multiple)
  if m.author and type(m.author) == "table" then
    for _, a in ipairs(m.author) do
      local nm
      if type(a) == "table" and a.name then
        nm = stringify(a.name)
      else
        nm = stringify(a)
      end
      nm = clean_author_name(nm)
      if nm and nm ~= "" then
        add_tag(tags, "citation_author", nm)
      end
    end
  end

  -- date
  local raw_date = meta_get(m, "date")
  local pub_date = normalize_date(raw_date)
  add_tag(tags, "citation_publication_date", pub_date)

  -- journal info
  add_tag(tags, "citation_journal_title", journal_title)
  add_tag(tags, "citation_volume", meta_get(m, "volume"))
  add_tag(tags, "citation_issue", meta_get(m, "issue"))
  add_tag(tags, "citation_issn", issn)
  add_tag(tags, "citation_language", lang)

  -- pages (if available)
  local firstpage = meta_get(m, "firstpage")
  local lastpage  = meta_get(m, "lastpage")
  add_tag(tags, "citation_firstpage", firstpage)
  add_tag(tags, "citation_lastpage", lastpage)

  -- identifiers and URLs
  local doi = meta_get(m, "doi")
  local canonical = meta_get(m, "canonical_url") or meta_get(m, "url")
  local pdf_url = meta_get(m, "pdf_url")

  add_tag(tags, "citation_doi", doi)
  add_tag(tags, "citation_fulltext_html_url", canonical)
  add_tag(tags, "citation_pdf_url", pdf_url)

  -- canonical link
  if canonical and canonical ~= "" then
    table.insert(tags, string.format('<link rel="canonical" href="%s">', html_escape(canonical)))
  end

  -- optional: Dublin Core as lightweight backup
  add_tag(tags, "DC.Title", title)
  add_tag(tags, "DC.Identifier", doi)
  add_tag(tags, "DC.Type", "Text")
  add_tag(tags, "DC.Format", "text/html")
  add_tag(tags, "DC.Language", lang)

  -- build authors array for JSON-LD
  local authors = {}
  if m.author and type(m.author) == "table" then
    for _, a in ipairs(m.author) do
      local nm
      if type(a) == "table" and a.name then
        nm = stringify(a.name)
      else
        nm = stringify(a)
      end
      nm = clean_author_name(nm)
      if nm and nm ~= "" then
        table.insert(authors, string.format('{"@type":"Person","name":"%s"}', html_escape(nm)))
      end
    end
  end

  -- pagination string for JSON-LD
  local pagination = ""
  if firstpage and firstpage ~= "" and lastpage and lastpage ~= "" then
    pagination = firstpage .. "-" .. lastpage
  elseif firstpage and firstpage ~= "" then
    pagination = firstpage
  end

  -- abstract as JSON string
  local abstract = meta_get(m, "abstract") or ""
  local abstract_json = pandoc.json.encode(abstract)

  -- schema.org JSON-LD (ScholarlyArticle)
  local jsonld = string.format([[
<script type="application/ld+json">
{
  "@context":"https://schema.org",
  "@type":"ScholarlyArticle",
  "name":"%s",
  "author":[%s],
  "datePublished":"%s",
  "isPartOf":{
    "@type":"Periodical",
    "name":"%s",
    "issn":"%s"
  },
  "identifier":"%s",
  "url":"%s",
  "sameAs":"https://doi.org/%s",
  "pagination":"%s",
  "headline":"%s",
  "description":%s,
  "encoding":{
    "@type":"MediaObject",
    "fileFormat":"application/pdf",
    "contentUrl":"%s"
  }
}
</script>
]],
    html_escape(title or ""),
    table.concat(authors, ","),
    html_escape(pub_date or raw_date or ""),
    html_escape(journal_title),
    html_escape(issn or ""),
    html_escape(doi or ""),
    html_escape(canonical or ""),
    html_escape(doi or ""),
    html_escape(pagination or ""),
    html_escape(title or ""),
    abstract_json,
    html_escape(pdf_url or "")
  )

  -- merge into header-includes
  local blocks = {
    pandoc.RawBlock("html", table.concat(tags, "\n")),
    pandoc.RawBlock("html", jsonld)
  }

  local existing = m["header-includes"]
  if existing then
    if existing.t == "MetaList" then
      for _, v in ipairs(blocks) do
        table.insert(existing, pandoc.MetaBlocks({ v }))
      end
      m["header-includes"] = existing
    else
      m["header-includes"] = pandoc.MetaList({ existing, pandoc.MetaBlocks(blocks) })
    end
  else
    m["header-includes"] = pandoc.MetaList({ pandoc.MetaBlocks(blocks) })
  end

  return m
end
