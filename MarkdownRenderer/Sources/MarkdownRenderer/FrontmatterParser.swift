import Foundation

public struct Frontmatter {
    public let fields: [(key: String, value: String)]
    public let body: String
}

public enum FrontmatterParser {
    public static func parse(_ markdown: String) -> Frontmatter {
        let lines = markdown.components(separatedBy: "\n")

        // Must start with exactly "---"
        guard lines.first?.trimmingCharacters(in: .whitespaces) == "---" else {
            return Frontmatter(fields: [], body: markdown)
        }

        // Find closing delimiter (--- or ...)
        guard let closeIndex = lines.dropFirst().firstIndex(where: {
            let t = $0.trimmingCharacters(in: .whitespaces)
            return t == "---" || t == "..."
        }) else {
            return Frontmatter(fields: [], body: markdown)
        }

        let yamlLines = Array(lines[1..<closeIndex])
        let bodyLines = Array(lines[(closeIndex + 1)...])
        let body = bodyLines.joined(separator: "\n")
            .trimmingCharacters(in: .newlines)

        let fields = parseFields(yamlLines)
        return Frontmatter(fields: fields, body: body)
    }

    private static func parseFields(_ lines: [String]) -> [(key: String, value: String)] {
        var fields: [(key: String, value: String)] = []
        var i = 0
        while i < lines.count {
            let line = lines[i]
            // Skip empty lines and comments
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            guard !trimmed.isEmpty, !trimmed.hasPrefix("#") else { i += 1; continue }

            guard let colonIdx = line.firstIndex(of: ":") else { i += 1; continue }
            let key = line[line.startIndex..<colonIdx]
                .trimmingCharacters(in: .whitespaces)
            let rawValue = line[line.index(after: colonIdx)...]
                .trimmingCharacters(in: .whitespaces)

            if rawValue.isEmpty {
                // Possibly a block sequence: gather "  - item" lines
                var items: [String] = []
                var j = i + 1
                while j < lines.count {
                    let next = lines[j]
                    let nextTrimmed = next.trimmingCharacters(in: .whitespaces)
                    if nextTrimmed.hasPrefix("- ") {
                        items.append(String(nextTrimmed.dropFirst(2)))
                        j += 1
                    } else {
                        break
                    }
                }
                if !items.isEmpty {
                    fields.append((key: key, value: items.joined(separator: ", ")))
                    i = j
                    continue
                }
            }

            fields.append((key: key, value: normaliseValue(rawValue)))
            i += 1
        }
        return fields
    }

    // Strip quotes, unwrap inline arrays [a, b, c]
    private static func normaliseValue(_ raw: String) -> String {
        var s = raw
        // Quoted string
        if (s.hasPrefix("\"") && s.hasSuffix("\"")) ||
           (s.hasPrefix("'") && s.hasSuffix("'")) {
            s = String(s.dropFirst().dropLast())
            return s
        }
        // Inline array
        if s.hasPrefix("[") && s.hasSuffix("]") {
            let inner = String(s.dropFirst().dropLast())
            let items = inner.components(separatedBy: ",").map {
                $0.trimmingCharacters(in: .whitespaces)
                 .trimmingCharacters(in: CharacterSet(charactersIn: "\"'"))
            }
            return items.joined(separator: ", ")
        }
        return s
    }
}
