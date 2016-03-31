//
//  JSON.swift
//  Icon Builder
//
//  Created by Vegard Solheim Theriault on 31/03/16.
//  Copyright © 2016 Vegard Solheim Theriault. All rights reserved.
//

import Foundation




// -------------------------------
// MARK: iOS App Icon
// -------------------------------

let iOSAppIconJSON = [
    "images" : [
        iphone29_1x,
        iphone29_2x,
        iphone29_3x,
        iphone40_2x,
        iphone40_3x,
        iphone57_1x,
        iphone57_2x,
        iphone60_2x,
        iphone60_3x,
        ipad29_1x,
        ipad29_2x,
        ipad40_1x,
        ipad40_2x,
        ipad50_1x,
        ipad50_2x,
        ipad72_1x,
        ipad72_2x,
        ipad76_1x,
        ipad76_2x,
        ipad83_5_2x
    ],
    "info" : [
        "version" : 1,
        "author" : "xcode"
    ]
]

private let iphone29_1x = [
    "size" : "29x29",
    "idiom" : "iphone",
    "filename" : "AppIcon_29.png",
    "scale" : "1x"
]
private let iphone29_2x = [
    "size" : "29x29",
    "idiom" : "iphone",
    "filename" : "AppIcon_58.png",
    "scale" : "2x"
]
private let iphone29_3x = [
    "size" : "29x29",
    "idiom" : "iphone",
    "filename" : "AppIcon_87.png",
    "scale" : "3x"
]
private let iphone40_2x = [
    "size" : "40x40",
    "idiom" : "iphone",
    "filename" : "AppIcon_80.png",
    "scale" : "2x"
]
private let iphone40_3x = [
    "size" : "40x40",
    "idiom" : "iphone",
    "filename" : "AppIcon_120.png",
    "scale" : "3x"
]
private let iphone57_1x = [
    "size" : "57x57",
    "idiom" : "iphone",
    "filename" : "AppIcon_57.png",
    "scale" : "1x"
]
private let iphone57_2x = [
    "size" : "57x57",
    "idiom" : "iphone",
    "filename" : "AppIcon_114.png",
    "scale" : "2x"
]
private let iphone60_2x = [
    "size" : "60x60",
    "idiom" : "iphone",
    "filename" : "AppIcon_120.png",
    "scale" : "2x"
]
private let iphone60_3x = [
    "size" : "60x60",
    "idiom" : "iphone",
    "filename" : "AppIcon_180.png",
    "scale" : "3x"
]
private let ipad29_1x = [
    "size" : "29x29",
    "idiom" : "ipad",
    "filename" : "AppIcon_29.png",
    "scale" : "1x"
]
private let ipad29_2x = [
    "size" : "29x29",
    "idiom" : "ipad",
    "filename" : "AppIcon_58.png",
    "scale" : "2x"
]
private let ipad40_1x = [
    "size" : "40x40",
    "idiom" : "ipad",
    "filename" : "AppIcon_40.png",
    "scale" : "1x"
]
private let ipad40_2x = [
    "size" : "40x40",
    "idiom" : "ipad",
    "filename" : "AppIcon_80.png",
    "scale" : "2x"
]
private let ipad50_1x = [
    "size" : "50x50",
    "idiom" : "ipad",
    "filename" : "AppIcon_50.png",
    "scale" : "1x"
]
private let ipad50_2x = [
    "size" : "50x50",
    "idiom" : "ipad",
    "filename" : "AppIcon_100.png",
    "scale" : "2x"
]
private let ipad72_1x = [
    "size" : "72x72",
    "idiom" : "ipad",
    "filename" : "AppIcon_72.png",
    "scale" : "1x"
]
private let ipad72_2x = [
    "size" : "72x72",
    "idiom" : "ipad",
    "filename" : "AppIcon_144.png",
    "scale" : "2x"
]
private let ipad76_1x = [
    "size" : "76x76",
    "idiom" : "ipad",
    "filename" : "AppIcon_76.png",
    "scale" : "1x"
]
private let ipad76_2x = [
    "size" : "76x76",
    "idiom" : "ipad",
    "filename" : "AppIcon_152.png",
    "scale" : "2x"
]
private let ipad83_5_2x = [
    "idiom" : "ipad",
    "size" : "83.5x83.5",
    "filename" : "AppIcon_167.png",
    "scale" : "2x"
]



// -------------------------------
// MARK: OS X App Icon
// -------------------------------

let OSXAppIconJSON = [
    "images" : [
        mac16_1x,
        mac16_2x,
        mac32_1x,
        mac32_2x,
        mac128_1x,
        mac128_2x,
        mac256_1x,
        mac256_2x,
        mac512_1x,
        mac512_2x
    ],
    "info" : [
        "version" : 1,
        "author" : "xcode"
    ]
]

private let mac16_1x = [
    "idiom" : "mac",
    "size" : "16x16",
    "filename": "AppIcon_16.png",
    "scale" : "1x"
]
private let mac16_2x = [
    "idiom" : "mac",
    "size" : "16x16",
    "filename": "AppIcon_32.png",
    "scale" : "2x"
]
private let mac32_1x = [
    "idiom" : "mac",
    "size" : "32x32",
    "filename": "AppIcon_32.png",
    "scale" : "1x"
]
private let mac32_2x = [
    "idiom" : "mac",
    "size" : "32x32",
    "filename": "AppIcon_64.png",
    "scale" : "2x"
]
private let mac128_1x = [
    "idiom" : "mac",
    "size" : "128x128",
    "filename": "AppIcon_128.png",
    "scale" : "1x"
]
private let mac128_2x = [
    "idiom" : "mac",
    "size" : "128x128",
    "filename": "AppIcon_256.png",
    "scale" : "2x"
]
private let mac256_1x = [
    "idiom" : "mac",
    "size" : "256x256",
    "filename": "AppIcon_256.png",
    "scale" : "1x"
]
private let mac256_2x = [
    "idiom" : "mac",
    "size" : "256x256",
    "filename": "AppIcon_512.png",
    "scale" : "2x"
]
private let mac512_1x = [
    "idiom" : "mac",
    "size" : "512x512",
    "filename": "AppIcon_512.png",
    "scale" : "1x"
]
private let mac512_2x = [
    "idiom" : "mac",
    "size" : "512x512",
    "filename": "AppIcon_1024.png",
    "scale" : "2x"
]
