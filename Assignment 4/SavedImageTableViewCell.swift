//
//  SavedImageTableViewCell.swift
//  Assignment 4
//
//  Created by Aniket Saxena on 2024-12-10.
//

import UIKit

class SavedImageTableViewCell: UITableViewCell {
    let thumbnailImageView: UIImageView = UIImageView()
    let titleLabel: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
          contentView.addSubview(thumbnailImageView)
          contentView.addSubview(titleLabel)

          // Disable autoresizing masks to use Auto Layout
          thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
          titleLabel.translatesAutoresizingMaskIntoConstraints = false

          // Layout Constraints
          NSLayoutConstraint.activate([
              // Thumbnail image view
              thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
              thumbnailImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
              thumbnailImageView.widthAnchor.constraint(equalToConstant: 80),
              thumbnailImageView.heightAnchor.constraint(equalToConstant: 80),

              // Title label
              titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10),
              titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
              titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
          ])

          // Customization
          thumbnailImageView.contentMode = .scaleAspectFill
          thumbnailImageView.clipsToBounds = true
          
          // Set the background color of the cell to black
          contentView.backgroundColor = UIColor.black
          
          // Set title label properties
          titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
          titleLabel.numberOfLines = 2
          titleLabel.textColor = UIColor.white // Set the text color of title to white
      }
  }
