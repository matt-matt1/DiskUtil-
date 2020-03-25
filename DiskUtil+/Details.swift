//
//  Details.swift
//  DiskUtil+
//
//  Created by Yuma Technical Inc. on 2020-03-23.
//  Copyright © 2020 Yuma Technical Inc. All rights reserved.
//

import Cocoa


extension ViewController {
	
	func detailsDisk(_ table: NSOutlineView) {
		if let volume = myDisks?.AllDisksAndPartitions[max(0, table.clickedColumn)] {
			nameField.setAccessibilityIdentifier(volume.details.deviceIdentifier)
			journalBtn.isHidden = true
			switch (volume.details.busProtocol) {
			case "SATA":
				detailsImage.image = NSImage(named: "sata")
			case "CD":
				detailsImage.image = NSImage(named: "CD")
				//				case "SATA":
			//					volImage.image = NSImage(named: "otherMedia")
			default:
				detailsImage.image = NSImage(named: "otherMedia")
			}
			var text = volume.details.ioRegistryEntryName
			if text.isEmpty {
				text = volume.DeviceIdentifier
			}
			nameField.stringValue = text
			var info = ""//GUID Partition Map
			let type = "\(volume.details.busProtocol) \(volume.details.isInternal ? "Internal" : "External") \(volume.details.removable ? "Physical" : "Removable") Disk"
			if !volume.Content.isEmpty {
				info = volume.Content
			}
			moreInfo.stringValue = "\(type) • \(info)"
			capacityLabel.stringValue = formatter.string(fromByteCount: volume.Size)//self.humanReadableByteCount(volume.Size)
//			if volume.MountPoint != nil {
				detailsMountedDisk(volume, table)
//			} else {
//				detailsUnmountedDisk(volume)
//			}
		}
	}
	
	func detailsUnmountedDisk(_ volume: DADiskPart) {
		mountBtn.isHidden = false
		mountBtn.setAccessibilityIdentifier(volume.details.deviceIdentifier)
		openBtn.isHidden = true
		unmountBtn.isHidden = true
		let bar = NSView()
		bar.wantsLayer = true
		bar.layer?.backgroundColor = NSColor.lightGray.cgColor
		bar.translatesAutoresizingMaskIntoConstraints = false
		self.usageBox.addSubview(bar)
		NSLayoutConstraint.activate([
			bar.topAnchor.constraint(equalTo: self.usageBox.topAnchor),
			bar.leadingAnchor.constraint(equalTo: self.usageBox.leadingAnchor),
			bar.bottomAnchor.constraint(equalTo: self.usageBox.bottomAnchor),
			bar.trailingAnchor.constraint(equalTo: self.usageBox.trailingAnchor)
			])
		//		self.usageBox.layout()
		usageLegend.arrangedSubviews.forEach { (sub) in
			sub.removeFromSuperview()
		}
		usageNote.stringValue = "Not Mounted"
		
		self.detailsTable1Vals = [/* Location: */"Not Mounted", /* Connection: */formatter.string(fromByteCount: volume.Size)/*self.humanReadableByteCount(volume.Size)*/, /* Partition Map: */"Not Available", /* SMART Status: */"Not Known"]
		self.detailsTable1.reloadData()
		self.detailsTable2Vals = [/* Capacity: */"\(volume.details.isInternal ? "Internal" : "External")", /* Child Count: */"Disabled", /* Type: */"\(volume.details.busProtocol)", /* Device: */"\(volume.details.deviceNode)"]
		self.detailsTable2.reloadData()
	}

