import Cocoa

class DraggableImageView: NSImageView {

    private var initialMouseLocation: NSPoint?
    private let sensitivity: CGFloat = 0.5  // Adjust the sensitivity factor as needed

    override func mouseDown(with event: NSEvent) {
        initialMouseLocation = event.locationInWindow
    }

    override func mouseDragged(with event: NSEvent) {
        guard let initialMouseLocation = initialMouseLocation else { return }

        let newMouseLocation = event.locationInWindow
        let deltaX = (newMouseLocation.x - initialMouseLocation.x) * sensitivity
        let deltaY = (newMouseLocation.y - initialMouseLocation.y) * sensitivity

        var newOrigin = self.frame.origin
        newOrigin.x += deltaX
        newOrigin.y += deltaY

        // Ensure the new origin is within the window bounds
        let maxX = superview?.frame.width ?? 0 - frame.width
        let maxY = superview?.frame.height ?? 0 - frame.height

        newOrigin.x = max(0, min(newOrigin.x, maxX))
        newOrigin.y = max(0, min(newOrigin.y, maxY))

        self.frame.origin = newOrigin
    }
}
