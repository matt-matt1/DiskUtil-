//
//  Mount Delegate.swift
//  viewMount
//
//  Created by Yuma Technical Inc. on 2020-03-15.
//  Copyright © 2020 Yuma Technical Inc. All rights reserved.
//

import Cocoa


extension /*MountVC*/ViewController: NSTableViewDelegate {

	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		if tableView == self.detailsTable1 {
			return table1(tableView, viewFor: tableColumn, row: row)
		} else if tableView == self.detailsTable2 {
			return table2(tableView, viewFor: tableColumn, row: row)
		} else {
			return nil
		}
	}
	

	func table1(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: "DetailCol") {
			let cellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "DetailCell1")
			guard let cellView = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? NSTableCellView else { return nil }
			cellView.textField?.stringValue = detailsTable1Data[row]
			return cellView
		} else if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: "DetailValueCol") {
			let cellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "ValueCell1")
			guard let cellView = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? NSTableCellView else { return nil }
//			let details = getDiskDetailsObject(disks["DeviceIdentifier"] as! String)
			if row < detailsTable1Vals.count {
				cellView.textField?.stringValue = detailsTable1Vals[row]
//			} else {
//				cellView.textField?.stringValue = "asdf"
			}
//			cellView.textField?.alignment = NSTextAlignment.right
			return cellView
		}
		return nil
	}
	
	
	func table2(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: "DetailCol") {
			let cellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "DetailCell2")
			guard let cellView = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? NSTableCellView else { return nil }
			cellView.textField?.stringValue = detailsTable2Data[row]
			return cellView
		} else if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: "DetailValueCol") {
			let cellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "ValueCell2")
			guard let cellView = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? NSTableCellView else { return nil }
			if row < detailsTable2Vals.count {
				cellView.textField?.stringValue = detailsTable2Vals[row]
//			} else {
//				cellView.textField?.stringValue = "asdg"
			}
//			cellView.textField?.alignment = NSTextAlignment.right
			return cellView
		}
		return nil
	}
	
	
	func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
		if tableView == self.detailsTable1 {
			return 20.0
		} else if tableView == self.detailsTable2 {
			return 20.0
		} else {
			return 21.0
		}
	}


}