	func detailsMountedDisk(_ volume: DADiskPart, _ table: NSOutlineView) {
		mountBtn.isHidden = true
		unmountBtn.isHidden = false
		unmountBtn.setAccessibilityIdentifier(volume.details.deviceIdentifier)
		openBtn.isHidden = true
		usageLegend.arrangedSubviews.forEach { (sub) in
			sub.removeFromSuperview()
		}
		//			DispatchQueue.main.async {
		//				self.usageBox.subviews.forEach { (sub) in
		//					sub.removeFromSuperview()
		//				}
		//			}
		let colors = [NSColor.systemBlue, NSColor.magenta, NSColor.orange, NSColor.systemGreen, NSColor.yellow, NSColor.systemPurple, NSColor.systemRed, NSColor.systemBrown, NSColor.cyan, NSColor.black, NSColor.white, NSColor.blue, NSColor.brown, NSColor.gridColor, NSColor.orange, NSColor.systemGray]
		var lastConstant: CGFloat = 0
		for i in 0..<myDisks!.AllDisksAndPartitions[max(0, table.clickedColumn)].Partitions.count {
			let myDisk = myDisks!.AllDisksAndPartitions[max(0, table.clickedColumn)]
			let myPart = myDisks!.AllDisksAndPartitions[max(0, table.clickedColumn)].Partitions[i]
			let used = myPart.Size
			let ratio: Float64 = Float64(used) / Float64(myDisk.Size)
			let mySize: CGFloat = max(CGFloat(ratio) * usageBox.frame.width, 5)/*CGFloat(ratio * 595)*/
			//				DispatchQueue.main.async {
			self.usageLegend.addArrangedSubview(self.legendKey(color: colors[i], title: myPart.VolumeName, message: self.formatter.string(fromByteCount: myPart.Size)))
			let bar = NSView()
			bar.wantsLayer = true
			bar.layer?.backgroundColor = colors[i].cgColor
			bar.translatesAutoresizingMaskIntoConstraints = false
			self.usageBox.addSubview(bar)
			NSLayoutConstraint.activate([
				bar.topAnchor.constraint(equalTo: self.usageBox.topAnchor),
				bar.leadingAnchor.constraint(equalTo: self.usageBox.leadingAnchor, constant: lastConstant),
				bar.bottomAnchor.constraint(equalTo: self.usageBox.bottomAnchor),
				bar.widthAnchor.constraint(equalToConstant: mySize)
				])
			self.usageBox.layout()
			lastConstant += mySize
			//				}
		}
		mountBtn.isHidden = true
		self.detailsTable1Data = ["Location:", "Connection:", "Partition Map:", "SMART Status:"]
		self.detailsTable1Vals = [/* Location: */"\(volume.details.isInternal ? "Internal" : "External")", /* Connection: */"\(volume.details.busProtocol)", /* Partition Map: */"\(volume.details.partitionMapPartition)", /* SMART Status: */"\(volume.details.smartStatus)"]
		self.detailsTable1.reloadData()
		self.detailsTable2Data = ["Capacity", "Child Count:", "Type", "Device"]
		self.detailsTable2Vals = [/* Capacity: */formatter.string(fromByteCount: volume.Size)/*self.humanReadableByteCount(volume.Size)*/, /* Child Count: */"\(volume.Partitions.count)", /* Type: */"Disk", /* Device: */"\(volume.details.deviceNode)"]
		self.detailsTable2.reloadData()
	}

