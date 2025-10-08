import UIKit

final class TrackersViewController: UIViewController {

    private lazy var addButton: UIBarButtonItem = {
        let image = UIImage(named: "mainPlus")?.withRenderingMode(.alwaysOriginal)
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(addTapped))
        return item
    }()

    private lazy var dateBadgeLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.isUserInteractionEnabled = false

        let mainBlack = UIColor(named: "mainBlack") ?? .label
        let lidhtGray = UIColor(named: "lightGray") ?? .systemGray5
        label.backgroundColor = lidhtGray
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true

        label.textColor = mainBlack
        label.font = UIFont.systemFont(ofSize: 17)

        label.contentInsets = UIEdgeInsets(top: 6, left: 5.5, bottom: 6, right: 5.5)

        label.text = Self.formattedToday()

        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)

        return label
    }()

    private let emptyStateView = EmptyStateView(
        image: UIImage(named: "mainPlaceholder"),
        title: "Что будем отслеживать?"
    )

    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.obscuresBackgroundDuringPresentation = false
        sc.hidesNavigationBarDuringPresentation = false
        sc.searchBar.placeholder = "Поиск"
        
        sc.searchBar.isTranslucent = true
        sc.searchBar.backgroundImage = UIImage()
        sc.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        sc.searchBar.setSearchFieldBackgroundImage(UIImage(), for: .normal)
        sc.searchBar.backgroundColor = .clear

        let field = sc.searchBar.searchTextField
        field.backgroundColor = UIColor(named: "searchGray")
        field.layer.cornerRadius = 10
        field.layer.masksToBounds = true

        field.layer.borderWidth = 0
        field.layer.borderColor = UIColor.clear.cgColor

        if let bgView = field.subviews.first {
            bgView.backgroundColor = .clear
            bgView.layer.backgroundColor = UIColor.clear.cgColor
        }
        if let barBG = sc.searchBar.subviews.first?.subviews.first(where: { $0 is UIImageView }) {
            barBG.isHidden = true
        }

        return sc
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        cv.contentInsetAdjustmentBehavior = .automatic
        return cv
    }()

    private var trackers: [String] = [] {
        didSet { updateEmptyStateVisibility() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Трекеры"
        navigationItem.largeTitleDisplayMode = .always

        navigationItem.leftBarButtonItem = addButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: dateBadgeLabel)

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true

        setupLayout()
        updateEmptyStateVisibility()
        applyTransparentNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dateBadgeLabel.text = Self.formattedToday()
    }

    private func setupLayout() {
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        view.addSubview(emptyStateView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            emptyStateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 24),
            emptyStateView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -24)
        ])
    }

    private func updateEmptyStateVisibility() {
        let isEmpty = trackers.isEmpty
        emptyStateView.isHidden = !isEmpty
        collectionView.isHidden = isEmpty
    }

    private func applyTransparentNavigationBar() {
        let mainBlack = UIColor(named: "mainBlack") ?? .label
        let largeFont = UIFont.systemFont(ofSize: 34, weight: .bold)

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: mainBlack]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: mainBlack,
            .font: largeFont
        ]
        appearance.shadowColor = .clear

        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
    }

    @objc private func addTapped() {

    }
}

private extension TrackersViewController {
    static func formattedToday() -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ru_RU")
        df.dateFormat = "dd.MM.yy"
        return df.string(from: Date())
    }
}

extension TrackersViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        trackers.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = .secondarySystemBackground
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset: CGFloat = 16
        let spacing: CGFloat = 12
        let columns: CGFloat = 2
        let totalSpacing = inset * 2 + spacing * (columns - 1)
        let width = (collectionView.bounds.width - totalSpacing) / columns
        return CGSize(width: width, height: 100)
    }
}
