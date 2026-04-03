import Testing
@testable import MarkdownRenderer

@Suite struct ResourceLoaderTests {
    @Test func highlightJSLoaded() {
        #expect(!ResourceLoader.highlightJS.isEmpty)
    }

    @Test func highlightLightCSSLoaded() {
        #expect(!ResourceLoader.highlightLightCSS.isEmpty)
    }

    @Test func highlightDarkCSSLoaded() {
        #expect(!ResourceLoader.highlightDarkCSS.isEmpty)
    }

    @Test func katexJSLoaded() {
        #expect(!ResourceLoader.katexJS.isEmpty)
    }

    @Test func katexCSSLoaded() {
        #expect(!ResourceLoader.katexCSS.isEmpty)
    }

    @Test func autoRenderJSLoaded() {
        #expect(!ResourceLoader.autoRenderJS.isEmpty)
    }

    @Test func mermaidJSLoaded() {
        #expect(!ResourceLoader.mermaidJS.isEmpty)
    }
}