	func detailsUnmountedPartition(_ volume: DAPartition) {
//		DispatchQueue.main.async {
//			self.usageBox.subviews.forEach { (sub) in
//				sub.removeFromSuperview()
//			}
//		}
		mountBtn.isHidden = false
		mountBtn.setAccessibilityIdentifier(volume.details.deviceIdentifier)
		unmountBtn.isHidden = true
		openBtn.isHidden = true
		let bar = NSView()
		bar.wantsLayer = true
		bar.layer?.backgroundColor = NSColor.lightGray.cgColor
		bar.translatesAutoresizingMaskIntoConstraints = false
		self.usageBox.addSubview(bar)
		NSLayoutConstraint.activate([
			bar.topAnchor.constraint(equalTo: self.usageBox.topAnchor),
			bar.leadingAnchor.constraint(equalTo: self.usageBox.leadingAnchor),
			bar.bottomAnchor.constraint(equalTo: self.usageBox.bottomAnchor),
			bar.trailingAnchor.constraint(equalTo: self.usageBox.trailingAnchor)
			])
//		self.usageBox.layout()
		usageLegend.arrangedSubviews.forEach { (sub) in
			sub.removeFromSuperview()
		}
		usageNote.stringValue = "Not Mounted"

		self.detailsTable1Vals = [/* Mount Point: */"Not Mounted", /* Capacity: */formatter.string(fromByteCount: volume.Size)/*self.humanReadableByteCount(volume.Size)*/, /* Available: */"Not Available", /* Used: */"Not Known"]
		self.detailsTable1.reloadData()
		self.detailsTable2Vals = [/* Type: */"\(volume.details.isInternal ? "Internal" : "External")", /* Owners: */"Disabled", /* Connection: */"\(volume.details.busProtocol)", /* Device: */"\(volume.details.deviceNode)"]
		self.detailsTable2.reloadData()
	}
	
	
	fileprivate func legendKey(color: NSColor, title: String, message: String) -> NSView {
		let compound = NSView()
		let square = NSView()
		square.wantsLayer = true
		square.layer?.backgroundColor = NSColor.lightGray.withAlphaComponent(0.1).cgColor
		square.layer?.cornerRadius = 3
		let squareInner = NSView()
		squareInner.wantsLayer = true
		squareInner.translatesAutoresizingMaskIntoConstraints = false
		squareInner.layer?.backgroundColor = color.cgColor
		squareInner.layer?.cornerRadius = 3
		square.addSubview(squareInner)
		square.translatesAutoresizingMaskIntoConstraints = false
		compound.addSubview(square)
		let titleLabel = NSTextField()
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.backgroundColor = NSColor.clear
		titleLabel.font = NSFont.boldSystemFont(ofSize: 11)
		titleLabel.isBordered = false
		titleLabel.stringValue = title
		compound.addSubview(titleLabel)
		let secondLabel = NSTextField()
		secondLabel.translatesAutoresizingMaskIntoConstraints = false
		secondLabel.backgroundColor = NSColor.clear
		secondLabel.font = NSFont.systemFont(ofSize: 11)
		secondLabel.textColor = NSColor.gray
		secondLabel.isBordered = false
		secondLabel.stringValue = message
		compound.addSubview(secondLabel)
		NSLayoutConstraint.activate([
			square.leadingAnchor.constraint(equalTo: compound.leadingAnchor, constant: 1),
			square.widthAnchor.constraint(equalToConstant: 12),
			square.heightAnchor.constraint(equalToConstant: 12),
			square.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),

			squareInner.centerXAnchor.constraint(equalTo: square.centerXAnchor),
			squareInner.centerYAnchor.constraint(equalTo: square.centerYAnchor),
			squareInner.widthAnchor.constraint(equalToConstant: 10),
			squareInner.heightAnchor.constraint(equalToConstant: 10),
			
			titleLabel.topAnchor.constraint(equalTo: compound.topAnchor, constant: 5),
			titleLabel.leadingAnchor.constraint(equalTo: square.trailingAnchor, constant: 3),
			titleLabel.trailingAnchor.constraint(equalTo: compound.trailingAnchor, constant: 0),
			
			secondLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
			secondLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 0),
			secondLabel.bottomAnchor.constraint(equalTo: compound.bottomAnchor, constant: 0),
			secondLabel.trailingAnchor.constraint(equalTo: compound.trailingAnchor, constant: 0),
			])
		return compound
	}
	
	
	func detailsMountedPartition(_ volume: DAPartition, _ table: NSOutlineView, _ type: String) {
		usageNote.stringValue = ""
		mountBtn.isHidden = true
		openBtn.isHidden = false
		openBtn.setAccessibilityIdentifier(volume.details.mountPoint)
		unmountBtn.isHidden = false
		unmountBtn.setAccessibilityIdentifier(volume.details.mountPoint)
		let used = volume.details.size - volume.details.freeSpace
		let ratio: Float64 = Float64(used) / Float64(volume.Size)
//		DispatchQueue.main.async {
//			self.usageBox.subviews.forEach { (sub) in
//				sub.removeFromSuperview()
//			}
//		}
		let usedBar = NSView()
		usedBar.wantsLayer = true
		usedBar.layer?.backgroundColor = NSColor.systemBlue.cgColor
		usedBar.translatesAutoresizingMaskIntoConstraints = false
		self.usageBox.addSubview(usedBar)
		NSLayoutConstraint.activate([
			usedBar.topAnchor.constraint(equalTo: self.usageBox.topAnchor),
			usedBar.leadingAnchor.constraint(equalTo: self.usageBox.leadingAnchor),
			usedBar.bottomAnchor.constraint(equalTo: self.usageBox.bottomAnchor),
			usedBar.trailingAnchor.constraint(equalTo: self.usageBox.leadingAnchor, constant: CGFloat(ratio) * usageBox.frame.width)
			])
		let freeBar = NSView()
		freeBar.wantsLayer = true
		freeBar.layer?.backgroundColor = NSColor.white.cgColor
		freeBar.translatesAutoresizingMaskIntoConstraints = false
		self.usageBox.addSubview(freeBar)
		NSLayoutConstraint.activate([
			freeBar.topAnchor.constraint(equalTo: self.usageBox.topAnchor),
			freeBar.leadingAnchor.constraint(equalTo: self.usageBox.leadingAnchor, constant: CGFloat(ratio) * usageBox.frame.width),
			freeBar.bottomAnchor.constraint(equalTo: self.usageBox.bottomAnchor),
			freeBar.trailingAnchor.constraint(equalTo: self.usageBox.trailingAnchor)
			])
		self.usageBox.layout()
		usageLegend.arrangedSubviews.forEach { (sub) in
			sub.removeFromSuperview()
		}
		usageLegend.addArrangedSubview(legendKey(color: NSColor.systemBlue, title: "Used", message: formatter.string(fromByteCount: used)))
		usageLegend.addArrangedSubview(legendKey(color: NSColor.white, title: "Free", message: formatter.string(fromByteCount: volume.details.freeSpace)))

		self.detailsTable1Vals = [/*Mount Point:*/"\(volume.details.mountPoint)", /*Capacity:*/self.formatter.string(fromByteCount: volume.details.size), /*Available:*/self.formatter.string(fromByteCount: volume.details.freeSpace), /*Used:*/self.formatter.string(fromByteCount: used)]
		self.detailsTable1.reloadData()
		self.detailsTable2Vals = [/*Type*/"\(type)", /*Owners:*/"\(volume.details.globalPermissionsEnabled ? "Enabled" : "Disabled")", /*Connection*/"\(volume.details.busProtocol)", /*Device:*/"\(volume.details.deviceNode)"]
		self.detailsTable2.reloadData()
	}
	
	func moreDiskInfo() {
		/*					let disk = Disks()
		disk.openSession { (session) in
		if let mounted = volume.MountPoint {
		disk.getVolumeInfoObject(session: session, volumeURL: URL(fileURLWithPath: mounted), onSuccess: { (info) in
		/*
		["DAMediaEjectable": 0, "DADeviceProtocol": SATA, "DAMediaWritable": 1, "DAMediaBSDName": disk0s5, "DADeviceInternal": 1, "DADeviceRevision": AP63    , "DAMediaRemovable": 0, "DADeviceModel": ST31000528AS                            , "DAMediaPath": IODeviceTree:/PCI0@0/SATA@1F,2/PRT0@0/PMP@0/@0:5, "DAVolumePath": file:///Volumes/BOOTCAMP7/, "DAVolumeNetwork": 0, "DAVolumeType": MS-DOS (FAT12), "DAMediaLeaf": 1, "DAMediaWhole": 0, "DAMediaBSDMajor": 1, "DABusPath": IODeviceTree:/PCI0@0/SATA@1F,2/PRT0@0/PMP@0, "DABusName": PMP, "DAMediaUUID": <CFUUID 0x60c000031560> E09ECFF2-C6DC-11E9-920B-806E6F6E6963, "DAMediaBSDUnit": 0, "DAMediaKind": IOMedia, "DAMediaSize": 131072000000, "DAVolumeMountable": 1, "DAVolumeUUID": <CFUUID 0x60c0000315a0> 5290B710-242E-403A-95A0-C5F344930B7A, "DAMediaIcon": {
		CFBundleIdentifier = "com.apple.iokit.IOStorageFamily";
		IOBundleResourceFile = "Internal.icns";
		}, "DAVolumeKind": rtfs, "bsdName": 0x0000608000000440, "DAMediaBSDMinor": 3, "DAMediaName": BOOTCAMP7, "DADevicePath": IOService:/AppleACPIPlatformExpert/PCI0@0/AppleACPIPCI/SATA@1F,2/AppleIntelPchSeriesAHCI/PRT0@0/IOAHCIDevice@0/AppleAHCIDiskDriver/IOAHCIBlockStorageDevice, "DAMediaContent": EBD0A0A2-B9E5-4433-87C0-68B6B72699C7, "DADeviceUnit": 0, "DAVolumeName": BOOTCAMP7, "DAMediaBlockSize": 512, "DAAppearanceTime": 606226664.707991, "bsdString": disk0s5]
		*/
		/*
		Mount Point:	/
		Capacity:	249.86 GB
		Avail:	54.3 GB (1.87 GB purgeable)
		Used:	197.43 GB
		
		Type:	SATA Internal Physical Volume
		Owners:	Enabled
		Connection:	SATA
		Device:	disk0s2
		*/
		////								usageRightConstraint?.multiplier = volume.details.size / volume.details.freeSpace
		//								self.detailsTable1Vals = ["\(volume.details.mountPoint)", self.formatter.string(fromByteCount: volume.details.size), self.formatter.string(fromByteCount: volume.details.freeSpace), self.formatter.string(fromByteCount: used), ]
		//								self.detailsTable1.reloadData()
		//								self.detailsTable2Vals = ["\(type)", "\(volume.details.globalPermissionsEnabled ? "Enabled" : "Disabled")", "\(volume.details.busProtocol)", "\(volume.details.deviceNode)"]
		//								self.detailsTable2.reloadData()
		})
		} else {
		self.detailsTable1Vals = ["Not Mounted", self.humanReadableByteCount(volume.Size), "Not Available", "Not Known"]
		self.detailsTable1.reloadData()
		self.detailsTable2Vals = ["\(volume.details.isInternal ? "Internal" : "External")", "Disabled", "\(volume.details.busProtocol)", "\(volume.details.deviceNode)"]
		self.detailsTable2.reloadData()
		}
		}*/
	}
	
	func detailsPartition(_ table: NSOutlineView) {
		if let volume = myDisks?.AllDisksAndPartitions[max(0, table.clickedColumn)].Partitions[table.clickedRow-1] {
			nameField.setAccessibilityIdentifier(volume.details.deviceIdentifier)
			journalBtn.isHidden = (volume.Content != "Apple_HFS")
			switch (volume.details.busProtocol) {
			case "SATA":
				detailsImage.image = NSImage(named: "sata")
			case "CD":
				detailsImage.image = NSImage(named: "CD")
				//				case "SATA":
			//					volImage.image = NSImage(named: "otherMedia")
			default:
				detailsImage.image = NSImage(named: "otherMedia")
			}
			var text = volume.VolumeName
			if text.isEmpty {
				text = volume.DeviceIdentifier
			}
			nameField.stringValue = text
			var info = ""//Mac OS Extended (Journaled)
			let type = "\(volume.details.busProtocol) \(volume.details.isInternal ? "Internal" : "External") \(volume.details.removable ? "Physical" : "Removable") Volume"
			if !volume.Content.isEmpty {
				info = volume.Content
			}
			moreInfo.stringValue = "\(type) • \(info)"
			capacityLabel.stringValue = formatter.string(fromByteCount: volume.Size)
			if volume.MountPoint != nil {
				detailsMountedPartition(volume, table, type)
			} else {
				detailsUnmountedPartition(volume)
			}
			detailsTable1Data = ["Mount Point:", "Capacity:", "Available:", "Used:"]
			detailsTable2Data = ["Type:", "Owners:", "Connection:", "Device:"]
		}
	}


}
