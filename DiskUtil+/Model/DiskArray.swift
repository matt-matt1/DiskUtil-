//
//  DiskDictArray.swift
//  DiskUtil+
//
//  Created by Yuma Technical Inc. on 2020-03-20.
//  Copyright © 2020 Yuma Technical Inc. All rights reserved.
//

import Foundation


class DiskArray/*: Codable*/ {

	var VolumesFromDisks: [String]
	var WholeDisks: [String]
	var AllDisks: [String]
	var AllDisksAndPartitions: [DADiskPart]

	
	init(VolumesFromDisks: [String], WholeDisks: [String], AllDisks: [String], AllDisksAndPartitions: [DADiskPart]) {
		self.VolumesFromDisks = VolumesFromDisks
		self.WholeDisks = WholeDisks
		self.AllDisks = AllDisks
		self.AllDisksAndPartitions = AllDisksAndPartitions
	}


}
