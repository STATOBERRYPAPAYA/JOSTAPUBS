-- scholar-meta.lua : emit Google Scholar/Highwire tags + canonical + JSON-LD

local stringify = pandoc.utils.stringify

-- safely get a metadata field as string
local function meta_get(m, key)
  if not m[key] then return nil end
  return stringify(m[key])
end

-- get the first non-empty metadata field from a list of keys
local function meta_first(m, keys)
  for _, key in ipairs(keys) do
    local v = meta_get(m, key)
    if v and v ~= "" then
      return v
    end
  end
  return nil
end

-- basic HTML escaping
local function html_escape(s)
  if not s then return nil end
  s = s:gsub("&","&amp;"):gsub("<","&lt;"):gsub(">","&gt;")
  s = s:gsub('"',"&quot;"):gsub("'","&#39;")
  return s
end

-- simple JSON string escape (for description/abstract)
local function json_escape_string(s)
  if not s then s = "" end
  -- escape backslashes and quotes
  s = s:gsub("\\", "\\\\"):gsub('"', '\\"')
  -- normalise newlines
  s = s:gsub("\r\n", "\n"):gsub("\n", "\\n")
  return '"' .. s .. '"'
end

-- add a <meta> tag if content is non-empty
local function add_tag(tags, name, content)
  if content and content ~= "" then
    table.insert(tags, string.format(
      '<meta name="%s" content="%s">', name, html_escape(content)
    ))
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

  -- try "Month D, YYYY" (e.g. "November 8, 2025")
  local month_name, day, year = date_str:match("^(%a+)%s+(%d+),%s+(%d%d%d%d)$")
  if month_name and day and year then
    local months = {
      January = "01", February = "02", March = "03", April = "04",
      May = "05", June = "06", July = "07", August = "08",
      September = "09", October = "10", November = "11", December = "12"
    }
    local mm = months[month_name]
    if mm then
      local dd = string.format("%02d", tonumber(day))
      return string.format("%s/%s/%s", year, mm, dd)
    end
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

  ---------------------------------------------------------------------------
  -- journal-level defaults (from _quarto.yml metadata or hard-coded fallback)
  ---------------------------------------------------------------------------
  local journal_title = meta_get(m, "journal_title")
    or "JOSTA: Journal of Sustainable Technology in Agriculture"

  local issn = meta_get(m, "issn") or "3107-6882"
  local lang = meta_get(m, "lang") or "en"

  ---------------------------------------------------------------------------
  -- core fields
  ---------------------------------------------------------------------------
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

  -- pages (if available – you can add firstpage/lastpage later)
  local firstpage = meta_get(m, "firstpage")
  local lastpage  = meta_get(m, "lastpage")
  add_tag(tags, "citation_firstpage", firstpage)
  add_tag(tags, "citation_lastpage", lastpage)

  ---------------------------------------------------------------------------
  -- identifiers and URLs
  ---------------------------------------------------------------------------
  local doi = meta_get(m, "doi")
  local canonical = meta_first(m, { "canonical-url", "canonical_url", "url" })
  local pdf_url   = meta_first(m, { "pdf-url", "pdf_url" })

  add_tag(tags, "citation_doi", doi)
  add_tag(tags, "citation_fulltext_html_url", canonical)
  add_tag(tags, "citation_pdf_url", pdf_url)

  -- canonical link
  if canonical and canonical ~= "" then
    table.insert(tags, string.format(
      '<link rel="canonical" href="%s">', html_escape(canonical)
    ))
  end

  ---------------------------------------------------------------------------
  -- Dublin Core backup
  ---------------------------------------------------------------------------
  add_tag(tags, "DC.Title", title)
  add_tag(tags, "DC.Identifier", doi or canonical)
  add_tag(tags, "DC.Type", "Text")
  add_tag(tags, "DC.Format", "text/html")
  add_tag(tags, "DC.Language", lang)

  ---------------------------------------------------------------------------
  -- JSON-LD (schema.org/ScholarlyArticle)
  ---------------------------------------------------------------------------

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
        table.insert(authors, string.format(
          '{"@type":"Person","name":"%s"}', html_escape(nm)
        ))
      end
    end
  end
  local authors_json = table.concat(authors, ",")

  -- pagination string for JSON-LD
  local pagination = ""
  if firstpage and firstpage ~= "" and lastpage and lastpage ~= "" then
    pagination = firstpage .. "-" .. lastpage
  elseif firstpage and firstpage ~= "" then
    pagination = firstpage
  end

  -- abstract / description (use article abstract; your YAML already has it)
  local abstract = meta_get(m, "abstract") or ""
  local abstract_json = json_escape_string(abstract)

  -- sameAs for DOI if present
  local same_as_line = ""
  if doi and doi ~= "" then
    same_as_line = string.format(
      ',\n  "sameAs":"https://doi.org/%s"',
      html_escape(doi)
    )
  end

  -- encoding block only if we have a PDF URL
  local encoding_block = ""
  if pdf_url and pdf_url ~= "" then
    encoding_block = string.format([[
,
  "encoding":{
    "@type":"MediaObject",
    "fileFormat":"application/pdf",
    "contentUrl":"%s"
  }]], html_escape(pdf_url))
  end

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
  "url":"%s"%s,
  "pagination":"%s",
  "headline":"%s",
  "description":%s%s
}
</script>
]],
    html_escape(title or ""),
    authors_json,
    html_escape(pub_date or raw_date or ""),

    html_escape(journal_title),
    html_escape(issn or ""),

    html_escape(doi or ""),
    html_escape(canonical or ""),

    same_as_line,

    html_escape(pagination or ""),
    html_escape(title or ""),
    abstract_json,
    encoding_block
  )

  ---------------------------------------------------------------------------
  -- merge into header-includes
  ---------------------------------------------------------------------------

  local blocks = {
    pandoc.RawBlock("html", table.concat(tags, "\n")),
    pandoc.RawBlock("html", jsonld)
  }

  -- ensure header-includes is a MetaList
  local hi = m["header-includes"]
  if not hi then
    hi = pandoc.MetaList({})
  elseif hi.t ~= "MetaList" then
    hi = pandoc.MetaList({ hi })
  end

  table.insert(hi, pandoc.MetaBlocks(blocks))
  m["header-includes"] = hi

  return m
end
