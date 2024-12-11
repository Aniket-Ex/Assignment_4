    //
    //  CustomTableViewCell.swift
    //  Assignment 4
    //
    //  Created by Aniket Saxena on 2024-12-10.
    //
    import UIKit

    class CustomTableViewCell: UITableViewCell {

        let titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = UIColor.white
            label.font = UIFont(name: "Menlo-Bold", size: 16)
            label.numberOfLines = 0
            return label
        }()

        let imageViewCell: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 20
            return imageView
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupUI()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupUI()
        }

        private func setupUI() {
            contentView.backgroundColor = UIColor.black
            contentView.addSubview(imageViewCell)
            contentView.addSubview(titleLabel)

            // Constraints for imageViewCell
            NSLayoutConstraint.activate([
                imageViewCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                imageViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                imageViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                imageViewCell.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6), // Adjust based on screen size (60% of the width)

                // Constraints for titleLabel
                titleLabel.topAnchor.constraint(equalTo: imageViewCell.bottomAnchor, constant: 10),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            ])
        }
    }
