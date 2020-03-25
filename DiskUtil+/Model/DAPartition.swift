//
//  DAPartition.swift
//  DiskUtil+
//
//  Created by Yuma Technical Inc. on 2020-03-22.
//  Copyright © 2020 Yuma Technical Inc. All rights reserved.
//

import Cocoa


class DAPartition/*: Codable*/ {

	var DiskUUID: String
	var DeviceIdentifier: String
	var Size: Int64
	var MountPoint: String?
	/// format
	var Content: String
	var VolumeName: String
	var VolumeUUID: String
	var details: DiskDetails
	
	
	init(DiskUUID: String, DeviceIdentifier: String, Size: Int64, MountPoint: String?, Content: String, VolumeName: String, VolumeUUID: String, details: DiskDetails) {
		self.DiskUUID = DiskUUID
		self.DeviceIdentifier = DeviceIdentifier
		self.Size = Size
		self.MountPoint = MountPoint
		self.Content = Content
		self.VolumeName = VolumeName
		self.VolumeUUID = VolumeUUID
		self.details = details
	}


}
