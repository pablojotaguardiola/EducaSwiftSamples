import ComposableArchitecture
import SwiftUI

@Reducer
struct SignIn {
    @ObservableState
    struct State: Equatable {
        
    }

    enum Action: Equatable {

    }

    var body: some ReducerOf<SignIn> {
        Reduce { state, action in
            return .none
        }
    }
}

struct SignInView: View {
    let store: StoreOf<SignIn>

    var body: some View {
        Text("This is the Sign In screen")
            .font(.headline)
    }
}

#Preview {
    SignInView(store: Store(initialState: SignIn.State(), reducer: {
        SignIn()
    }))
}
