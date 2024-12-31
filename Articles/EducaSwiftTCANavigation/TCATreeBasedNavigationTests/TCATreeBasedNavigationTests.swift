//
//  TCATreeBasedNavigationTests.swift
//  TCATreeBasedNavigationTests
//
//  Created by Pablo Guardiola on 30/12/24.
//

import ComposableArchitecture
import Testing
@testable import TCATreeBasedNavigation

struct TCATreeBasedNavigationTests {

    @Test func mainMenuNavigation() async {
        let store = TestStore(initialState: MainMenu.State()) {
            MainMenu()
        }

        // when click sign in button
        await store.send(.signInTapped) {
            // then SignIn view is presented
            $0.destination = .signIn(SignIn.State())
        }

        // when click sign up button
        await store.send(.signUpTapped) {
            // then SignUp view is presented
            $0.destination = .signUp(SignUp.State())
        }
    }

    @Test func signUpNavigation() async {
        let store = TestStore(initialState: SignUp.State()) {
            SignUp()
        }

        // when click sign in button
        await store.send(.signUpTapped) {
            // then Sign In view is presented
            $0.destination = .confirmation(SignUpConfirmation.State())
        }
    }
}
