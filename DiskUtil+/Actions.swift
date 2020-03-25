//
//  Actions.swift
//  DiskUtil+
//
//  Created by Yuma Technical Inc. on 2020-03-16.
//  Copyright © 2020 Yuma Technical Inc. All rights reserved.
//

import Cocoa


extension ViewController: NSAlertDelegate {
	
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

	
	/// Convert a HFS+ volume to HFS+ journaled
	@IBAction func makeJounaledAction(_ sender: NSButton) {
		let dest = sender.accessibilityIdentifier()
		print("making \(dest) journaled")
	}
	
	
	/// Sets the new name for the volume
	@IBAction func renameVolume(_ sender: NSTextField) {
		let dest = sender.accessibilityIdentifier()
		print("renaming \(dest) to \(sender.stringValue)")
	}

	
	/// Open the location in Finder (File Explorer)
	@IBAction func openFinder(_ sender: NSButton) {
		let dest = sender.accessibilityIdentifier()
		let completeUrl = URL(fileURLWithPath: dest)
		NSWorkspace.shared.activateFileViewerSelecting([completeUrl])
	}

	
	/// Mount a partition
	@IBAction func mount(_ sender: NSButton) {
		// /usr/sbin/disktool -m disk0s13
		// /usr/sbin/diskutil mountDisk disk0
		let saved = sender.title
		sender.title = sender.title + " ..."
		let dest = sender.accessibilityIdentifier()
		print("trying to mount \(dest)")
		let spinner = SpinnerViewController()
		let overlay = NSWindow(contentViewController: self)
		overlay.backgroundColor = NSColor(white: 0, alpha: 0.5)
		self.addChild(spinner)
		self.view.addSubview(spinner.view)
		spinner.view.frame = self.view.bounds
//		spinner.showIn(self)
/*		let spinner = NSProgressIndicator(frame: sender.bounds)
		spinner.style = NSProgressIndicator.Style.spinning
		let wasBG = self.view.layer?.backgroundColor
		self.view.layer?.backgroundColor = NSColor(white: 0, alpha: 0.5).cgColor
		/*sender*/self.view.addSubview(spinner)
		spinner.startAnimating()
		spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
		spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true*/
		let disk = Disks()
		disk.openSession { (session) in
			if let part = DADiskCreateFromVolumePath(kCFAllocatorDefault, session, URL(fileURLWithPath: dest) as CFURL) {
				let cb = unsafeBitCast(self.callbackMount, to: DADiskMountCallback.self)
//				let cb = unsafeBitCast(DADiskMountCallback.self, to: UnsafeMutableRawPointer.self)
//				DAUnregisterCallback(callbackSession!, cb, nil)
//				DARegisterDiskUnmountApprovalCallback(session, nil, cb, nil)
				DADiskMount(part, URL(fileURLWithPath: dest) as CFURL, DADiskMountOptions(kDADiskUnmountOptionDefault), cb/*{ (disk, dissenter, pointer) in
					/*			spinner.removeFromSuperview()
					self.view.layer?.backgroundColor = wasBG*/
					spinner.dismissSpinner()
					//		sender.title = saved
//					self.completedMount(disk: disk, dissenter: dissenter, pointer: pointer, spinner: spinner, sender: sender)
				}*/, nil)
			}
		}
	}

	func callbackMount(disk: DADisk, dissenter: DADissenter?, pointer: UnsafeMutableRawPointer?, spinner: SpinnerViewController, sender: NSButton) {
		/*			spinner.removeFromSuperview()
		self.view.layer?.backgroundColor = wasBG*/
		spinner.dismissSpinner()
		//		sender.title = saved
	}

	
	/// Unmount a mounted volume
	@IBAction func unmount(_ sender: NSButton) {
		// /usr/sbin/disktool -p disk0s13 0
		// /usr/sbin/diskutil unmountDisk disk0
/**/
		let saved = sender.title
		sender.title = sender.title + " ..."/**/
		let dest = sender.accessibilityIdentifier()
//		print("trying to unmount \(dest)")
/**/
		let spinner = SpinnerViewController()
//		spinner.style = small
/*		let overlay = NSWindow(contentViewController: self)
		overlay.backgroundColor = NSColor(white: 0, alpha: 0.5)*/
		self.addChild(spinner)
		self.view.addSubview(spinner.view)
		spinner.view.frame = self.view.bounds/**/
/*		let alert = NSAlert()
//		panel.window.title = sender.title + " ..."
		alert.messageText = sender.title + " ..."
		alert.alertStyle = NSAlert.Style.warning
		alert.delegate = self
		alert.runModal()*/
//		spinner.showIn(self)
		let wasBG = self.view.layer?.backgroundColor
/*
		let spinner = NSProgressIndicator(frame: sender.bounds)
		spinner.style = NSProgressIndicator.Style.spinning
		self.view.layer?.backgroundColor = NSColor(white: 0, alpha: 0.5).cgColor
		/*sender*/self.view.addSubview(spinner)
		spinner.startAnimating()
		spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
		spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true*/
		let disk = Disks()
		disk.openSession { (session) in
			if let part = DADiskCreateFromVolumePath(kCFAllocatorDefault, session, URL(fileURLWithPath: dest) as CFURL) {
				let cb = unsafeBitCast(/*DADiskMountCallback.self*/self.callbackMount, to: DADiskMountCallback.self/*UnsafeMutableRawPointer.self*/)
				DADiskUnmount(part, DADiskUnmountOptions(kDADiskUnmountOptionDefault), cb/*{ (disk, dissenter, pointer) in
					//		self.view.layer?.backgroundColor = wasBG
					spinner.dismissSpinner()
					sender.isHidden = true
					//		sender.title = saved
//					self.completedUnmount(disk: disk, dissenter: dissenter, pointer: pointer, spinner: spinner, sender: sender)
				}*/, nil)
			}
		}
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

	func callbackUnmount(disk: DADisk, dissenter: DADissenter?, pointer: UnsafeMutableRawPointer?, spinner: SpinnerViewController, sender: NSButton) {
//		self.view.layer?.backgroundColor = wasBG
		spinner.dismissSpinner()
		sender.isHidden = true
//		sender.title = saved
	}

	
	/// Eject a Disk
	@IBAction func ejectDisk(_ sender: NSButton) {
		// /usr/sbin/diskutil eject disk0
		let dest = sender.accessibilityIdentifier()
		let disk = Disks()
		disk.openSession { (session) in
			if let part = DADiskCreateFromVolumePath(kCFAllocatorDefault, session, URL(fileURLWithPath: dest) as CFURL) {
				DADiskEject(part, DADiskEjectOptions(kDADiskUnmountOptionDefault), { (disk, dissenter, pointer) in
//					completedEject()
				}, nil)
			}
		}
	}
	
//	func completedEject(disk: DADisk, dissenter: DADissenter?, pointer: UnsafeMutableRawPointer?, spinner: SpinnerViewController, sender: NSButton) {
//	}


}
