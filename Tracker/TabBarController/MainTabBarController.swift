import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupTabs()
    }

    private func setupAppearance() {
        let mainBlue = UIColor(named: "mainBlue") ?? .systemBlue
        let mainGray = UIColor(named: "mainGray") ?? .systemGray

        tabBar.tintColor = mainBlue
        tabBar.unselectedItemTintColor = mainGray

        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemBackground

            applyColors(to: appearance, selectedColor: mainBlue, normalColor: mainGray)

            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
    }

    private func setupTabs() {
        let navControllers = Tab.allCases.map { tab -> UINavigationController in
            let nav = UINavigationController(rootViewController: tab.viewController)
            nav.navigationBar.prefersLargeTitles = true

            let image = UIImage(named: tab.imageName)?.withRenderingMode(.alwaysTemplate)
            
            nav.tabBarItem = UITabBarItem(title: tab.title, image: image, selectedImage: image)
            return nav
        }

        viewControllers = navControllers
    }

    private func applyColors(to appearance: UITabBarAppearance, selectedColor: UIColor, normalColor: UIColor) {
        let appearances = [
            appearance.stackedLayoutAppearance,
            appearance.inlineLayoutAppearance,
            appearance.compactInlineLayoutAppearance
        ]

        appearances.forEach { itemAppearance in
            itemAppearance.normal.iconColor = normalColor
            itemAppearance.normal.titleTextAttributes = [.foregroundColor: normalColor]
            itemAppearance.selected.iconColor = selectedColor
            itemAppearance.selected.titleTextAttributes = [.foregroundColor: selectedColor]
        }
    }
}

private extension MainTabBarController {
    enum Tab: CaseIterable {
        case trackers
        case statistics

        var title: String {
            switch self {
            case .trackers: return "Трекеры"
            case .statistics: return "Статистика"
            }
        }

        var imageName: String {
            switch self {
            case .trackers: return "tabBarTracker"
            case .statistics: return "tabBarStatistic"
            }
        }

        var viewController: UIViewController {
            switch self {
            case .trackers: return TrackersViewController()
            case .statistics: return StatisticsViewController()
            }
        }
    }
}
