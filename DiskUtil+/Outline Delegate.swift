//
//  Outline Delegate.swift
//  DiskUtil+
//
//  Created by Yuma Technical Inc. on 2020-03-20.
//  Copyright © 2020 Yuma Technical Inc. All rights reserved.
//

import Cocoa



extension ViewController: NSOutlineViewDelegate {
	
	func outlineViewSelectionDidChange(_ notification: Notification) {
		print("selected column: \(outlineView.selectedColumn) - row: \(outlineView.selectedRow)")
	}

	
	func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
		var view: NSTableCellView?
		if let section = item as? DADiskPart {
			if (tableColumn?.identifier)!.rawValue == "DiskColumn" {
				view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "DiskCell"), owner: self) as? NSTableCellView
				view?.imageView?.image = NSImage(named: "internal")
//				view?.imageView?.contentTintColor = NSColor.lightGray
				view?.textField?.stringValue = "\(section.details.ioRegistryEntryName)"//" (\(section.DeviceIdentifier))"
				print("\(view?.textField?.stringValue ?? "")")//" \(view?.textField?.textColor?. ?? "")")
//				view?.textField?.textColor = (outlineView.selectedRow == 0) ? NSColor.white : NSColor.darkGray
			}
		} else if let section = item as? DAPartition {
			if (tableColumn?.identifier)!.rawValue == "DiskColumn" {
				view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "DiskCell2"), owner: self) as? NSTableCellView
				view?.imageView?.image = NSImage(named: "internal")
				if let textField = view?.textField {
					textField.stringValue = /*"\(section.DeviceIdentifier)"*/"\(!section.VolumeName.isEmpty ? "\(section.VolumeName)" : "\(section.DeviceIdentifier)")"
					textField.textColor = (section.MountPoint != nil && !section.MountPoint!.isEmpty) ? NSColor.darkGray : NSColor.headerColor
//					if outlineView.selectedColumn > -1 && outlineView.selectedRow > -1 {
//						textField.textColor = (myDisks?.AllDisksAndPartitions[outlineView.selectedColumn].Partitions[outlineView.selectedRow].DeviceIdentifier == section.DeviceIdentifier) ? NSColor.white : NSColor.darkGray
//					}
				}
			}
		}
		return view
	}


}
