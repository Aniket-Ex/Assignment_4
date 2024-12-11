                    //
                    //  ImageDetailViewController.swift
                    //  Assignment 4
                    //
                    //  Created by Aniket Saxena on 2024-12-10.
                    //

                    import UIKit
                    import CoreData

                    class ImageDetailViewController: UIViewController {
                        
                        @IBOutlet weak var imageView: UIImageView!
                        @IBOutlet weak var titleLabel: UILabel!
                        @IBOutlet weak var dateLabel: UILabel!
                        @IBOutlet weak var explanationLabel: UILabel!
                        @IBOutlet weak var saveButton: UIButton!
                        var nasaImage: NASAImage?
                        var savedImageData: Data?
                        
                        // Portrait Constraints
                        var portraitConstraints: [NSLayoutConstraint] = []
                        
                        // Landscape Constraints
                        var landscapeConstraints: [NSLayoutConstraint] = []
                        
                        override func viewDidLoad() {
                            super.viewDidLoad()

                            // Set the background color
                            view.backgroundColor = UIColor.black
                            
                            // Set navigation bar back button color
                            navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 223/255, blue: 0/255, alpha: 1.0)
                            
                            // Set the navigation bar title font to Menlo-Bold
                            let titleFont = UIFont(name: "Menlo-Bold", size: 18)
                            navigationController?.navigationBar.titleTextAttributes = [
                                .foregroundColor: UIColor.white,
                                .font: titleFont ?? UIFont.systemFont(ofSize: 18)
                            ]
                            
                            // Configure image view for rounded corners
                            imageView.layer.cornerRadius = 15  // Set the corner radius
                            imageView.clipsToBounds = true      // Ensure the image is clipped to the rounded corners
                            
                            // Force layout update to apply the corner radius
                            imageView.layoutIfNeeded()

                            // Configure labels and button
                            titleLabel.textColor = UIColor.white // Set text color to white
                            titleLabel.font = UIFont(name: "Menlo-Bold", size: 18)
                            titleLabel.numberOfLines = 2 // Allow up to 2 lines
                            titleLabel.lineBreakMode = .byWordWrapping // Allow wrapping of the text

                            // Configure date label
                            dateLabel.textColor = UIColor.white // Set text color to white
                            dateLabel.font = UIFont(name: "Menlo-Bold", size: 16)

                            // Configure explanation label
                            explanationLabel.textColor = UIColor.white // Set text color to white
                            explanationLabel.font = UIFont(name: "Menlo-Bold", size: 14)
                            explanationLabel.numberOfLines = 10
                            explanationLabel.lineBreakMode = .byTruncatingTail // Truncate if too long
                            
                            // Configure save button
                            saveButton.setTitleColor(UIColor.black, for: .normal) // Text color
                            saveButton.backgroundColor = UIColor(red: 255/255, green: 223/255, blue: 0/255, alpha: 1.0) // Custom background color
                            saveButton.layer.cornerRadius = 10
                            saveButton.setTitle("Save Image", for: .normal)
                            saveButton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14)
                            
                            // Enable Auto Layout
                            imageView.translatesAutoresizingMaskIntoConstraints = false
                            titleLabel.translatesAutoresizingMaskIntoConstraints = false
                            dateLabel.translatesAutoresizingMaskIntoConstraints = false
                            explanationLabel.translatesAutoresizingMaskIntoConstraints = false
                            saveButton.translatesAutoresizingMaskIntoConstraints = false
                            
                            // Define constraints for both orientations
                            setupConstraints()
                            
                            // Activate portrait constraints initially
                            NSLayoutConstraint.activate(portraitConstraints)
                            
                            populateData()
                        }
                        
                        private func setupConstraints() {
                              // Portrait Constraints
                              portraitConstraints = [
                                  // Image View Constraints
                                  imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                                  imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                  imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                  imageView.heightAnchor.constraint(equalToConstant: 300),
                                  
                                  // Save Button Constraints
                                  saveButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
                                  saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                  saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                  saveButton.heightAnchor.constraint(equalToConstant: 50),
                                  
                                  // Title Label Constraints
                                  titleLabel.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
                                  titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                  titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                  
                                  // Date Label Constraints
                                  dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
                                  dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                  dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                  
                                  // Explanation Label Constraints
                                  explanationLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
                                  explanationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                  explanationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
                              ]
                              
                              // Landscape Constraints
                              landscapeConstraints = [
                                  // Image View Constraints (left side)
                                  imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                                  imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                  imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                                  imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: -30),
                                  
                                  // Title Label Constraints (right side)
                                  titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                                  titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
                                  titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                  
                                  // Date Label Constraints
                                  dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
                                  dateLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
                                  dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                  
                                  // Explanation Label Constraints
                                  explanationLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
                                  explanationLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
                                  explanationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                  
                                  // Save Button Constraints
                                  saveButton.topAnchor.constraint(equalTo: explanationLabel.bottomAnchor, constant: 20),
                                  saveButton.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
                                  saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                  saveButton.heightAnchor.constraint(equalToConstant: 50)
                              ]
                          }

                        
                        override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
                            super.viewWillTransition(to: size, with: coordinator)
                            
                            // Check the new orientation
                            let isLandscape = size.width > size.height
                            
                            // Update constraints based on orientation
                            NSLayoutConstraint.deactivate(isLandscape ? portraitConstraints : landscapeConstraints)
                            NSLayoutConstraint.activate(isLandscape ? landscapeConstraints : portraitConstraints)
                            }
                        
                        private func populateData() {
                            if let savedImageData = savedImageData {
                                // Display saved image
                                imageView.image = UIImage(data: savedImageData)
                            } else if let nasaImage = nasaImage, let url = URL(string: nasaImage.url) {
                                // Fetch and display image from URL
                                URLSession.shared.dataTask(with: url) { data, _, _ in
                                    if let data = data {
                                        DispatchQueue.main.async {
                                            self.imageView.image = UIImage(data: data)
                                        }
                                    }
                                }.resume()
                            }

                            titleLabel.text = nasaImage?.title
                            dateLabel.text = "Date: \(nasaImage?.date ?? "")"
                            explanationLabel.text = nasaImage?.explanation

                            // Limit the explanation text
                            explanationLabel.numberOfLines = 10
                            explanationLabel.lineBreakMode = .byTruncatingTail // Add "..." if text is too long
                        }
                        
                        @IBAction func saveImage(_ sender: UIButton) {
                            
                            guard let nasaImage = nasaImage, let url = URL(string: nasaImage.url) else { return }
                            // Asynchronously download the image data
                            URLSession.shared.dataTask(with: url) { data, _, error in
                                if let data = data {
                                    // Save the image data to CoreData in the background thread
                                    DispatchQueue.main.async {
                                        CoreDataManager.shared.saveImage(
                                            title: nasaImage.title,
                                            date: nasaImage.date,
                                            explanation: nasaImage.explanation,
                                            imageData: data
                                        )
                                        
                                        let alert = UIAlertController(title: "Saved", message: "Image saved successfully!", preferredStyle: .alert)
                                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                                        self.present(alert, animated: true)
                                    }
                                } else if let error = error {
                                    // Handle the error (e.g., show an error message)
                                    print("Failed to download image: \(error.localizedDescription)")
                                }
                            }.resume()
                        }
                    }
