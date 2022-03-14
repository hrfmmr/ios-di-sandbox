//
//  Copyright (c) 2018. Uber Technologies
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Alpha
import Combine
import Core
import Foundation
import NeedleFoundation
import UIKit

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Registration

public func registerProviderFactories() {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->FeatureAlphaComponent") { component in
        return FeatureAlphaDependencyc654d9c0e52ec46d8635Provider(component: component)
    }
    
}

// MARK: - Providers

private class FeatureAlphaDependencyc654d9c0e52ec46d8635BaseProvider: FeatureAlphaDependency {
    var fooRepository: FooRepository {
        return rootComponent.fooRepository
    }
    var bravoFooBuilder: BravoFooBuildable {
        return rootComponent.bravoFooBuilder
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->FeatureAlphaComponent
private class FeatureAlphaDependencyc654d9c0e52ec46d8635Provider: FeatureAlphaDependencyc654d9c0e52ec46d8635BaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init(rootComponent: component.parent as! RootComponent)
    }
}
