//
//  VolumeInfo.swift
//  DiskUtil+
//
//  Created by Yuma Technical Inc. on 2020-03-22.
//  Copyright © 2020 Yuma Technical Inc. All rights reserved.
//

import Foundation
//import CoreFoundation


class VolumeInfo/*: Codable*/ {

	var DAMediaBlockSize: Int	//: 512,
	var DADeviceInternal: Bool	//: 1,
	var DAVolumeName: String	//: HighSierra,
	var DAMediaEjectable: Bool	//: 0,
	var DAMediaSize: Int64	//: 249863348224,
	var DAMediaUUID: CFUUID	//: <CFUUID 0x600000021900> E09ECFF1-C6DC-11E9-920B-806E6F6E6963,
	var DADeviceProtocol: String	//: SATA,
	var DABusName: String	//: PMP,
	var DAVolumeKind: String	//: hfs,
	var DAMediaBSDUnit: Bool	//: 0,
	var DAMediaContent: String	//: 48465300-0000-11AA-AA11-00306543ECAC,
	var DAMediaBSDName: String	//: disk0s2,
	var DAAppearanceTime: Double//: 606058582.711735,
	var DAMediaWritable: Bool	//: 1,
	var DAVolumeType: String	//: Mac OS Extended (Journaled),
	var DADeviceModel: String	//: ST31000528AS                            ,
	var DAMediaIcon: NSDictionary//CFDictionary//Icon	//: {
//	},
	var DAMediaBSDMinor: Int	//: 4,
	var DAMediaName: String	//: Untitled 2,
	var DABusPath: String	//: IODeviceTree:/PCI0@0/SATA@1F,2/PRT0@0/PMP@0,
	var DAVolumeNetwork: Bool	//: 0,
	var DAMediaWhole: Bool	//: 0,
	var DADeviceUnit: Bool	//: 0,
	var DAMediaRemovable: Bool	//: 0,
	var DAVolumePath: URL//NSURL	//: file:///,
	var DAMediaKind: String	//: IOMedia,
	var DADevicePath: String	//: IOService:/AppleACPIPlatformExpert/PCI0@0/AppleACPIPCI/SATA@1F,2/AppleIntelPchSeriesAHCI/PRT0@0/IOAHCIDevice@0/AppleAHCIDiskDriver/IOAHCIBlockStorageDevice,
	var DAMediaLeaf: Bool	//: 1,
	var DADeviceRevision: String	//: AP63    ,
	var DAVolumeUUID: CFUUID	//: <CFUUID 0x600000021840> 984AD727-F862-3C80-9FAF-AF2928BBD38E,
	var DAMediaBSDMajor: Int	//: 1,
	var DAMediaPath: String	//: IODeviceTree:/PCI0@0/SATA@1F,2/PRT0@0/PMP@0/@0:2,
	var DAVolumeMountable: Bool	//: 1

	
	init(DAMediaBlockSize: Int, DADeviceInternal: Bool, DAVolumeName: String, DAMediaEjectable: Bool, DAMediaSize: Int64, DAMediaUUID: CFUUID, DADeviceProtocol: String, DABusName: String, DAVolumeKind: String, DAMediaBSDUnit: Bool, DAMediaContent: String, DAMediaBSDName: String, DAAppearanceTime: Double, DAMediaWritable: Bool, DAVolumeType: String, DADeviceModel: String, DAMediaIcon: CFDictionary/*Icon*/, DAMediaBSDMinor: Int, DAMediaName: String, DABusPath: String, DAVolumeNetwork: Bool, DAMediaWhole: Bool, DADeviceUnit: Bool, DAMediaRemovable: Bool, DAVolumePath: URL/*NSURL*/, DAMediaKind: String, DADevicePath: String, DAMediaLeaf: Bool, DADeviceRevision: String, DAVolumeUUID: CFUUID, DAMediaBSDMajor: Int, DAMediaPath: String, DAVolumeMountable: Bool) {
		self.DAMediaBlockSize = DAMediaBlockSize //: Int	//: 512,
		self.DADeviceInternal = DADeviceInternal //: Bool	//: 1,
		self.DAVolumeName = DAVolumeName //: String	//: HighSierra,
		self.DAMediaEjectable = DAMediaEjectable //: Bool	//: 0,
		self.DAMediaSize = DAMediaSize //: String	//: 249863348224,
		self.DAMediaUUID = DAMediaUUID //: String	//: <CFUUID 0x600000021900> E09ECFF1-C6DC-11E9-920B-806E6F6E6963,
		self.DADeviceProtocol = DADeviceProtocol //: String	//: SATA,
		self.DABusName = DABusName //: String	//: PMP,
		self.DAVolumeKind = DAVolumeKind //: String	//: hfs,
		self.DAMediaBSDUnit = DAMediaBSDUnit //: Bool	//: 0,
		self.DAMediaContent = DAMediaContent //: String	//: 48465300-0000-11AA-AA11-00306543ECAC,
		self.DAMediaBSDName = DAMediaBSDName //: String	//: disk0s2,
		self.DAAppearanceTime = DAAppearanceTime //: Double//: 606058582.711735,
		self.DAMediaWritable = DAMediaWritable //: Bool	//: 1,
		self.DAVolumeType = DAVolumeType //: String	//: Mac OS Extended (Journaled),
		self.DADeviceModel = DADeviceModel //: String	//: ST31000528AS                            ,
		self.DAMediaIcon = DAMediaIcon //: Icon	//: {
		//	},
		self.DAMediaBSDMinor = DAMediaBSDMinor //: Int	//: 4,
		self.DAMediaName = DAMediaName //: String	//: Untitled 2,
		self.DABusPath = DABusPath //: String	//: IODeviceTree:/PCI0@0/SATA@1F,2/PRT0@0/PMP@0,
		self.DAVolumeNetwork = DAVolumeNetwork //: Bool	//: 0,
		self.DAMediaWhole = DAMediaWhole //: Bool	//: 0,
		self.DADeviceUnit = DADeviceUnit //: Bool	//: 0,
		self.DAMediaRemovable = DAMediaRemovable //: Bool	//: 0,
		self.DAVolumePath = DAVolumePath //: String	//: file:///,
		self.DAMediaKind = DAMediaKind //: String	//: IOMedia,
		self.DADevicePath = DADevicePath //: String	//: IOService:/AppleACPIPlatformExpert/PCI0@0/AppleACPIPCI/SATA@1F,2/AppleIntelPchSeriesAHCI/PRT0@0/IOAHCIDevice@0/AppleAHCIDiskDriver/IOAHCIBlockStorageDevice,
		self.DAMediaLeaf = DAMediaLeaf //: Bool	//: 1,
		self.DADeviceRevision = DADeviceRevision //: String	//: AP63    ,
		self.DAVolumeUUID = DAVolumeUUID //: String	//: <CFUUID 0x600000021840> 984AD727-F862-3C80-9FAF-AF2928BBD38E,
		self.DAMediaBSDMajor = DAMediaBSDMajor //: Int	//: 1,
		self.DAMediaPath = DAMediaPath //: String	//: IODeviceTree:/PCI0@0/SATA@1F,2/PRT0@0/PMP@0/@0:2,
		self.DAVolumeMountable = DAVolumeMountable //: Bool	//: 1
	}

}


class Icon: Codable {

	/*CFBundleIdentifier =*/ var ioStorageFamily: String	//com.apple.iokit.IOStorageFamily //;
	/*IOBundleResourceFile =*/ var icns: String	//Internal.icns //;

	init(ioStorageFamily: String, icns: String) {
		self.ioStorageFamily = ioStorageFamily
		self.icns = icns
	}

}
