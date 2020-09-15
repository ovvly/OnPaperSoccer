import Foundation
import UIKit
import SnapKit

final class MenuRowButton: UIControl {
    @IBInspectable
    var color: UIColor = UIColor.App.red {
        didSet {
            rightArrowImageView.tintColor = color
            leftArrowImageView.tintColor = color
        }
    }
    
    @IBInspectable
    var text: String = "" {
        didSet {
            titleLabel.text = text
            titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        }
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.App.dreamwalker(size: 24)
        label.textColor = UIColor.App.textColor
        label.textAlignment = .center
        return label
    }()

    private let rightArrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "menu_right_arrow"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let leftArrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "menu_left_arrow"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    init() {
        super.init(frame: CGRect.zero)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        clipsToBounds = true
        backgroundColor = UIColor.white
        addSubviews()
        setupCustomConstraints()
    }

    private func addSubviews() {
        addSubview(leftArrowImageView)
        addSubview(rightArrowImageView)
        addSubview(titleLabel)
    }

    private func setupCustomConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(54)
        }

        leftArrowImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalTo(self.snp.leading).offset(80)
        }

        rightArrowImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(self.snp.trailing).offset(-80)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(leftArrowImageView.snp.trailing).offset(10)
            make.trailing.equalTo(rightArrowImageView.snp.leading).offset(-10)
        }
    }
}
