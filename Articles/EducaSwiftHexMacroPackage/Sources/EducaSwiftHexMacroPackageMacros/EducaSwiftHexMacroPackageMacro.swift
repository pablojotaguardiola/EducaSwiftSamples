import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftUI

public enum HexColorMacroError: Error {

    case inputNotValid
    case lengthNotValid

    var description: String {
        switch self {
        case .inputNotValid:
            return "Input is not valid."
        case .lengthNotValid:
            return "Length not valid."
        }
    }
}

/// Implementation of the `hexColor` macro, which takes an String
/// and produces a Color with rgba values. For example
///
///     #hexColor("FFFF00FF") // a-r-g-b
///
///  will expand to
///
///     Color(
///         .sRGB,
///         red: 1.0,
///         green: 0.0,
///         blue:  1.0,
///         opacity: 1.0
///     )
public struct HexColorMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard let argument = node.arguments.first?.expression,
              let segments = argument.as(StringLiteralExprSyntax.self)?.segments,
              segments.count == 1,
              case .stringSegment(let literalSegment)? = segments.first
        else {
            throw HexColorMacroError.inputNotValid
        }

        guard literalSegment.content.text.count == 6 || literalSegment.content.text.count == 8 else {
            throw HexColorMacroError.lengthNotValid
        }

        let hex = literalSegment.content.text.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        return """
            Color(
                .sRGB,
                red: \(raw: Double(r) / 255),
                green: \(raw: Double(g) / 255),
                blue:  \(raw: Double(b) / 255),
                opacity: \(raw: Double(a) / 255)
            )
        """
    }
}

@main
struct EducaSwiftHexMacroPackagePlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        HexColorMacro.self,
    ]
}
