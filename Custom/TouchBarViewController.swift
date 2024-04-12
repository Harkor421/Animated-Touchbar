    import Cocoa

    extension NSTouchBarItem.Identifier {
        static let myCustomButton = NSTouchBarItem.Identifier("com.yourcompany.myApp.myCustomButton")
    }

    class TouchBarViewController: NSViewController, NSTouchBarDelegate {
        override func makeTouchBar() -> NSTouchBar? {
            let touchBar = NSTouchBar()
            touchBar.delegate = self
            touchBar.defaultItemIdentifiers = [.myCustomButton]
            return touchBar
        }

        func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
            switch identifier {
            case .myCustomButton:
                let button = NSButtonTouchBarItem(identifier: identifier)
                button.title = "My Custom Button"
                button.target = self
                button.action = #selector(customButtonClicked)
                return button

            default:
                return nil
            }
        }

        @objc func customButtonClicked(_ sender: NSButton) {
            // Handle button click
        }
    }
