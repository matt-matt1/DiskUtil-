//
//  String.swift
//  rEFInd prefs
//
//  Created by Yuma Technical Inc. on 2020-03-13.
//  Copyright © 2020 Yuma Technical Inc. All rights reserved.
//

import Foundation


extension String {

	/// Execute a command.  Eg. let output = "echo hello".run()
	func run() -> String? {
		let pipe = Pipe()
		let process = Process()
		process.launchPath = "/bin/sh"
		process.arguments = ["-c", self]
		process.standardOutput = pipe
		
		let fileHandle = pipe.fileHandleForReading
		process.launch()
		
		return String(data: fileHandle.readDataToEndOfFile(), encoding: .utf8)
	}
	
	/// Returns a 2D string array containing the exact match and the captured strings
	func match(_ regex: String) -> [[String]] {
		let nsString = self as NSString
		return (try? NSRegularExpression(pattern: regex, options: []))?.matches(in: self, options: [], range: NSMakeRange(0, count)).map { match in
			(0..<match.numberOfRanges).map { match.range(at: $0).location == NSNotFound ? "" : nsString.substring(with: match.range(at: $0)) }
			} ?? []
	}
	/*
	func matchingStrings(regex: String) -> [[String]] {
		guard let regex = try? NSRegularExpression(pattern: regex, options: []) else { return [] }
		let nsString = self as NSString
		let results  = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
		return results.map { result in
			(0..<result.numberOfRanges).map {
				result.range(at: $0).location != NSNotFound
					? nsString.substring(with: result.range(at: $0))
					: ""
			}
		}
	}
*/
	/*
	static func ~= (lhs: String, rhs: String) -> Bool {
		guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
		let range = NSRange(location: 0, length: lhs.utf16.count)
		return regex.firstMatch(in: lhs, options: [], range: range) != nil
	}
*/

}
