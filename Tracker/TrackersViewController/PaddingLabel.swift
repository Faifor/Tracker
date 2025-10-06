import UIKit

final class PaddingLabel: UILabel {

    var contentInsets: UIEdgeInsets = .zero {
        didSet { invalidateIntrinsicContentSize() }
    }

    override var intrinsicContentSize: CGSize {
        let base = super.intrinsicContentSize
        return CGSize(
            width: base.width + contentInsets.left + contentInsets.right,
            height: base.height + contentInsets.top + contentInsets.bottom
        )
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: contentInsets))
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let target = CGSize(
            width: size.width - contentInsets.left - contentInsets.right,
            height: size.height - contentInsets.top - contentInsets.bottom
        )
        let fitted = super.sizeThatFits(target)
        return CGSize(
            width: fitted.width + contentInsets.left + contentInsets.right,
            height: fitted.height + contentInsets.top + contentInsets.bottom
        )
    }
}
