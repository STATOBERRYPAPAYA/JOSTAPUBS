-- scholar-meta.lua : emit Google Scholar/Highwire tags + canonical + JSON-LD

local stringify = pandoc.utils.stringify

local function meta_get(m, key)
  if not m[key] then return nil end
  return stringify(m[key])
end

local function html_escape(s)
  if not s then return nil end
  s = s:gsub("&","&amp;"):gsub("<","&lt;"):gsub(">","&gt;")
  s = s:gsub('"',"&quot;"):gsub("'","&#39;")
  return s
end

local function add_tag(tags, name, content)
  if content and content ~= "" then
    table.insert(tags, string.format('<meta name="%s" content="%s">', name, html_escape(content)))
  end
end

function Meta(m)
  local tags = {}

  -- core fields
  add_tag(tags, "citation_title", meta_get(m, "title"))
  -- authors (multiple)
  if m.author and type(m.author) == "table" then
    for _,a in ipairs(m.author) do
      if type(a) == "table" and a.name then
        add_tag(tags, "citation_author", stringify(a.name))
      else
        add_tag(tags, "citation_author", stringify(a))
      end
    end
  end
  add_tag(tags, "citation_publication_date", meta_get(m, "date"))
  add_tag(tags, "citation_journal_title", "JOSTA: Journal of Sustainable Technology in Agriculture")
  add_tag(tags, "citation_volume", meta_get(m, "volume"))
  add_tag(tags, "citation_issue", meta_get(m, "issue"))
  add_tag(tags, "citation_firstpage", meta_get(m, "firstpage"))
  add_tag(tags, "citation_lastpage", meta_get(m, "lastpage"))
  add_tag(tags, "citation_doi", meta_get(m, "doi"))
  add_tag(tags, "citation_fulltext_html_url", meta_get(m, "canonical_url") or meta_get(m, "url"))
  add_tag(tags, "citation_pdf_url", meta_get(m, "pdf_url"))

  -- canonical link
  local canonical = meta_get(m, "canonical_url")
  if canonical and canonical ~= "" then
    table.insert(tags, string.format('<link rel="canonical" href="%s">', html_escape(canonical)))
  end

  -- optional: dublin core (lightweight backup)
  add_tag(tags, "DC.Title", meta_get(m, "title"))
  add_tag(tags, "DC.Identifier", meta_get(m, "doi"))
  add_tag(tags, "DC.Type", "Text")
  add_tag(tags, "DC.Format", "text/html")
  add_tag(tags, "DC.Language", "en")

  -- schema.org JSON-LD (ScholarlyArticle)
  local authors = {}
  if m.author and type(m.author) == "table" then
    for _,a in ipairs(m.author) do
      local nm = (type(a)=="table" and a.name) and stringify(a.name) or stringify(a)
      table.insert(authors, string.format('{"@type":"Person","name":"%s"}', html_escape(nm)))
    end
  end
  local jsonld = string.format([[
<script type="application/ld+json">
{
  "@context":"https://schema.org",
  "@type":"ScholarlyArticle",
  "name":"%s",
  "author":[%s],
  "datePublished":"%s",
  "isPartOf":{"@type":"Periodical","name":"JOSTA: Journal of Sustainable Technology in Agriculture"%s},
  "identifier":"%s",
  "url":"%s",
  "sameAs":"https://doi.org/%s",
  "pagination":"%s-%s",
  "headline":"%s",
  "description":%s,
  "encoding":{"@type":"MediaObject","fileFormat":"application/pdf","contentUrl":"%s"}
}
</script>
]], html_escape(meta_get(m,"title") or ""),
    table.concat(authors, ","),
    html_escape(meta_get(m,"date") or ""),
    (m.issn and (', "issn": "'..html_escape(stringify(m.issn))..'"') or ""),
    html_escape(meta_get(m,"doi") or ""),
    html_escape(canonical or ""),
    html_escape(meta_get(m,"doi") or ""),
    html_escape(meta_get(m,"firstpage") or ""),
    html_escape(meta_get(m,"lastpage") or ""),
    html_escape(meta_get(m,"title") or ""),
    -- keep abstract as JSON string (quote & escape)
    pandoc.json.encode(meta_get(m,"abstract") or ""),
    html_escape(meta_get(m,"pdf_url") or "")
  )

  -- merge into header-includes
  local blocks = {
    pandoc.RawBlock("html", table.concat(tags, "\n")),
    pandoc.RawBlock("html", jsonld)
  }
  local existing = m["header-includes"]
  if existing then
    if existing.t == "MetaList" then
      for _,v in ipairs(blocks) do table.insert(existing, pandoc.MetaBlocks({v})) end
      m["header-includes"] = existing
    else
      m["header-includes"] = pandoc.MetaList({ existing, pandoc.MetaBlocks(blocks) })
    end
  else
    m["header-includes"] = pandoc.MetaList({ pandoc.MetaBlocks(blocks) })
  end
  return m
end
