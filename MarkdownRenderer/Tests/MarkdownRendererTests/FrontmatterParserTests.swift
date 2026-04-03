import Testing
@testable import MarkdownRenderer

@Suite struct FrontmatterParserTests {
    @Test func noFrontmatter() {
        let result = FrontmatterParser.parse("# Hello\nWorld")
        #expect(result.fields.isEmpty)
        #expect(result.body == "# Hello\nWorld")
    }

    @Test func emptyFrontmatter() {
        let result = FrontmatterParser.parse("---\n---\n# Hello")
        #expect(result.fields.isEmpty)
        #expect(result.body == "# Hello")
    }

    @Test func simpleKeyValue() {
        let result = FrontmatterParser.parse("---\ntitle: Hello\n---\nBody")
        #expect(result.fields.count == 1)
        #expect(result.fields[0].key == "title")
        #expect(result.fields[0].value == "Hello")
        #expect(result.body == "Body")
    }

    @Test func multipleFields() {
        let md = "---\ntitle: Test\nauthor: Alice\ndate: 2024-01-01\n---\nBody"
        let result = FrontmatterParser.parse(md)
        #expect(result.fields.count == 3)
        #expect(result.fields[0].key == "title")
        #expect(result.fields[1].key == "author")
        #expect(result.fields[2].key == "date")
    }

    @Test func quotedValues() {
        let md = "---\ntitle: \"Hello World\"\nname: 'Alice'\n---\nBody"
        let result = FrontmatterParser.parse(md)
        #expect(result.fields[0].value == "Hello World")
        #expect(result.fields[1].value == "Alice")
    }

    @Test func inlineArray() {
        let md = "---\ntags: [foo, bar, baz]\n---\nBody"
        let result = FrontmatterParser.parse(md)
        #expect(result.fields[0].value == "foo, bar, baz")
    }

    @Test func blockSequence() {
        let md = "---\ntags:\n  - one\n  - two\n  - three\n---\nBody"
        let result = FrontmatterParser.parse(md)
        #expect(result.fields[0].key == "tags")
        #expect(result.fields[0].value == "one, two, three")
    }

    @Test func foldedBlockScalar() {
        let md = "---\ndesc: >\n  first line\n  second line\n---\nBody"
        let result = FrontmatterParser.parse(md)
        #expect(result.fields[0].value == "first line second line")
    }

    @Test func literalBlockScalar() {
        let md = "---\ndesc: |\n  first line\n  second line\n---\nBody"
        let result = FrontmatterParser.parse(md)
        #expect(result.fields[0].value == "first line\nsecond line")
    }

    @Test func commentsSkipped() {
        let md = "---\n# comment\ntitle: Test\n---\nBody"
        let result = FrontmatterParser.parse(md)
        #expect(result.fields.count == 1)
        #expect(result.fields[0].key == "title")
    }

    @Test func dotsClosingDelimiter() {
        let md = "---\ntitle: Test\n...\nBody"
        let result = FrontmatterParser.parse(md)
        #expect(result.fields.count == 1)
        #expect(result.body == "Body")
    }

    @Test func noClosingDelimiter() {
        let md = "---\ntitle: Test\nBody without closing"
        let result = FrontmatterParser.parse(md)
        #expect(result.fields.isEmpty)
        #expect(result.body == md)
    }

    @Test func bodyPreservedWithLeadingNewlines() {
        let md = "---\ntitle: Test\n---\n\n\nBody"
        let result = FrontmatterParser.parse(md)
        #expect(result.body == "Body")
    }
}
