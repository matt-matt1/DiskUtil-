//
//  Actions.swift
//  DiskUtil+
//
//  Created by Yuma Technical Inc. on 2020-03-16.
//  Copyright © 2020 Yuma Technical Inc. All rights reserved.
//

import Cocoa


extension ViewController {
	
	@objc func selectedRow(_ sender: Any?) {
//		print("row \(tableView.clickedRow), col \(tableView.clickedColumn) clicked")
		if let table = sender as? NSOutlineView {
			if table != self.outlineView {
				return
			}
			if table.clickedRow > 0 {	//partition
				detailsPartition(table)
			} else {
				detailsDisk(table)
			}
		}
	}


	@IBAction func openFinder(_ sender: NSButton) {
		let dest = sender.accessibilityIdentifier()
		let completeUrl = URL(fileURLWithPath: dest)
		NSWorkspace.shared.activateFileViewerSelecting([completeUrl])
	}

	
	@IBAction func mount(_ sender: NSButton) {
		let dest = sender.accessibilityIdentifier()
		print("trying to mount \(dest)")
	}
	
	
	@IBAction func unmount(_ sender: NSButton) {
		let dest = sender.accessibilityIdentifier()
		print("trying to unmount \(dest)")
		let saved = sender.title
		let spinner = NSProgressIndicator(frame: sender.bounds)
		spinner.style = NSProgressIndicator.Style.spinning
		sender.addSubview(spinner)
/*		tableView.selectRowIndexes(IndexSet(integer: sender.tag), byExtendingSelection: false)
		sender.title = ""
		if mount.isMounted {
			FileManager.default.unmountVolume(at: URL(fileURLWithPath: mount.path), options: FileManager.UnmountOptions()) { (error) in
				DispatchQueue.main.async {
					spinner.removeFromSuperview()
					sender.title = saved
				}
				if let error = error {
					print("cannot unmount: \(error)")
				} else {
					print("successfully unmounted")
					DispatchQueue.main.async {
						sender.title = "Mount"
	//					self.mountArray.remove(at: sender.tag)
						let row = self.tableView.rowView(atRow: sender.tag, makeIfNecessary: false)
						if row?.subviews.count ?? 0 > 0 {
							for sub in (row?.subviews)! {
								if let cellView = sub as? NSTableCellView {
									if cellView.subviews.count > 0 {
										for sub in cellView.subviews {
											if let field = sub as? NSTextField {
												field.textColor = NSColor.lightGray
											}
			//								if let btn = sub as? NSButton {
			//									btn.attributedTitle..textColor = NSColor.lightGray
			//								}
										}
									}
								}
							}
						}
						let cell = self.tableView.view(atColumn: 0, row: sender.tag, makeIfNecessary: false)
						let check = cell?.subviews[0] as! NSButton
						self.mountArray[sender.tag].isMounted = false
						check.state = mount.isMounted ? NSButton.StateValue.on : NSButton.StateValue.off
						print(check)
					}
	/*				let indexSet = IndexSet(integer: sender.tag)
					self.tableView.removeRows(at: indexSet, withAnimation: .effectFade)
	*/
				}
			}
		} else {
			//mount the device
//			FileManager.default.mount
		}*/
	}


}
