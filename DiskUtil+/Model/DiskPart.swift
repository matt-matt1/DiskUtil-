//
//  DiskPart.swift
//  DiskUtil+
//
//  Created by Yuma Technical Inc. on 2020-03-22.
//  Copyright © 2020 Yuma Technical Inc. All rights reserved.
//

import Cocoa


class DADiskPart/*: Codable*/ {

	var Content: String
	var Size: Int64
	var DeviceIdentifier: String
	var Partitions: [DAPartition]
	var details: DiskDetails
	
	
	init(Content: String, Size: Int64, DeviceIdentifier: String, Partitions: [DAPartition], details: DiskDetails) {
		self.Content = Content
		self.Size = Size
		self.DeviceIdentifier = DeviceIdentifier
		self.Partitions = Partitions
		self.details = details
	}


}
