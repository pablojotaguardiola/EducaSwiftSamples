import ComposableArchitecture
import SwiftUI

@Reducer
struct SignUp {
    @ObservableState
    struct State: Equatable {
        @Presents var destination: Destination.State?
    }

    enum Action: Equatable {
        case signUpTapped

        case destination(PresentationAction<Destination.Action>)
    }

    @Reducer(state: .equatable, action: .equatable)
    enum Destination {
        case confirmation(SignUpConfirmation)
    }

    var body: some ReducerOf<SignUp> {
        Reduce { state, action in
            switch action {
            case .signUpTapped:
                state.destination = .confirmation(SignUpConfirmation.State())
                return .none

            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

struct SignUpView: View {
    @Binding var store: StoreOf<SignUp>

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
        .navigationDestination(
            item: $store.scope(
                state: \.destination?.confirmation,
                action: \.destination.confirmation
            )
        ) { store in
            SignUpConfirmationView(store: store)
        }
    }
}

#Preview {
    SignUpView(store: .constant(Store(initialState: SignUp.State(), reducer: {
        SignUp()
    })))
}
