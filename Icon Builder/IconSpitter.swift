//
//  IconResizer.swift
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



import Foundation
import AppKit
import CoreGraphics

enum IconSpitterError: ErrorType {
	case IconNotSquare
	case IconNotBigEnough
    case InternalError
}


struct IconSpitter {
	
	enum IconType {
		case iOSAppIcon
		case iOSTabBarIcon
		case iOSToolbarNavbarIcon
		case MacAppIcon
	}
    
    struct IconSet {
        struct Icon {
            let icon: NSImage
            let name: String
        }
        let icons: [Icon]
        let contentJSON: NSData
        let folderName: String
    }
	
    
	
	
	// -------------------------------
	// MARK: Public API
	// -------------------------------
	
	// Will correctly set the icon names
	// Throws: IconSpitterError
	static func getIconsFromIcon(inputIcon: NSImage, forIconType iconType: IconType) throws -> IconSet {
		if inputIcon.size.width == inputIcon.size.height {
			switch iconType {
			case .iOSAppIcon:
                return try produceIconSetForIcon(inputIcon, withJSON: iOSAppIconJSON, folderName: "AppIcon.appiconset")
			case .iOSTabBarIcon:
                return try produceIconSetForIcon(inputIcon, withJSON: iOSAppIconJSON, folderName: "AppIcon.appiconset")
			case .iOSToolbarNavbarIcon:
                return try produceIconSetForIcon(inputIcon, withJSON: iOSAppIconJSON, folderName: "AppIcon.appiconset")
			case .MacAppIcon:
                return try produceIconSetForIcon(inputIcon, withJSON: OSXAppIconJSON, folderName: "AppIcon.appiconset")
			}
		} else {
			throw IconSpitterError.IconNotSquare
		}
		
	}
	
	
	
	
	// -------------------------------
	// MARK: Icon Production
	// -------------------------------
	
    // Throws: IconSpitterError
    static private func produceIconSetForIcon(inputIcon: NSImage, withJSON json: [String: AnyObject], folderName: String) throws -> IconSet {
        var icons = Array<IconSet.Icon>()
        
        // Produce Icons from JSON
        guard let jsonImages = json["images"] as? [[String: String]] else {
            MOONLog("JSON does not contain images key")
            throw IconSpitterError.InternalError
        }
        
        for jsonImage in jsonImages {
            
            guard let filename = jsonImage["filename"] else {
                MOONLog("Some keys where missing")
                throw IconSpitterError.InternalError
            }
            
            var iconAlreadyExists = false
            for icon in icons {
                if icon.name == filename {
                    iconAlreadyExists = true
                    break
                }
            }
            
            guard iconAlreadyExists == false else {
                continue
            }
            
            var nameComponents = filename.componentsSeparatedByString("_")
            guard nameComponents.count == 2 else {
                MOONLog("Weird name components for filename: \(filename)")
                throw IconSpitterError.InternalError
            }
            nameComponents = nameComponents[1].componentsSeparatedByString(".")
            guard nameComponents.count == 2 else {
                MOONLog("Weird name components for filename: \(filename), json: \(jsonImage)")
                throw IconSpitterError.InternalError
            }
            guard let size = Int(nameComponents[0]) else {
                MOONLog("Could not get int from nameComponents: \(nameComponents)")
                throw IconSpitterError.InternalError
            }
            
            if let newIcon = resizeIcon(inputIcon, toSize: NSSize(width: size, height: size)) {
                icons.append(IconSet.Icon(icon: newIcon, name: filename))
            }
        }
        
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(json, options: [])
            return IconSet(icons: icons, contentJSON: jsonData, folderName: folderName)
        } catch let error as NSError {
            MOONLog("Could not produce JSON data with error: \(error)")
            throw IconSpitterError.InternalError
        }
    }
	
	
	
	
	// -------------------------------
	// MARK: Icon Factory
	// -------------------------------
	
	static private func resizeIcon(icon: NSImage, toSize newSize: NSSize) -> NSImage? {
		let cgImage = icon.CGImageForProposedRect(nil, context: nil, hints: nil)
		let bitsPerComponent = CGImageGetBitsPerComponent(cgImage)
		let bytesPerRow = CGImageGetBytesPerRow(cgImage)
		let colorSpace = CGImageGetColorSpace(cgImage)
		let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue)
		
		let context = CGBitmapContextCreate(nil, Int(newSize.width), Int(newSize.height), bitsPerComponent, bytesPerRow, colorSpace, bitmapInfo.rawValue)
		CGContextSetInterpolationQuality(context, CGInterpolationQuality.High)
		CGContextDrawImage(context, CGRect(origin: CGPointZero, size: newSize), cgImage)
		
		return CGBitmapContextCreateImage(context).flatMap {  NSImage(CGImage: $0, size: newSize) }
	}

}