//
//  RecipeListCoordinator.swift
//  CookBook
//
//  Created by Osama Bashir on 10/12/20.
//

import UIKit

protocol RecipeListCoordinatorDependencies {
    func makeRecipeListViewController(actions: RecipeListViewModelAction) -> RecipeListViewController
    func makeRecipeDetailViewController(recipe: Recipe) -> RecipeDetailViewController
}

final class RecipeListCoordinator: BaseCoordinator {
    
    let dependencies: RecipeListCoordinatorDependencies
    private weak var navigation: UINavigationController?
    
    private weak var recipeListVC: RecipeListViewController?
    
    init(dependencies: RecipeListCoordinatorDependencies, navigation: AppNavigation) {
        self.dependencies = dependencies
        self.navigation = navigation
    }
    
    func start() {
        let actions = RecipeListViewModelAction(showDetails: showDetailsViewController)
        let vc = dependencies.makeRecipeListViewController(actions: actions)
        navigation?.pushViewController(vc, animated: true)
        recipeListVC = vc
    }
    
    private func showDetailsViewController(recipe: Recipe) {
        let detailVC = dependencies.makeRecipeDetailViewController(recipe: recipe)
        navigation?.pushViewController(detailVC, animated: true)
    }
}
