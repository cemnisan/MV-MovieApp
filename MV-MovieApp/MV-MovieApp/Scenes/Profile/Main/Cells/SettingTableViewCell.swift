//
//  SettingTableViewCell.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 10.05.2022.
//

import UIKit
import MV_Components

final class SettingTableViewCell: UITableViewCell {
    
    static let identifier = "SettingsCell"
    
    private let iconContainer = MVContainerView(backgroundColor: #colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.2117647059, alpha: 1))
    private let iconImageView = MVLogoImage(frame: .zero)
    private let label         = MVSecondaryLabel(textAlignment: .left,
                                                 fontSize: 17,
                                                 textColor: .white,
                                                 text: nil)
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     
        configureView()
        configureAccessoryButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configure()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        iconImageView.image           = nil
        label.text                    = ""
        iconContainer.backgroundColor = nil
    }
}

// MARK: - Configure Cell
extension SettingTableViewCell {
    
    private func configure() {
        configureContainerView()
        configureLabel()
    }
    
    private func configureView() {
        contentView.addSubviews(views: iconContainer, label)
        iconContainer.addSubviews(views: iconImageView)
        contentView.clipsToBounds = true
        backgroundColor           = K.Styles.backgroundColor
    }
    
    private func configureContainerView() {
        let size: CGFloat = contentView.frame.size.height - 12
        iconContainer.layer.cornerRadius = size / 2
        iconContainer.layer.borderWidth  = 0
        iconContainer.frame = CGRect(x: 15,
                                     y: 6,
                                     width: size,
                                     height: size)
        
        let imageSize: CGFloat = size / 1.5
        iconImageView.frame = CGRect(x: (size-imageSize)/2,
                                     y: 5,
                                     width: imageSize,
                                     height: imageSize)
    }
    
    private func configureLabel() {
        label.frame = CGRect(
            x: 25 + iconContainer.frame.size.width,
            y: 0,
            width: contentView.frame.size.width - 20 - iconContainer.frame.size.width,
            height: contentView.frame.size.height)
    }
    
    private func configureAccessoryButton() {
        let accessoryButton = UIButton(frame: CGRect(x: 0,
                                                     y: 0,
                                                     width: 24,
                                                     height: 24))
        accessoryButton.setImage(UIImage(named: "left-arrow"), for: .normal)
        
        accessoryView = accessoryButton
    }
}

// MARK: - Set Cell
extension SettingTableViewCell {
    public func set(with model: SettingsOption) {
        label.text = model.title
        iconImageView.image = model.icon
    }
}
