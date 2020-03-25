//
//  DiskSize.swift
//  DiskUtil+
//
//  Created by Yuma Technical Inc. on 2020-03-19.
//  Copyright © 2020 Yuma Technical Inc. All rights reserved.
//

import Foundation


extension ViewController {
	
	/// Returns a string of the human readable size (MB,GB,...) of supplied integer
	func humanReadableByteCount(_ bytes: Int64) -> String {
		if (bytes < 1024) { return "\(bytes) B" }
		let exp = Int(log2(Double(bytes)) / log2(1000.0))
		let unit = ["KB", "MB", "GB", "TB", "PB", "EB"][exp - 1]
		let number = Double(bytes) / pow(1001, Double(exp))
//		
		return String(format: "%.1f %@", number, unit)
//
//		if exp <= 1 || number >= 100 {
//			return String(format: "%.0f %@", number, unit)
//		} else {
//			return String(format: "%.1f %@", number, unit)
//				.replacingOccurrences(of: ".0", with: "")
//		}
	}


}
