//
//  SavedImagesViewController.swift
//  Assignment 4
//
//  Created by Aniket Saxena on 2024-12-10.
//

import UIKit
import CoreData

// Page 3: Saved Images
class SavedImagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    private var savedImages: [SavedImage] = [] // CoreData entity

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchSavedImages()
    }

    private func setupUI() {
            title = "Saved Images"
            
            // Set the background color of the view to black
            view.backgroundColor = UIColor.black
            
            // Set the background color of the table view to black and adjust other UI elements
            tableView.backgroundColor = UIColor.black
            tableView.separatorColor = UIColor.white // Set the separator color to white for contrast
            
            // Customize navigation bar appearance
            navigationController?.navigationBar.barTintColor = UIColor.black // Black background for nav bar
            navigationController?.navigationBar.titleTextAttributes = [
                .foregroundColor: UIColor.white // White title text
            ]
            
            // Register the custom cell
            tableView.register(SavedImageTableViewCell.self, forCellReuseIdentifier: "SavedImageCell")
            
            tableView.delegate = self
            tableView.dataSource = self
            
            // Auto Layout for table view
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }


    private func fetchSavedImages() {
        savedImages = CoreDataManager.shared.fetchSavedImages()
        tableView.reloadData()
    }

    // Table View Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedImages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedImageCell", for: indexPath) as! SavedImageTableViewCell
        let savedImage = savedImages[indexPath.row]

        // Set the title
        cell.titleLabel.text = savedImage.title

        // Set the image
        if let imageData = savedImage.imageData {
            cell.thumbnailImageView.image = UIImage(data: imageData)
        } else {
            cell.thumbnailImageView.image = UIImage(named: "placeholder") // Default placeholder image
        }

        return cell
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let savedImage = savedImages[indexPath.row]

        // Instantiate the ImageDetailViewController from the storyboard
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "ImageDetailViewController") as? ImageDetailViewController else {
            print("Failed to instantiate ImageDetailViewController")
            return
        }

        // Pass the saved image data
        detailVC.nasaImage = NASAImage(
            title: savedImage.title ?? "",
            date: savedImage.date ?? "",
            explanation: savedImage.explanation ?? "",
            url: "" // URL not needed for saved images
        )
        detailVC.savedImageData = savedImage.imageData

        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // To set a consistent cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Adjust height as needed
    }

}
