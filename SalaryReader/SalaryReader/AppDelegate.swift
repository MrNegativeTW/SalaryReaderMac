//
//  AppDelegate.swift
//  SalaryReader
//
//  Created by Trevor on 2022/6/7.
//

import Cocoa
import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

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
                    let md5Data = convertToMD5(string: textField.stringValue)
                    let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
                    print("md5Hex: \(md5Hex)")
                    
                    let md5Base64 = md5Data.base64EncodedString()
                    print("md5Base64: \(md5Base64)")
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
    
    func convertToMD5(string: String) -> Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)
        
        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }
    
}

