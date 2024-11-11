import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(EducaSwiftHexMacroPackageMacros)
import EducaSwiftHexMacroPackageMacros

let testMacros: [String: Macro.Type] = [
    "hexColor": HexColorMacro.self,
]
#endif

final class EducaSwiftHexMacroPackageTests: XCTestCase {
    func testMacro() throws {
        #if canImport(EducaSwiftHexMacroPackageMacros)
        assertMacroExpansion(
            """
            #hexColor("FFFF00FF")
            """,
            expandedSource: """
                Color(
                    .sRGB,
                    red: 1.0,
                    green: 1.0,
                    blue:  1.0,
                    opacity: 1.0
                )
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
