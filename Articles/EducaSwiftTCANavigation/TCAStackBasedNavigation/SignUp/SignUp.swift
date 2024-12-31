import ComposableArchitecture
import SwiftUI

@Reducer
struct SignUp {
    @ObservableState
    struct State: Equatable {

    }

    enum Action: Equatable {
        case signUpTapped
    }

    var body: some ReducerOf<SignUp> {
        Reduce { state, action in
            switch action {
            case .signUpTapped:
                // Manage in Main Menu
                return .none
            }
        }
    }
}

struct SignUpView: View {
    let store: StoreOf<SignUp>

    var body: some View {
        VStack {
            Spacer()
            Text("This is the Sign Up screen")
                .font(.headline)
            Spacer()
            Button(action: {
                store.send(.signUpTapped)
            }, label: {
                Text("Sign Up")
                    .foregroundStyle(.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            })
            Spacer()
        }
        .padding(20)
    }
}

#Preview {
    SignUpView(store: Store(initialState: SignUp.State(), reducer: {
        SignUp()
    }))
}
