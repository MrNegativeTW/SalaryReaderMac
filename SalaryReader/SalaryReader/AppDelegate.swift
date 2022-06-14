//
//  AppDelegate.swift
//  SalaryReader
//
//  Created by Trevor on 2022/6/7.
//

import Cocoa
import CryptoKit

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
            
            let alert = NSAlert()
            alert.messageText = "Password"
            alert.informativeText = "Enter your personal ID to decrypt this file"
            alert.addButton(withTitle: "Decrypt")
            alert.addButton(withTitle: "Cancel")
            
            let textField = NSTextField(frame: NSRect(x: 0, y: 0, width: 150, height: 24))
            textField.placeholderString = "A123456789"
            
            alert.accessoryView = textField
            let response: NSApplication.ModalResponse = alert.runModal()
            
            // Take file path
            //            if (result != nil) {
            //                let path = result!.path!
            //                filename_field.stringValue = path
            //            }
            
            // Take password
            if (response == NSApplication.ModalResponse.alertFirstButtonReturn) {
                print(textField.stringValue)
                if (!textField.stringValue.isEmpty) {
                    let md5String = convertToMD5(string: textField.stringValue)
                    print("md5: \(md5String)")
                    
                    let utf8str = md5String.data(using: .utf8)
                    
                    if let base64Encoded = utf8str?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)) {
                        print("base64 encoded: \(base64Encoded)")

                        if let base64Decoded = Data(base64Encoded: base64Encoded, options: Data.Base64DecodingOptions(rawValue: 0))
                        .map({ String(data: $0, encoding: .utf8) }) {
                            // Convert back to a string
                            print("base64 decoded: \(base64Decoded ?? "")")
                        }
                    }
//                    let md5Base64 = md5Data.base64EncodedString()
//                    print("md5Base64: \(md5Base64)")
                }
            }
        }
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func convertToMD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
}

