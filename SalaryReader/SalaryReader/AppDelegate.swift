//
//  AppDelegate.swift
//  SalaryReader
//
//  Created by Trevor on 2022/6/7.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBAction func openFile(_ sender: NSMenuItem) {
        let dialog = NSOpenPanel();
        dialog.title = "Chose your .enc file"
        dialog.message = "Where is your fuckin .enc file?"
        dialog.allowedFileTypes = ["enc"]
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseDirectories    = true;
        dialog.canCreateDirectories    = true;
        dialog.allowsMultipleSelection = false;
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url
            print(result ?? "oh shit")
//            if (result != nil) {
//                let path = result!.path!
//                filename_field.stringValue = path
//            }
        } else {
            // User did nothing
            return
        }
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

