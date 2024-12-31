//
//  TCAStackBasedNavigationTests.swift
//  TCAStackBasedNavigationTests
//
//  Created by Pablo Guardiola on 30/12/24.
//

import ComposableArchitecture
import Testing
@testable import TCAStackBasedNavigation

struct TCAStackBasedNavigationTests {

    @Test func signInPath() async {
        let store = TestStore(initialState: MainMenu.State()) {
            MainMenu()
        }

        // when click sign in button
        await store.send(.signInTapped) {
            // then SignIn view is presented
            $0.path.append(.signIn(SignIn.State()))
        }
    }

    @Test func signUpPath() async {
        let store = TestStore(initialState: MainMenu.State()) {
            MainMenu()
        }

        // when click sign up button
        await store.send(.signUpTapped) {
            // then SignUp view is presented
            $0.path.append(.signUp(SignUp.State()))
        }

        // when click sign up button
        await store.send(.path(.element(
            id: StackElementID(integerLiteral: 0),
            action: .signUp(.signUpTapped)
        ))) {
            // then SignUpConfirmation view is presented
            $0.path.append(.signUpConfirmation(SignUpConfirmation.State()))
        }
    }

}
