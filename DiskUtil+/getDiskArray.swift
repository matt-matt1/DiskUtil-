//
//  getDiskArray.swift
//  DiskUtil+
//
//  Created by Yuma Technical Inc. on 2020-03-20.
//  Copyright © 2020 Yuma Technical Inc. All rights reserved.
//

import Foundation


extension ViewController {
	
	func getDiskArray() -> [String : AnyObject] {
		var format = PropertyListSerialization.PropertyListFormat.xml
		let output = "/usr/sbin/diskutil list -plist".run()
		let outData = output?.data(using: String.Encoding.utf8)
		var diskDict: [String : AnyObject] = [:]
		do {
			diskDict = try PropertyListSerialization.propertyList(from: outData!, options: PropertyListSerialization.ReadOptions.mutableContainersAndLeaves, format: &format) as! [String : AnyObject]
			return diskDict
		} catch {
			print("plist error: \(error) - format \(format)")
		}
		return [:]
	}
	
	
	func getDiskDetails(_ disk: String) -> [String : AnyObject] {
		var format = PropertyListSerialization.PropertyListFormat.xml
		let output = "diskutil info -plist \(disk)".run()
		let outData = output?.data(using: String.Encoding.utf8)
		var diskDict: [String : AnyObject] = [:]
		do {
			diskDict = try PropertyListSerialization.propertyList(from: outData!, options: PropertyListSerialization.ReadOptions.mutableContainersAndLeaves, format: &format) as! [String : AnyObject]
			return diskDict
		} catch {
			print("plist error: \(error) - format \(format)")
		}
		return [:]
	}
	
	
	func getDiskDetailsObject(_ disk: String) -> DiskDetails {
		let details = getDiskDetails(disk)
		let data = DiskDetails(volumeSize: details["VolumeSize"] as! NSNumber,
							   content: details["Content"] as! String,
							   canBeMadeBootable: (details["CanBeMadeBootable"] != nil),
							   ejectableMediaAutomaticUnderSoftwareControl: (details["EjectableMediaAutomaticUnderSoftwareControl"] != nil),
							   busProtocol: details["BusProtocol"] as! String,
							   ioKitSize: details["IOKitSize"] as! Int64,
							   isInternal: (details["Internal"] != nil),
							   ejectableOnly: (details["EjectableOnly"] != nil),
							   volumeName: details["VolumeName"] as! String,
							   removableMediaOrExternalDevice: (details["RemovableMediaOrExternalDevice"] != nil),
							   os9DriversInstalled: (details["OS9DriversInstalled"] != nil),
							   systemImage: (details["SystemImage"] != nil),
							   /*virtualOrPhysical: (details["VirtualOrPhysical"] != nil),*/
							   deviceNode: details["DeviceNode"] as! String,
							   totalSize: details["TotalSize"] as! Int64,
							   mediaName: details["MediaName"] as! String,
							   bootable: (details["Bootable"] != nil),
							   supportsGlobalPermissionsDisable: (details["SupportsGlobalPermissionsDisable"] != nil),
							   smartStatus: details["SMARTStatus"] as! String,
							   mountPoint: details["MountPoint"] as! String,
							   smartDeviceSpecificKeysMayVaryNotGuaranteed: (details["SMARTDeviceSpecificKeysMayVaryNotGuaranteed"] != nil),
							   canBeMadeBootableRequiresDestroy: (details["CanBeMadeBootableRequiresDestroy"] != nil),
							   raidMaster: (details["RaidMaster"] != nil),
							   size: details["Size"] as! Int64,
							   writableVolume: details["WritableVolume"] as! Bool,
							   parentWholeDisk: details["ParentWholeDisk"] as! String,
							   ioRegistryEntryName: details["IORegistryEntryName"] as! String,
							   wholeDisk: (details["WholeDisk"] != nil),
							   solidState: (details["SolidState"] != nil),
							   ejectable: (details["Ejectable"] != nil),
							   raidSlice: (details["RAIDSlice"] != nil),
							   deviceTreePath: details["DeviceTreePath"] as! String,
							   lowLevelFormatSupported: (details["LowLevelFormatSupported"] != nil),
							   freeSpace: details["FreeSpace"] as! Int64,
							   globalPermissionsEnabled: (details["GlobalPermissionsEnabled"] != nil),
							   aesHardware: details["AESHardware"] as! Bool,
							   partitionMapPartition: details["PartitionMapPartition"] as! Bool,
							   mediaType: details["MediaType"] as! String,
							   removableMedia: (details["RemovableMedia"] != nil),
							   deviceIdentifier: details["DeviceIdentifier"] as! String,
							   deviceBlockSize: details["DeviceBlockSize"] as! Int,
							   writable: (details["Writable"] != nil),
							   removable: (details["Removable"] != nil),
							   writableMedia: (details["WritableMedia"] != nil))
		return data
	}
	
	
	func fillDiskArray() -> DiskArray? {
		if let diskArray = getDiskArray() as? [String : NSArray] {
			let vols = diskArray["VolumesFromDisks"] as! [String]
			let whl = diskArray["WholeDisks"] as! [String]
			let ald = diskArray["AllDisks"] as! [String]
			var myDisksParts: [DADiskPart] = []
			let adp = diskArray["AllDisksAndPartitions"]
			if let disks = adp?[0] as? [String : AnyObject] {
				if let parts = disks["Partitions"] as? [[String : AnyObject]] {
					var myParts: [DAPartition] = []
					for part in parts {
						let details = getDiskDetailsObject(part["DeviceIdentifier"] as! String)
						myParts.append(DAPartition(DiskUUID: part["DiskUUID"] as! String,
												   DeviceIdentifier: part["DeviceIdentifier"] as! String,
												   Size: part["Size"] as! Int64,
												   MountPoint: part["MountPoint"] as? String,
												   Content: part["Content"] as! String,
												   VolumeName: part["VolumeName"] as! String,
												   VolumeUUID: part["VolumeUUID"] as! String,
												   details: details))
					}
					let details = getDiskDetailsObject(disks["DeviceIdentifier"] as! String)
					myDisksParts.append(DADiskPart(Content: disks["Content"] as! String,
												   Size: disks["Size"] as! Int64,
												   DeviceIdentifier: disks["DeviceIdentifier"] as! String,
												   Partitions: myParts,
												   details: details))
				}
			}
			myDisks = DiskArray(VolumesFromDisks: vols, WholeDisks: whl, AllDisks: ald, AllDisksAndPartitions: myDisksParts)
		}
		return myDisks
	}


}
