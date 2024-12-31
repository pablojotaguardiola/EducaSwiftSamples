import ComposableArchitecture
import SwiftUI

@Reducer
struct MainMenu {

    @ObservableState
    struct State: Equatable {
        @Presents var destination: Destination.State?
    }

    enum Action: Equatable {
        case signInTapped
        case signUpTapped

        case destination(PresentationAction<Destination.Action>)
    }

    @Reducer(state: .equatable, action: .equatable)
    enum Destination {
        case signIn(SignIn)
        case signUp(SignUp)
    }

    var body: some ReducerOf<MainMenu> {
        Reduce { state, action in
            switch action {
            case .signInTapped:
                state.destination = .signIn(SignIn.State())
                return .none
            case .signUpTapped:
                state.destination = .signUp(SignUp.State())
                return .none

            // You can catch specific child actions like this
            case .destination(.presented(.signUp(.signUpTapped))):
                return .none
            // The rest of the children action will trigger this
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

struct MainMenuView: View {
    @Binding var store: StoreOf<MainMenu>

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                title
                Spacer()
                actionButtons
                Spacer()
            }
            .padding(20)
            .navigationDestination(
                item: $store.scope(
                    state: \.destination?.signIn,
                    action: \.destination.signIn
                )
            ) { store in
                SignInView(store: store)
            }
            .navigationDestination(
                item: $store.scope(
                    state: \.destination?.signUp,
                    action: \.destination.signUp
                )
            ) { store in
                SignUpView(store: store)
            }
        }
    }

    var title: some View {
        Text("EducaSwift")
            .font(.largeTitle)
    }

    var actionButtons: some View {
        VStack {
            Button(action: {
                store.send(.signInTapped)
            }, label: {
                Text("Sign In")
            })
            .buttonStyle(MainMenuButtonStyle(color: .blue))

            Button(action: {
                store.send(.signUpTapped)
            }, label: {
                Text("Sign Up")
            })
            .buttonStyle(MainMenuButtonStyle(color: .purple))
        }
    }
}

struct MainMenuButtonStyle: ButtonStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    MainMenuView(store: .constant(Store(initialState: MainMenu.State(), reducer: {
        MainMenu()
    })))
}
