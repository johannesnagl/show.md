import Foundation

// Bundled versions:
//   highlight.js  11.11.1  (cdnjs)
//   KaTeX JS      0.16.45  (jsdelivr)
//   KaTeX CSS     0.16.9   (base64 fonts, intentionally pinned — see note below)
//   auto-render   0.16.45  (jsdelivr)
//   mermaid       11.14.0  (jsdelivr)
enum ResourceLoader {
    static func load(_ filename: String) -> String {
        guard let url = Bundle.module.url(forResource: filename, withExtension: nil, subdirectory: "Resources"),
              let data = try? Data(contentsOf: url),
              let content = String(data: data, encoding: .utf8) else {
            return ""
        }
        return content
    }

    // Cached resource contents — loaded once, reused across renders.
    static let highlightJS = load("highlight.min.js")
    static let highlightLightCSS = load("github.min.css")
    static let highlightDarkCSS = load("github-dark.min.css")
    static let katexJS = load("katex.min.js")
    // KaTeX CSS is intentionally kept at 0.16.9 (not matched to JS 0.16.45)
    // because 0.16.9 has base64-inlined fonts. Newer CSS versions reference
    // external .woff2 files that won't load in our sandboxed WKWebView.
    static let katexCSS = load("katex.min.css")
    static let autoRenderJS = load("auto-render.min.js")
    static let mermaidJS = load("mermaid.min.js")
}
