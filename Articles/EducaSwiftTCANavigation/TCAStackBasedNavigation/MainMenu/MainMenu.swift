import ComposableArchitecture
import SwiftUI

@Reducer
struct MainMenu {

    @ObservableState
    struct State: Equatable {
        var path = StackState<Path.State>()
    }

    enum Action: Equatable {
        case signInTapped
        case signUpTapped

        case path(StackActionOf<Path>)
    }

    @Reducer(state: .equatable, action: .equatable)
    enum Path {
        case signIn(SignIn)
        case signUp(SignUp)
        case signUpConfirmation(SignUpConfirmation)
    }

    var body: some ReducerOf<MainMenu> {
        Reduce { state, action in
            switch action {
            case .signInTapped:
                state.path.append(.signIn(SignIn.State()))
                return .none
            case .signUpTapped:
                state.path.append(.signUp(SignUp.State()))
                return .none

            // You can catch specific child actions like this
            case .path(.element(id: _, action: .signUp(.signUpTapped))):
                state.path.append(.signUpConfirmation(SignUpConfirmation.State()))
                return .none

            // The rest of the children action will trigger this
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

struct MainMenuView: View {
    @Binding var store: StoreOf<MainMenu>

    var body: some View {
        NavigationStack(
            path: $store.scope(state: \.path, action: \.path)
        ) {
            VStack {
                Spacer()
                title
                Spacer()
                actionButtons
                Spacer()
            }
            .padding(20)
        } destination: { store in
            switch store.case {
            case .signIn(let signInStore):
                SignInView(store: signInStore)
            case .signUp(let signUpStore):
                SignUpView(store: signUpStore)
            case .signUpConfirmation(let confirmationStore):
                SignUpConfirmationView(store: confirmationStore)
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
