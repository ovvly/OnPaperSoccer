//
// Created by Jakub Sowa on 03/09/2020.
// Copyright (c) 2020 com.owlyapps.onPaperSoccer. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class SummaryView: UIView {

    let dimView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.3
        return view
    }()

    let summaryView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    let infoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.App.textColor
        label.font = UIFont.App.dreamwalker(size: 18)
        return label
    }()

    let ballImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.Asset.ball)
        return imageView
    }()

    let okButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ok", for: .normal)
        button.setTitleColor(UIColor.App.textColor, for: .normal)
        button.titleLabel?.font = UIFont.App.dreamwalker(size: 18)
        button.backgroundColor = .white
        return button
    }()

    let restartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Restart", for: .normal)
        button.setTitleColor(UIColor.App.textColor, for: .normal)
        button.titleLabel?.font = UIFont.App.dreamwalker(size: 18)
        button.backgroundColor = .white
        return button
    }()

    let buttonsView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.App.borderlines
        return view
    }()

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubviews()
        setupConstraints()
        backgroundColor = .clear
    }

    private func addSubviews() {
        addSubview(dimView)
        addSubview(summaryView)
        summaryView.addSubview(infoLabel)
        summaryView.addSubview(ballImageView)
        summaryView.addSubview(buttonsView)
        buttonsView.addSubview(okButton)
        buttonsView.addSubview(restartButton)
    }

    private func setupConstraints() {
        dimView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        summaryView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-64)
            make.leading.equalToSuperview().offset(64)
            make.trailing.equalToSuperview().offset(-64)
        }

        infoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        ballImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(60)
            make.top.equalTo(infoLabel.snp.bottom).offset(16)
        }

        buttonsView.snp.makeConstraints { make in
            make.top.equalTo(ballImageView.snp.bottom).offset(16)
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }

        okButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(1)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
        }

        restartButton.snp.makeConstraints { make in
            make.top.equalTo(okButton)
            make.bottom.equalToSuperview()
            make.leading.equalTo(okButton.snp.trailing).offset(1)
            make.trailing.equalToSuperview()
            make.width.equalTo(okButton)
        }
    }
}
