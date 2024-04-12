import Cocoa

class MyWindowController: NSWindowController {
    @IBOutlet weak var touchBarImageView: NSImageView!
    
      var imageIndex = 0
       
    
      override func windowDidLoad() {
          super.windowDidLoad()
          
          
          let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
          // Load your touch bar images into the array
          for i in 1...61{ // Replace 3 with the number of images you have
              if let image = NSImage(contentsOf: documentsDirectory.appendingPathComponent("p" + String(i) + ".png")) {
                  GlobalData.touchBarImages.append(image)
                  print(documentsDirectory.appendingPathComponent("p" + String(i)))
              } else {
                  print("Error loading touch bar image with name: p\(i)")
              }
          }

          // Start the timer to change the image in the Touch Bar
          Timer.scheduledTimer(timeInterval: 1.0/18.0, target: self, selector: #selector(updateTouchBarImage), userInfo: nil, repeats: true)
      }

      @objc func updateTouchBarImage() {
          // Check if the image index is within bounds
          guard imageIndex < GlobalData.touchBarImages.count else {
              print("Invalid touch bar image index.")
              return
          }

          // Update the image in the Touch Bar's NSImageView
          touchBarImageView.image = GlobalData.touchBarImages[imageIndex]

          // Increment the index and loop back to the first image if necessary
          imageIndex = (imageIndex + 1) % GlobalData.touchBarImages.count
     
      }
    
}
