import Foundation

public struct Settings {
    public static var userDefaults: UserDefaults = UserDefaults(suiteName: "group.io.github.show-md")
        ?? UserDefaults.standard

    public enum Tab: String, CaseIterable {
        case rendered, source
    }

    public enum Theme: String, CaseIterable {
        case auto, light, dark
    }

    public enum FontSize: String, CaseIterable {
        case small, medium, large

        public var cssValue: String {
            switch self {
            case .small:  return "13px"
            case .medium: return "15px"
            case .large:  return "17px"
            }
        }
    }

    public static var defaultTab: Tab {
        get { Tab(rawValue: userDefaults.string(forKey: "defaultTab") ?? "") ?? .rendered }
        set { userDefaults.set(newValue.rawValue, forKey: "defaultTab") }
    }

    public static var theme: Theme {
        get { Theme(rawValue: userDefaults.string(forKey: "theme") ?? "") ?? .auto }
        set { userDefaults.set(newValue.rawValue, forKey: "theme") }
    }

    public static var fontSize: FontSize {
        get { FontSize(rawValue: userDefaults.string(forKey: "fontSize") ?? "") ?? .medium }
        set { userDefaults.set(newValue.rawValue, forKey: "fontSize") }
    }

    public static var mermaidEnabled: Bool {
        get { userDefaults.object(forKey: "mermaidEnabled") as? Bool ?? false }
        set { userDefaults.set(newValue, forKey: "mermaidEnabled") }
    }
}
