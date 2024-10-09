import SwiftUI

struct UserProfileScreen: View {

    let user: User

    var body: some View {
        VStack {
            Image(user.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .cornerRadius(50)
            Text(user.name)
                .font(.title)
        }
    }
}
