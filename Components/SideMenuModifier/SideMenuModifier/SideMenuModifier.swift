import SwiftUI

extension SideMenuModifier {
    /*Parameters*/
    private var backgroundOpacity: CGFloat {
        0.6 // Background when side menu is showing (from transparent to black)
    }
}

/**
 Modifier that adds a side menu on top of a view

    - parameter showMenu: binding var that shows/hides the menu
    - parameter sideMenu: the view that will be shown as side menu
 */
struct SideMenuModifier<SideMenu: View>: ViewModifier {

    @Binding var showMenu: Bool
    let sideMenu: () -> SideMenu

    @State private var sideMenuWidth: CGFloat = 0
    @State private var sideMenuOffset: CGFloat = -1000
    @State private var isDragging: Bool = false

    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            content
                .frame(maxWidth: .infinity)

            // Background that shadows the background when the side menu appears
            // It can be tapped for closing the menu
            VStack {}
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.black.opacity((1.0 - (abs(sideMenuOffset) / abs(sideMenuWidth))) * backgroundOpacity))
                .allowsHitTesting(showMenu)
                .gesture(dragGesture())
                .onTapGesture {
                    showMenu = false
                }

            sideMenu()
                .onGeometryChange(for: CGSize.self) { proxy in
                    proxy.size
                } action: { newSize in
                    sideMenuWidth = newSize.width
                    withAnimation(nil) {
                        refreshOffset()
                    }
                }
                .gesture(dragGesture())
                .offset(x: sideMenuOffset)

            VStack {}
                .frame(width: 8)
                .frame(maxHeight: .infinity)
                .gesture(dragGesture())
        }
        .animation(isDragging ? nil : .spring, value: sideMenuOffset)
        .onChange(of: showMenu) { _, newValue in
            refreshOffset()
        }
    }

    private func dragGesture() -> some Gesture {
        DragGesture(coordinateSpace: .global)
            .onChanged { val in
                isDragging = true
                refreshOffset(offset: val.translation.width)
            }
            .onEnded { val in
                isDragging = false
                showMenu = val.velocity.width > 0
                refreshOffset()
            }
    }

    private func refreshOffset(offset: CGFloat = 0) {
        let newOffset = (showMenu ? 0 : -sideMenuWidth) + offset
        sideMenuOffset = min(0, max(newOffset, -sideMenuWidth))
    }
}

/**
 Extension to apply SideMenuModifier
 */
extension View {
    func sideMenu<SideMenu: View>(
        showMenu: Binding<Bool>,
        view: @escaping () -> SideMenu
    ) -> some View {
        self.modifier(
            SideMenuModifier(
                showMenu: showMenu,
                sideMenu: view
            )
        )
    }
}
