import ComposableArchitecture
import SwiftUI

@Reducer
struct SignUpConfirmation {
    @ObservableState
    struct State: Equatable {

    }

    enum Action: Equatable {

    }

    var body: some ReducerOf<SignUpConfirmation> {
        Reduce { state, action in
            return .none
        }
    }
}

struct SignUpConfirmationView: View {
    let store: StoreOf<SignUpConfirmation>

    var body: some View {
        Text("This is the confirmation screen")
            .font(.headline)
    }
}

#Preview {
    SignUpConfirmationView(store: Store(initialState: SignUpConfirmation.State(), reducer: {
        SignUpConfirmation()
    }))
}
