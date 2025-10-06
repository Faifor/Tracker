import UIKit

final class EmptyStateView: UIView {

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let stack = UIStackView()

    init(image: UIImage?, title: String) {
        super.init(frame: .zero)
        setup(image: image, title: title)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup(image: nil, title: "")
    }

    private func setup(image: UIImage?, title: String) {
        imageView.image = image
        imageView.tintColor = .tertiaryLabel
        imageView.contentMode = .scaleAspectFit

        titleLabel.text = title
        titleLabel.textColor = UIColor(named: "mainBlack") ?? .label
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0

        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false

        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(titleLabel)

        addSubview(stack)

        imageView.setContentHuggingPriority(.required, for: .vertical)
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),

            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: stack.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: stack.trailingAnchor, constant: -8)
        ])
    }
}
