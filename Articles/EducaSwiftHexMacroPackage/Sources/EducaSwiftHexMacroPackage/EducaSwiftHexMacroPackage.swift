import SwiftUI

// The Swift Programming Language
// https://docs.swift.org/swift-book

/// A macro that produces a Color from an hex value. For example,
///
///     #hexColor("FF00FF") // or FFFF00FF to include alpha value
///
/// produces a `Color`.
@freestanding(expression)
public macro hexColor(_ hex: String) -> Color = #externalMacro(module: "EducaSwiftHexMacroPackageMacros", type: "HexColorMacro")
