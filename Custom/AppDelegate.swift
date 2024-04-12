//
//  AppDelegate.swift
//  Custom
//
//  Created by Samir Gonzalez on 6/12/23.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application

        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
            // Ensure the application stays active when reopened
            return true
}

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
            // Prevent the application from terminating when the last window is closed
            return false
    }
    


}

