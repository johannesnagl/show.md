import Testing
import Foundation
@testable import MarkdownRenderer

private let testSuiteName = "test.settings"

@Suite(.serialized) struct SettingsTests {
    init() {
        Settings.userDefaults = UserDefaults(suiteName: testSuiteName)!
        Settings.userDefaults.removePersistentDomain(forName: testSuiteName)
    }

    @Test func defaultTabDefaultsToRendered() {
        #expect(Settings.defaultTab == .rendered)
    }

    @Test func defaultTabRoundTrips() {
        Settings.defaultTab = .source
        #expect(Settings.defaultTab == .source)
    }

    @Test func themeDefaultsToAuto() {
        #expect(Settings.theme == .auto)
    }

    @Test func themeRoundTrips() {
        Settings.theme = .dark
        #expect(Settings.theme == .dark)
    }

    @Test func fontSizeDefaultsToMedium() {
        #expect(Settings.fontSize == .medium)
    }

    @Test func fontSizeRoundTrips() {
        Settings.fontSize = .large
        #expect(Settings.fontSize == .large)
    }

    @Test func fontSizeCSSValues() {
        #expect(Settings.FontSize.small.cssValue == "13px")
        #expect(Settings.FontSize.medium.cssValue == "15px")
        #expect(Settings.FontSize.large.cssValue == "17px")
    }

    @Test func unknownRawValueFallsBackToDefault() {
        Settings.userDefaults.set("garbage", forKey: "defaultTab")
        #expect(Settings.defaultTab == .rendered)
    }
}
