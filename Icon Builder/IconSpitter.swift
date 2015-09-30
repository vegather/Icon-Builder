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
}


struct IconSpitter {
	
	enum IconType {
		case iOSAppIcon
		case iOSTabBarIcon
		case iOSToolbarNavbarIcon
		case MacAppIcon
	}
	
	
	
	// -------------------------------
	// MARK: iOS Types
	// -------------------------------
	
	private struct iOSAppIconType {
		static let RequiredMinSize: CGFloat = 1024
		
		// Key: Icon name suffix
		// Value: Pixel size
		static let Sizes = [
			"-512@2x.png"	: 1024,
			"-512@1x.png"	: 512,
			"-120@1x.png"	: 120,
			"-98@2x.png"	: 196,
			"-86@2x.png"	: 172,
			"-76@2x.png"	: 152,
			"-76@1x.png"	: 76,
			"-72@2x.png"	: 144,
			"-72@1x.png"	: 72,
			"-60@3x.png"	: 180,
			"-60@2x.png"	: 120,
			"-57@2x.png"	: 114,
			"-57@1x.png"	: 57,
			"-50@2x.png"	: 100,
			"-50@1x.png"	: 50,
			"-44@2x.png"	: 88,
			"-40@3x.png"	: 120,
			"-40@2x.png"	: 80,
			"-40@1x.png"	: 40,
			"-29@3x.png"	: 87,
			"-29@2x.png"	: 58,
			"-29@1x.png"	: 29,
			"-27_5@2x.png"	: 55,
			"-24@2.png"		: 48]
	}
	
	private struct iOSTabBarIconType {
		static let RequiredMinSize: CGFloat = 75
		
		// Key: Icon name suffix
		// Value: Pixel size
		static let Sizes = [
			"-25@3x.png"	: 75,
			"-25@2x.png"	: 50,
			"-25@1x.png"	: 25]
	}
	
	private struct iOSToolbarNavbarIconType {
		static let RequiredMinSize: CGFloat = 66
		
		// Key: Icon name suffix
		// Value: Pixel size
		static let Sizes = [
			"-22@3x.png"	: 66,
			"-22@2x.png"	: 44,
			"-22@1x.png"	: 22]
	}
	
	
	
	
	
	// -------------------------------
	// MARK: Mac Types
	// -------------------------------
	
	private struct MacAppIconType {
		static let RequiredMinSize: CGFloat = 1024
		
		// Key: Icon name suffix
		// Value: Pixel size
		static let Sizes = [
			"-1024pt.png"	: 1024,
			"-512pt.png"	: 512,
			"-256pt.png"	: 256,
			"-128pt.png"	: 128,
			"-64pt.png"		: 64,
			"-32pt.png"		: 32,
			"-16pt.png"		: 16]
	}
	
	
	
	
	// -------------------------------
	// MARK: Public API
	// -------------------------------
	
	// Will correctly set the icon names
	// Throws: IconSpitterError
	static func getIconsFromIcon(inputIcon: NSImage, forIconType iconType: IconType, withIconName iconName: String) throws -> [(icon: NSImage, name: String)] {
		if inputIcon.size.width == inputIcon.size.height {
			switch iconType {
			case .iOSAppIcon:
				return try produceIOSAppIconsForIcon(inputIcon, withName: iconName)
			case .iOSTabBarIcon:
				return try produceIOSTabBarIconsForIcon(inputIcon, withName: iconName)
			case .iOSToolbarNavbarIcon:
				return try produceIOSToolbarNavbarIconsForIcon(inputIcon, withName: iconName)
			case .MacAppIcon:
				return try produceMacAppIconsForIcon(inputIcon, withName: iconName)
			}
		} else {
			throw IconSpitterError.IconNotSquare
		}
		
	}
	
	
	
	
	// -------------------------------
	// MARK: Icon Production
	// -------------------------------
	
	// Throws: IconSpitterError
	static private func produceIOSAppIconsForIcon(inputIcon: NSImage, withName name: String) throws -> [(icon: NSImage, name: String)] {
		if inputIcon.size.width >= iOSAppIconType.RequiredMinSize {
			
			var icons = [(icon: NSImage, name: String)]()
			
			for (nameSuffix, size) in iOSAppIconType.Sizes {
				if let resizedIcon = resizeIcon(inputIcon, toSize: NSSize(width: size, height: size)) {
					icons.append((resizedIcon, name + nameSuffix))
				} else {
					print("Could not produce IOSAppIcon with name: \(name) for size: \(size)")
				}
			}
			
			return icons
		} else {
			throw IconSpitterError.IconNotBigEnough
		}
	}
	
	// Throws: IconSpitterError
	static private func produceIOSTabBarIconsForIcon(inputIcon: NSImage, withName name: String) throws -> [(icon: NSImage, name: String)] {
		if inputIcon.size.width >= iOSTabBarIconType.RequiredMinSize {
			
			var icons = [(icon: NSImage, name: String)]()
			
			for (nameSuffix, size) in iOSTabBarIconType.Sizes {
				if let resizedIcon = resizeIcon(inputIcon, toSize: NSSize(width: size, height: size)) {
					icons.append((resizedIcon, name + nameSuffix))
				} else {
					print("Could not produce IOSTabBarIcon with name: \(name) for size: \(size)")
				}
			}
			
			return icons
		} else {
			throw IconSpitterError.IconNotBigEnough
		}
	}
	
	// Throws: IconSpitterError
	static private func produceIOSToolbarNavbarIconsForIcon(inputIcon: NSImage, withName name: String) throws -> [(icon: NSImage, name: String)] {
		if inputIcon.size.width >= iOSToolbarNavbarIconType.RequiredMinSize {
			
			var icons = [(icon: NSImage, name: String)]()
			
			for (nameSuffix, size) in iOSToolbarNavbarIconType.Sizes {
				if let resizedIcon = resizeIcon(inputIcon, toSize: NSSize(width: size, height: size)) {
					icons.append((resizedIcon, name + nameSuffix))
				} else {
					print("Could not produce IOSToolbarNavbarIcon with name: \(name) for size: \(size)")
				}
			}
			
			return icons
		} else {
			throw IconSpitterError.IconNotBigEnough
		}
	}
	
	// Throws: IconSpitterError
	static private func produceMacAppIconsForIcon(inputIcon: NSImage, withName name: String) throws -> [(icon: NSImage, name: String)] {
		if inputIcon.size.width >= MacAppIconType.RequiredMinSize {
			
			var icons = [(icon: NSImage, name: String)]()
			
			for (nameSuffix, size) in MacAppIconType.Sizes {
				if let resizedIcon = resizeIcon(inputIcon, toSize: NSSize(width: size, height: size)) {
					icons.append((resizedIcon, name + nameSuffix))
				} else {
					print("Could not produce MacAppIcon with name: \(name) for size: \(size)")
				}
			}
			
			return icons
		} else {
			throw IconSpitterError.IconNotBigEnough
		}
	}
	
	
	
	
	
	// -------------------------------
	// MARK: Helper Methods
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