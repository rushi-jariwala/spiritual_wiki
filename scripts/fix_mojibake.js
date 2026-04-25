const fs = require("node:fs")
const path = require("node:path")

const ROOT = path.resolve(__dirname, "..")
const INCLUDE_EXTENSIONS = new Set([
  ".md",
  ".ts",
  ".tsx",
  ".js",
  ".json",
  ".yml",
  ".yaml",
  ".scss",
  ".css",
  ".txt",
])

const SKIP_DIRS = new Set([
  ".git",
  ".claude",
  "node_modules",
  "public",
  ".quartz-cache",
  "raw",
])

const START_DIRS = [
  path.join(ROOT, "wiki"),
  path.join(ROOT, "site"),
  path.join(ROOT, "scripts"),
]

const CP1252_MAP = new Map([
  [0x20ac, 0x80],
  [0x201a, 0x82],
  [0x0192, 0x83],
  [0x201e, 0x84],
  [0x2026, 0x85],
  [0x2020, 0x86],
  [0x2021, 0x87],
  [0x02c6, 0x88],
  [0x2030, 0x89],
  [0x0160, 0x8a],
  [0x2039, 0x8b],
  [0x0152, 0x8c],
  [0x017d, 0x8e],
  [0x2018, 0x91],
  [0x2019, 0x92],
  [0x201c, 0x93],
  [0x201d, 0x94],
  [0x2022, 0x95],
  [0x2013, 0x96],
  [0x2014, 0x97],
  [0x02dc, 0x98],
  [0x2122, 0x99],
  [0x0161, 0x9a],
  [0x203a, 0x9b],
  [0x0153, 0x9c],
  [0x017e, 0x9e],
  [0x0178, 0x9f],
])

const TOKENS = ["Ã", "â", "Â", "Î", "ðŸ", "�"]

function suspiciousScore(text) {
  let count = 0
  for (const token of TOKENS) {
    let idx = -1
    while ((idx = text.indexOf(token, idx + 1)) !== -1) {
      count++
    }
  }
  return count
}

function encodeCp1252(text) {
  const bytes = []
  for (const ch of text) {
    const cp = ch.codePointAt(0)
    if (CP1252_MAP.has(cp)) {
      bytes.push(CP1252_MAP.get(cp))
      continue
    }

    if (cp <= 0xff) {
      bytes.push(cp)
      continue
    }

    return null
  }

  return Buffer.from(bytes)
}

function repairText(text) {
  let current = text

  for (let i = 0; i < 3; i++) {
    const encoded = encodeCp1252(current)
    if (!encoded) break

    const next = encoded.toString("utf8")
    if (suspiciousScore(next) < suspiciousScore(current)) {
      current = next
    } else {
      break
    }
  }

  return current
}

function visit(dir, files) {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    if (entry.isDirectory()) {
      if (!SKIP_DIRS.has(entry.name)) {
        visit(path.join(dir, entry.name), files)
      }
      continue
    }

    const ext = path.extname(entry.name).toLowerCase()
    if (INCLUDE_EXTENSIONS.has(ext)) {
      files.push(path.join(dir, entry.name))
    }
  }
}

const files = []
for (const dir of START_DIRS) {
  if (fs.existsSync(dir)) visit(dir, files)
}

let updated = 0
for (const file of files) {
  const original = fs.readFileSync(file, "utf8")
  if (suspiciousScore(original) === 0) continue

  const repaired = repairText(original)
  if (repaired !== original && suspiciousScore(repaired) < suspiciousScore(original)) {
    fs.writeFileSync(file, repaired, "utf8")
    updated++
    console.log(path.relative(ROOT, file))
  }
}

console.log(`updated=${updated}`)
