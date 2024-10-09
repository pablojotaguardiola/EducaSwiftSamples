import SwiftUI

struct ImageViewerScreen: View {

    let imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
