            //
            //  ImageListViewController.swift
            //  Assignment 4
            //
            //  Created by Aniket Saxena on 2024-12-10.
            //

            import UIKit
            import CoreData

            // Page 1: List of NASA Images
            class ImageListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
                
                @IBOutlet weak var tableView: UITableView!
                private var nasaImages: [NASAImage] = []

                override func viewDidLoad() {
                    super.viewDidLoad()
                    
                    tableView.rowHeight = UITableView.automaticDimension
                    tableView.estimatedRowHeight = 250 // Provide an estimate for performance
                    
                    configureNavigationBar() // Ensure navigation bar is configured
                    
                    title = "NASA Images" // Set the title after configuring the navigation bar
                    
                    navigationController?.navigationBar.prefersLargeTitles = false
                    view.backgroundColor = UIColor.black // Set the background color
                    
                    setupUI()
                    fetchNASAImages() // Fetch data
                    
                    // Add button for saved images
                    let savedImagesButton = UIBarButtonItem(title: "Collection", style: .plain, target: self, action: #selector(goToSavedImages))
                    navigationItem.rightBarButtonItem = savedImagesButton
                    
                    // Customize Collection button appearance
                      savedImagesButton.setTitleTextAttributes([
                          .foregroundColor: UIColor(red: 255/255, green: 223/255, blue: 0/255, alpha: 1.0), // Set text color to yellow
                          .font: UIFont(name: "Menlo-Bold", size: 14)! // Set custom font and size
                      ], for: .normal)
                      
                    savedImagesButton.setTitleTextAttributes([
                        .foregroundColor: UIColor.gray, // Set highlighted text color
                        .font: UIFont(name: "Menlo-Bold", size: 14)!
                    ], for: .highlighted)
                    
                    // Register the custom cell
                    tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
                    
                    // Setup tableView
                    tableView.delegate = self
                    tableView.dataSource = self
                }
                
                private func configureNavigationBar() {
                    let appearance = UINavigationBarAppearance()
                    appearance.configureWithOpaqueBackground()
                    appearance.backgroundColor = UIColor.black
                    appearance.titleTextAttributes = [
                        .foregroundColor: UIColor.white, // White title color
                        .font: UIFont(name: "Menlo-Bold", size: 20)!
                    ]
                    navigationController?.navigationBar.standardAppearance = appearance
                    navigationController?.navigationBar.scrollEdgeAppearance = appearance
                    navigationController?.navigationBar.compactAppearance = appearance
                }

                private func setupUI() {
                    title = "NASA Images"
                    view.addSubview(tableView)
                    tableView.translatesAutoresizingMaskIntoConstraints = false
                    tableView.delegate = self
                    tableView.dataSource = self
                    
                    // Auto Layout constraints to make sure table view fills the entire screen
                    NSLayoutConstraint.activate([
                        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                    ])
                }
                
                private func fetchNASAImages() {
                       let apiURL = "https://api.nasa.gov/planetary/apod?api_key=zABNxGpNYmPOc9ecATt2SSh79cBOZeCWv69RyLuh&count=25"
                       guard let url = URL(string: apiURL) else { return }

                       URLSession.shared.dataTask(with: url) { data, _, error in
                           if let data = data {
                               do {
                                   self.nasaImages = try JSONDecoder().decode([NASAImage].self, from: data)
                                   DispatchQueue.main.async {
                                       self.tableView.reloadData()
                                   }
                               } catch {
                                   print("Error decoding JSON: \(error)")
                               }
                           }
                       }.resume()
                   }
                
                @IBAction func goToSavedImages(_ sender: UIButton) {
                    // Navigate to SavedImagesViewController
                            let savedImagesVC = storyboard?.instantiateViewController(withIdentifier: "SavedImagesViewController") as! SavedImagesViewController
                            navigationController?.pushViewController(savedImagesVC, animated: true)
                }
                // TableView Data Source and Delegate
                func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                    return nasaImages.count
                }

                func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
                    let nasaImage = nasaImages[indexPath.row]

                    // Set title
                    cell.titleLabel.text = nasaImage.title

                    // Load image asynchronously
                    if let imageURL = URL(string: nasaImage.url) {
                        URLSession.shared.dataTask(with: imageURL) { data, _, error in
                            if let data = data, error == nil {
                                DispatchQueue.main.async {
                                    cell.imageViewCell.image = UIImage(data: data)
                                }
                            }
                        }.resume()
                    } else {
                        cell.imageViewCell.image = UIImage(named: "placeholder") // Placeholder image
                    }

                    return cell
                }

                // Dynamic cell height
                func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                    return UITableView.automaticDimension // Allow dynamic height based on content
                }
                
                // Handle cell tap (to go to ImageDetailViewController)
                    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                        let selectedNASAImage = nasaImages[indexPath.row]
                        
                        // Create an instance of ImageDetailViewController
                        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "ImageDetailViewController") as? ImageDetailViewController {
                            // Pass the selected image to the detail view controller
                            detailVC.nasaImage = selectedNASAImage
                            navigationController?.pushViewController(detailVC, animated: true)
                        }
                        }
                override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
                    super.viewWillTransition(to: size, with: coordinator)

                    // Force tableView to fill the screen
                    tableView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
                    
                    coordinator.animate(alongsideTransition: { _ in
                        // Additional animations, if any
                    }, completion: nil)
                    }
                }
