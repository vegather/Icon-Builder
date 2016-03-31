//
//  ViewController.swift
//  Icon Builder
//
//  Created by Vegard Solheim Theriault on 06/09/15.
//  Copyright © 2015 MOON Wearables. All rights reserved.
//

//     .___  ___.   ______     ______   .__   __.
//     |   \/   |  /  __  \   /  __  \  |  \ |  |
//     |  \  /  | |  |  |  | |  |  |  | |   \|  |
//     |  |\/|  | |  |  |  | |  |  |  | |  . `  |
//     |  |  |  | |  `--'  | |  `--'  | |  |\   |
//     |__|  |__|  \______/   \______/  |__| \__|
//      ___  _____   _____ _    ___  ___ ___ ___
//     |   \| __\ \ / / __| |  / _ \| _ \ __| _ \
//     | |) | _| \ V /| _|| |_| (_) |  _/ _||   /
//     |___/|___| \_/ |___|____\___/|_| |___|_|_\



import Cocoa

class ViewController: NSViewController {

	@IBOutlet weak var iconTypePicker: NSPopUpButton!
	
	@IBAction func selectIconButtonClicked(sender: NSButton) {
		let openPanel = NSOpenPanel()
		openPanel.canChooseDirectories = false
		openPanel.allowsMultipleSelection = false
		openPanel.canChooseFiles = true
		
		openPanel.beginWithCompletionHandler { (result: Int) -> Void in
			if result == NSFileHandlingPanelOKButton {
				let iconURL = openPanel.URLs[0]
				if let icon = NSImage(contentsOfURL: iconURL) {
					self.dealWithIcon(icon)
				} else {
					self.showAlertWithMessage("Could not open the icon",
						andInformationalText: "Path: \(iconURL)")
				}
			}
		}
	}
	
	private func dealWithIcon(icon: NSImage) {
		MOONLog("Will deal with icon: \(icon)")
		
		let currentIconType = iconTypeForPopUpButton(iconTypePicker)
		
		do {
			let iconSet = try IconSpitter.getIconsFromIcon(icon, forIconType: currentIconType)
			MOONLog("Got \(iconSet.icons.count) icons")
			
			let desktopPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DesktopDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
			let iconFolderPath = (desktopPath as NSString).stringByAppendingPathComponent(iconSet.folderName)
			if NSFileManager.defaultManager().fileExistsAtPath(iconFolderPath) == false {
				do {
					try NSFileManager.defaultManager().createDirectoryAtPath(iconFolderPath, withIntermediateDirectories: false, attributes: nil)
					
                    let contentJSONPath = (iconFolderPath as NSString).stringByAppendingPathComponent("Contents.json")
                    iconSet.contentJSON.writeToFile(contentJSONPath, atomically: true)
                    
                    for icon in iconSet.icons {
                        let iconPath = (iconFolderPath as NSString).stringByAppendingPathComponent(icon.name)
                        do {
                            try saveIcon(icon.icon, toPath: iconPath)
                        } catch {
                            showAlertWithMessage("Error while saving image", andInformationalText: "Could not save image to path: \(iconPath)")
                        }
                    }
					
				} catch let error as NSError {
					showAlertWithMessage("Could not create folder at path \(iconFolderPath)", andInformationalText: error.localizedDescription)
				}
			} else {
				showAlertWithMessage("Folder \(iconFolderPath) already exists", andInformationalText: "Move that folder to its appropriate location, and try again!")
			}
			
        } catch IconSpitterError.InternalError {
            showAlertWithMessage("Internal Error", andInformationalText: "Hit an unexpected error while processing your image. Make sure you are using a png that is large enough (196x196) and square.")
        } catch IconSpitterError.IconNotSquare {
			showAlertWithMessage("The icon is not square", andInformationalText: "The icon has width: \(icon.size.width)px and height: \(icon.size.height)px ")
		} catch IconSpitterError.IconNotBigEnough {
			showAlertWithMessage("The icon is not big enough", andInformationalText: "The icon has width: \(icon.size.width)px and height: \(icon.size.height)px ")
		} catch {
			showAlertWithMessage("Unexpected Error", andInformationalText: "An unexpected error occurred")
		}
	}
	
	
	
	
	
	// -------------------------------
	// MARK: Helper Methods
	// -------------------------------

	private func getFileNameForURL(url: NSURL) -> String {
		var iconName = "Icon"
		
		let iconFileName = (url.absoluteString as NSString).lastPathComponent
		if let escapedIconFileName = iconFileName.stringByRemovingPercentEncoding {
			let dotLocation = (escapedIconFileName as NSString).rangeOfString(".").location
			iconName = (escapedIconFileName as NSString).substringToIndex(dotLocation)
		}
		
		return iconName
	}
	
	private func saveIcon(icon: NSImage, toPath path: String) throws {
		if let cgRef = icon.CGImageForProposedRect(nil, context: nil, hints: nil) {
			let newRep = NSBitmapImageRep(CGImage: cgRef)
			newRep.size = icon.size
			if let pngData = newRep.representationUsingType(NSBitmapImageFileType.NSPNGFileType, properties: [String : AnyObject]()) {
				pngData.writeToFile(path, atomically: true)
				return
			}
		}
		
		throw NSError(domain: "", code: 0, userInfo: nil)
	}
	
	private func showAlertWithMessage(message: String, andInformationalText infoText: String) {
		MOONLog("Will show alert with message: \(message), informativeText: \(infoText)")
		
		let alert = NSAlert()
		alert.alertStyle = NSAlertStyle.WarningAlertStyle
		alert.messageText = message
		alert.informativeText = infoText
		alert.addButtonWithTitle("Got it")
		alert.runModal()
	}
	
	private func iconTypeForPopUpButton(popUp: NSPopUpButton) -> IconSpitter.IconType {
		if popUp.selectedTag() == 0 {
			return IconSpitter.IconType.iOSAppIcon
		} else if popUp.selectedTag() == 1 {
			return IconSpitter.IconType.iOSTabBarIcon
		} else if popUp.selectedTag() == 2 {
			return IconSpitter.IconType.iOSToolbarNavbarIcon
		} else if popUp.selectedTag() == 3 {
			return IconSpitter.IconType.MacAppIcon
		} else {
			fatalError("popUp tag was unknown")
		}
	}
	
}
