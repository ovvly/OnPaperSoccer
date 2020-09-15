import UIKit
import SnapKit

final class AboutView: UIView {
    let infoLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.App.system(size: 18)
        label.textColor = UIColor.App.textColor
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    let sourceCodeButton: MenuRowButton = {
        let button = MenuRowButton()
        button.tintColor = UIColor.App.green
        return button
    }()
    
    let contactUsButton: MenuRowButton = {
        let button = MenuRowButton()
        button.tintColor = UIColor.App.red
        return button
    }()
    
    let ideasButton: MenuRowButton = {
        let button = MenuRowButton()
        button.tintColor = UIColor.App.blue
        return button
    }()
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = UIColor.App.field
        addSubview(infoLabel)
        addSubview(sourceCodeButton)
        addSubview(contactUsButton)
        addSubview(ideasButton)
        setupCustomConstraints()
    }
    
    private func setupCustomConstraints() {
        infoLabel.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        sourceCodeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(contactUsButton.snp.top).offset(-20)
        }
        
        contactUsButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(ideasButton.snp.top).offset(-20)
        }
        
        ideasButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottomMargin.equalToSuperview().offset(-20)
        }
    }
}
