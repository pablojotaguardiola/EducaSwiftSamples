import SwiftUI

struct ContentView: View {

    var posts: [Post] = [
        Post(
            user: User(name: "Valeria", imageName: "user-1"),
            date: "Nov 9th",
            text: "Last night I went to a party and had a great time.",
            imageName: "party"
        ),
        Post(
            user: User(name: "Sofía", imageName: "user-2"),
            date: "Nov 5th",
            text: "Had a great day with family, full of laughter, good food, and wonderful memories.",
            imageName: "family"
        ),
        Post(
            user: User(name: "Alejandro", imageName: "user-3"),
            date: "Nov 1st",
            text: "Enjoyed an amazing day in nature, surrounded by fresh air and tranquility.",
            imageName: "nature"
        )
    ]

    @State var selectedImageName: String = ""
    @State var showImageViewer: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(0..<posts.count, id: \.self) { postIndex in
                    post(i: postIndex)
                }
            }
        }
        .sheet(isPresented: $showImageViewer, content: { [selectedImageName] in
            ImageViewerScreen(imageName: selectedImageName)
        })
    }

    func post(i: Int) -> some View {
        VStack {
            HStack {
                NavigationLink {
                    UserProfileScreen(user: posts[i].user)
                } label: {
                    HStack {
                        Image(posts[i].user.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 32, height: 32)
                            .cornerRadius(16)
                            .clipped()

                        Text(posts[i].user.name)
                            .font(.headline)
                    }
                }

                Spacer()

                Text(posts[i].date)
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }

            Text(posts[i].text)

            Button(action: {
                selectedImageName = posts[i].imageName
                showImageViewer = true
            }, label: {
                Image(posts[i].imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .cornerRadius(20)
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
