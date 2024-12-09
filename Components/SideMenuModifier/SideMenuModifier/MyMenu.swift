import SwiftUI

struct MyMenu: View {
    var body: some View {
        VStack {
            Image("profile")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())

            Text("Andrea")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)

            Text("iOS Developer")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black.opacity(0.5))

            Spacer()

            row(systemImage: "house", title: "Home", isSelected: true)
            row(systemImage: "magnifyingglass", title: "Search", isSelected: false)
            row(systemImage: "app.badge", title: "Notifications", isSelected: false)
            row(systemImage: "gearshape", title: "Settings", isSelected: false)

            Spacer()
        }
        .padding(.top, 64)
        .frame(maxHeight: .infinity)
        .background(.white)
    }

    func row(systemImage: String, title: String, isSelected: Bool) -> some View {
        HStack(spacing: 20) {
            Image(systemName: systemImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24)

            Text(title)
                .font(.headline)
            Spacer()
        }
        .foregroundStyle(isSelected ? .black : .gray)
        .frame(width: 250)
        .padding()
        .background(isSelected ? LinearGradient(gradient: .init(colors: [.purple, .white]), startPoint: .leading, endPoint: .trailing) : nil)
    }
}
