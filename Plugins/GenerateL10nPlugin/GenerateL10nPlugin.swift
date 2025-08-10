//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import PackagePlugin
import Foundation

@main
struct GenerateL10nPlugin: CommandPlugin {
    let tab = "    "

    func performCommand(context: PluginContext, arguments: [String]) async throws {
        let packageRoot = context.package.directoryURL
        let xcstringsPath = packageRoot.appending(path: "Sources/BadaLocalization/Resources/Localizable.xcstrings")
        let outputPath = packageRoot.appending(path: "Sources/BadaLocalization/L10n.swift")

        guard let data = FileManager.default.contents(atPath: xcstringsPath.path()) else {
            Diagnostics.error("Localizable.xcstrings not found at \(xcstringsPath)")
            return
        }

        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
              let strings = json["strings"] as? [String: Any] else {
            Diagnostics.error("Failed to parse Localizable.xcstrings JSON")
            return
        }

        Diagnostics.progress("Generating L10n.swift...")

        var englishValues: [String: String] = [:]
        for (key, value) in strings {
            if let dictionary = value as? [String: Any],
               let localizations = dictionary["localizations"] as? [String: Any],
               let en = localizations["en"] as? [String: Any],
               let stringUnit = en["stringUnit"] as? [String: Any],
               let englishValue = stringUnit["value"] as? String {
                englishValues[key] = englishValue
            }
        }

        func insert(into dict: inout [String: Any], path: [String], value: String) {
            guard let first = path.first else { return }
            if path.count == 1 {
                dict[first] = value
            } else {
                var subdict = dict[first] as? [String: Any] ?? [:]
                insert(
                    into: &subdict,
                    path: Array(path.dropFirst()),
                    value: value)
                dict[first] = subdict
            }
        }

        var tree: [String: Any] = [:]
        for key in strings.keys.sorted() {
            insert(
                into: &tree,
                path: key.split(separator: ".").map(String.init),
                value: key)
        }

        var output = """
        //
        //  L10n.swift
        //  Auto-generated from Localizable.xcstrings
        //
        //  Badabook
        //  Apache License, Version 2.0
        //
        //  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
        //
        //  🚫 DO NOT EDIT MANUALLY
        //

        package enum L10n {
        """

        func writeEnum(name: String, content: Any, indent: String) {
            if let key = content as? String {
                let comment = englishValues[key] ?? key
                output += "\n\(indent)/// \(comment)"
                output += "\n\(indent)package static let \(camelCase(name)) = String(localized: \"\(key)\", bundle: .module)"
            } else if let dict = content as? [String: Any] {
                output += "\n\(indent)package enum \(pascalCase(name)) {"
                for sub in dict.keys.sorted() {
                    writeEnum(
                        name: sub,
                        content: dict[sub]!,
                        indent: indent + tab
                    )
                }
                output += "\n\(indent)}"
            }
        }

        func camelCase(_ key: String) -> String {
            let parts = key.split(separator: "_").map { $0.lowercased() }
            return ([parts.first!] + parts.dropFirst().map { $0.capitalized }).joined()
        }

        func pascalCase(_ key: String) -> String {
            return key.split(separator: "_").map { $0.capitalized }.joined()
        }

        for section in tree.keys.sorted() {
            writeEnum(
                name: section,
                content: tree[section]!,
                indent: tab
            )
        }
        output += "\n}\n"

        try output.write(to: outputPath, atomically: true, encoding: .utf8)
        Diagnostics.progress("✅ L10n.swift generated at \(outputPath.path())")
    }
}
