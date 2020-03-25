//
//  DiskDetails.swift
//  DiskUtil+
//
//  Created by Yuma Technical Inc. on 2020-03-21.
//  Copyright © 2020 Yuma Technical Inc. All rights reserved.
//

import Foundation


class DiskDetails/*: Codable*/ {

	var volumeSize: NSNumber//Int32
	var content: String
	var canBeMadeBootable: Bool
	var ejectableMediaAutomaticUnderSoftwareControl: Bool
	var busProtocol: String
	var ioKitSize: Int64
	var isInternal: Bool
	var ejectableOnly: Bool
	var volumeName: String
	var removableMediaOrExternalDevice: Bool
	var os9DriversInstalled: Bool
	var systemImage: Bool
//	var virtualOrPhysical: Bool
	var deviceNode: String
	var totalSize: Int64
	var mediaName: String
	var bootable: Bool
	var supportsGlobalPermissionsDisable: Bool
	var smartStatus: String
	var mountPoint: String
	var smartDeviceSpecificKeysMayVaryNotGuaranteed: Bool
	var canBeMadeBootableRequiresDestroy: Bool
	var raidMaster: Bool
	var size: Int64
	var writableVolume: Bool
	var parentWholeDisk: String
	var ioRegistryEntryName: String
	var wholeDisk: Bool
	var solidState: Bool
	var ejectable: Bool
	var raidSlice: Bool
	var deviceTreePath: String
	var lowLevelFormatSupported: Bool
	var freeSpace: Int64
	var globalPermissionsEnabled: Bool
	var aesHardware: Bool
	var partitionMapPartition: Bool
	var mediaType: String
	var removableMedia: Bool
	var deviceIdentifier: String
	var deviceBlockSize: Int
	var writable: Bool
	var removable: Bool
	var writableMedia: Bool
	
	
	init(volumeSize: NSNumber/*Int32*/, content: String, canBeMadeBootable: Bool, ejectableMediaAutomaticUnderSoftwareControl: Bool, busProtocol: String, ioKitSize: Int64, isInternal: Bool, ejectableOnly: Bool, volumeName: String, removableMediaOrExternalDevice: Bool, os9DriversInstalled: Bool, systemImage: Bool, /*virtualOrPhysical: Bool,*/ deviceNode: String, totalSize: Int64, mediaName: String, bootable: Bool, supportsGlobalPermissionsDisable: Bool, smartStatus: String, mountPoint: String, smartDeviceSpecificKeysMayVaryNotGuaranteed: Bool, canBeMadeBootableRequiresDestroy: Bool, raidMaster: Bool, size: Int64, writableVolume: Bool, parentWholeDisk: String, ioRegistryEntryName: String, wholeDisk: Bool, solidState: Bool, ejectable: Bool, raidSlice: Bool, deviceTreePath: String, lowLevelFormatSupported: Bool, freeSpace: Int64, globalPermissionsEnabled: Bool, aesHardware: Bool, partitionMapPartition: Bool, mediaType: String, removableMedia: Bool, deviceIdentifier: String, deviceBlockSize: Int, writable: Bool, removable: Bool, writableMedia: Bool) {
		self.volumeSize = volumeSize
		self.content = content
		self.canBeMadeBootable = canBeMadeBootable
		self.ejectableMediaAutomaticUnderSoftwareControl = ejectableMediaAutomaticUnderSoftwareControl
		self.busProtocol = busProtocol
		self.ioKitSize = ioKitSize
		self.isInternal = isInternal
		self.ejectableOnly = ejectableOnly
		self.volumeName = volumeName
		self.removableMediaOrExternalDevice = removableMediaOrExternalDevice
		self.os9DriversInstalled = os9DriversInstalled
		self.systemImage = systemImage
//		self.virtualOrPhysical = virtualOrPhysical
		self.deviceNode = deviceNode
		self.totalSize = totalSize
		self.mediaName = mediaName
		self.bootable = bootable
		self.supportsGlobalPermissionsDisable = supportsGlobalPermissionsDisable
		self.smartStatus = smartStatus
		self.mountPoint = mountPoint
		self.smartDeviceSpecificKeysMayVaryNotGuaranteed = smartDeviceSpecificKeysMayVaryNotGuaranteed
		self.canBeMadeBootableRequiresDestroy = canBeMadeBootableRequiresDestroy
		self.raidMaster = raidMaster
		self.size = size
		self.writableVolume = writableVolume
		self.parentWholeDisk = parentWholeDisk
		self.ioRegistryEntryName = ioRegistryEntryName
		self.wholeDisk = wholeDisk
		self.solidState = solidState
		self.ejectable = ejectable
		self.raidSlice = raidSlice
		self.deviceTreePath = deviceTreePath
		self.lowLevelFormatSupported = lowLevelFormatSupported
		self.freeSpace = freeSpace
		self.globalPermissionsEnabled = globalPermissionsEnabled
		self.aesHardware = aesHardware
		self.partitionMapPartition = partitionMapPartition
		self.mediaType = mediaType
		self.removableMedia = removableMedia
		self.deviceIdentifier = deviceIdentifier
		self.deviceBlockSize = deviceBlockSize
		self.writable = writable
		self.removable = removable
		self.writableMedia = writableMedia
	}


}
