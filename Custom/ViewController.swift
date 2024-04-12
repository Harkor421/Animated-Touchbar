    import Cocoa
    import ImageIO


    class ViewController: NSViewController {

        @IBOutlet weak var imageView: NSImageView!
        

        @IBAction func chooseFileButtonClicked(_ sender: Any) {
            deleteTouchBarImages()
            GlobalData.touchBarImages.removeAll()
            let openPanel = NSOpenPanel()
            openPanel.allowedFileTypes = ["gif"]
            openPanel.begin { (result) in
                if result.rawValue == NSFileHandlingPanelOKButton {
                    if let url = openPanel.urls.first {
                        // Handle the selected file URL
                        self.processGIF(url: url)
                    }
                }
            }
            
        }
        func deleteTouchBarImages() {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

            for i in 1...61 {
                let imagePath = documentsDirectory.appendingPathComponent("p\(i).png")

                do {
                    // Check if the file exists before attempting to delete it
                    if FileManager.default.fileExists(atPath: imagePath.path) {
                        try FileManager.default.removeItem(at: imagePath)
                        print("Deleted file: \(imagePath)")
                    } else {
                        print("File does not exist: \(imagePath)")
                    }
                } catch {
                    print("Error deleting file: \(error.localizedDescription)")
                }
            }
        }

        
        @IBAction func chooseFileButtonClicked2(_ sender: Any) {

            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            // Load your touch bar images into the array
            for i in 1...61 { // Replace 3 with the number of images you have
                if let image = NSImage(contentsOf: documentsDirectory.appendingPathComponent("p" + String(i) + ".png")) {
                    GlobalData.touchBarImages.append(image)
                    print(documentsDirectory.appendingPathComponent("p" + String(i)))
                } else {
                    print("Error loading touch bar image with name: p\(i)")
                }
            }
        }

        override func viewDidAppear() {
            super.viewDidAppear()
            view.window?.level = .floating
        }

        
        func processGIF(url: URL) {
            guard let source = CGImageSourceCreateWithURL(url as CFURL, nil) else { return }
            let numberOfFrames = CGImageSourceGetCount(source)

            // Get the Documents directory
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

            for index in 0..<min(numberOfFrames, 60) { // Limit to 60 frames
                if let frame = CGImageSourceCreateImageAtIndex(source, index, nil) {
                    let image = NSImage(cgImage: frame, size: NSZeroSize)

                    // Convert NSImage to NSData in PNG format
                    if let imageData = image.tiffRepresentation,
                       let bitmap = NSBitmapImageRep(data: imageData),
                       let pngData = bitmap.representation(using: .png, properties: [:]) {

                        // Create a unique filename for each frame
                        let filename = "p\(index).png"
                        let destinationURL = documentsDirectory.appendingPathComponent(filename)
                        let image = NSImage(cgImage: frame, size: NSZeroSize)
                                        // Save or display the image as needed
                                        // For example, you can set it to an NSImageView
                                        self.imageView.image = image
                        // Save the PNG data to the Documents directory
                        do {
                            try pngData.write(to: destinationURL)
                            print("Saved frame \(index) to: \(destinationURL.path)")
                        } catch {
                            print("Error saving frame \(index): \(error.localizedDescription)")
                        }
                    }
                }
            }
        }

    }

        
