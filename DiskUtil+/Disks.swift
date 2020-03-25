//
//  Disks.swift
//  viewMount
//
//  Created by Yuma Technical Inc. on 2020-03-16.
//  Copyright © 2020 Yuma Technical Inc. All rights reserved.
//

import Foundation


class Disks {
	
	/// On success opens and returns a Disk Arbitration session
	/*private*/ func openSession(onSuccess: ((_ session: DASession) -> ())?) {
		if let session = DASessionCreate(kCFAllocatorDefault) {
			onSuccess?(session)
		}
	}
	
	/// On success returns the DA session and an array of volume URLs
	func getMountedVolumes(onSuccess: ((_ vols: [URL]) -> ())?/*, onFail: ((_ error: Error?) -> ())?*/) {
		let keys = [URLResourceKey.volumeNameKey, URLResourceKey.volumeIsRemovableKey, URLResourceKey.volumeIsEjectableKey]
		onSuccess?(FileManager.default.mountedVolumeURLs(includingResourceValuesForKeys: keys, options: [FileManager.VolumeEnumerationOptions.produceFileReferenceURLs])!)
	}

	func getVolumeInfoObject(session: DASession, volumeURL: URL, onSuccess: ((_ info: VolumeInfo?) -> ())?) {
		var info: VolumeInfo?
		getVolumeInfo(session: session, volumeURL: volumeURL) { (dict) in
			info = VolumeInfo(DAMediaBlockSize: dict["DAMediaBlockSize"] as! Int,
							  DADeviceInternal: (dict["DADeviceInternal"] != nil),
							  DAVolumeName: dict["DAVolumeName"] as! String,
							  DAMediaEjectable: (dict["DAMediaEjectable"] != nil),
							  DAMediaSize: dict["DAMediaSize"] as! Int64,
							  DAMediaUUID: dict["DAMediaUUID"] as! CFUUID,
							  DADeviceProtocol: dict["DADeviceProtocol"] as! String,
							  DABusName: dict["DABusName"] as! String,
							  DAVolumeKind: dict["DAVolumeKind"] as! String,
							  DAMediaBSDUnit: (dict["DAMediaBSDUnit"] != nil),
							  DAMediaContent: dict["DAMediaContent"] as! String,
							  DAMediaBSDName: dict["DAMediaBSDName"] as! String,
							  DAAppearanceTime: dict["DAAppearanceTime"] as! Double,
							  DAMediaWritable: (dict["DAMediaWritable"] != nil),
							  DAVolumeType: dict["DAVolumeType"] as! String,
							  DADeviceModel: dict["DADeviceModel"] as! String,
							  DAMediaIcon: dict["DAMediaIcon"] as! CFDictionary,
							  DAMediaBSDMinor: dict["DAMediaBSDMinor"] as! Int,
							  DAMediaName: dict["DAMediaName"] as! String,
							  DABusPath: dict["DABusPath"] as! String,
							  DAVolumeNetwork: (dict["DAVolumeNetwork"] != nil),
							  DAMediaWhole: (dict["DAMediaWhole"] != nil),
							  DADeviceUnit: (dict["DADeviceUnit"] != nil),
							  DAMediaRemovable: (dict["DAMediaRemovable"] != nil),
							  DAVolumePath: dict["DAVolumePath"] as! URL,
							  DAMediaKind: dict["DAMediaKind"] as! String,
							  DADevicePath: dict["DADevicePath"] as! String,
							  DAMediaLeaf: (dict["DAMediaLeaf"] != nil),
							  DADeviceRevision: dict["DADeviceRevision"] as! String,
							  DAVolumeUUID: dict["DAVolumeUUID"] as! CFUUID,
							  DAMediaBSDMajor: dict["DAMediaBSDMajor"] as! Int,
							  DAMediaPath: dict["DAMediaPath"] as! String,
							  DAVolumeMountable: (dict["DAVolumeMountable"] != nil))
			onSuccess?(info)
		}
	}

	// On success returns a NSDictionary of attributes about the disk on the given volume(s) within a DA session
	func getVolumeInfo(session: DASession, volumeURL: URL, onSuccess: (([String: AnyObject]) -> ())?) {
		if let disk = DADiskCreateFromVolumePath(kCFAllocatorDefault, session, volumeURL as CFURL),
			let bsdName = DADiskGetBSDName(disk) {
			
			if var diskInfo = DADiskCopyDescription(disk) as? [String: AnyObject] {
				diskInfo["bsdName"] = bsdName as AnyObject
				let bsdStr = String(cString: bsdName)
				diskInfo["bsdString"] = bsdStr as AnyObject
				onSuccess?(diskInfo)
				/*[
				"DAMediaBlockSize": 512,
				"DADeviceInternal": 1,
				"DAVolumeName": HighSierra,
				"DAMediaEjectable": 0,
				"DAMediaSize": 249863348224,
				"DAMediaUUID": <CFUUID 0x600000021900> E09ECFF1-C6DC-11E9-920B-806E6F6E6963,
				"DADeviceProtocol": SATA,
				"DABusName": PMP,
				"DAVolumeKind": hfs,
				"DAMediaBSDUnit": 0,
				"DAMediaContent": 48465300-0000-11AA-AA11-00306543ECAC,
				"DAMediaBSDName": disk0s2,
				"DAAppearanceTime": 606058582.711735,
				"DAMediaWritable": 1,
				"DAVolumeType": Mac OS Extended (Journaled),
				"DADeviceModel": ST31000528AS                            ,
				"DAMediaIcon": {
				CFBundleIdentifier = "com.apple.iokit.IOStorageFamily";
				IOBundleResourceFile = "Internal.icns";
				},
				"DAMediaBSDMinor": 4,
				"DAMediaName": Untitled 2,
				"DABusPath": IODeviceTree:/PCI0@0/SATA@1F,2/PRT0@0/PMP@0,
				"DAVolumeNetwork": 0,
				"DAMediaWhole": 0,
				"DADeviceUnit": 0,
				"DAMediaRemovable": 0,
				"DAVolumePath": file:///,
				"DAMediaKind": IOMedia,
				"DADevicePath": IOService:/AppleACPIPlatformExpert/PCI0@0/AppleACPIPCI/SATA@1F,2/AppleIntelPchSeriesAHCI/PRT0@0/IOAHCIDevice@0/AppleAHCIDiskDriver/IOAHCIBlockStorageDevice,
				"DAMediaLeaf": 1,
				"DADeviceRevision": AP63    ,
				"DAVolumeUUID": <CFUUID 0x600000021840> 984AD727-F862-3C80-9FAF-AF2928BBD38E,
				"DAMediaBSDMajor": 1,
				"DAMediaPath": IODeviceTree:/PCI0@0/SATA@1F,2/PRT0@0/PMP@0/@0:2,
				"DAVolumeMountable": 1
				]*/
			}//diskInfo
		}//disk, bsdName
	}


}
