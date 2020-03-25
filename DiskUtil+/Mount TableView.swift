//
//  Mount TableView.swift
//  viewMount
//
//  Created by Yuma Technical Inc. on 2020-03-15.
//  Copyright © 2020 Yuma Technical Inc. All rights reserved.
//

import Cocoa


extension /*MountVC*/ViewController {
	/*
	func drawMountsTable() -> NSView {
		let pane = NSView()
		pane.addSubview(scrollView)
		scrollView.documentView = mountTableView
//		scrollView.drawsBackground = false
//		scrollView.backgroundColor = NSColor.clear
//		scrollView.hasHorizontalScroller = true
//		scrollView.hasVerticalScroller = true
		scrollView.translatesAutoresizingMaskIntoConstraints = false

//		mountTableView.frame = scrollView.bounds
		mountTableView.dataSource = self
		mountTableView.delegate = self
//		mountTableView.headerView = nil//NSTableHeaderView
//		mountTableView.backgroundColor = NSColor.clear
//		mountTableView.appearance = NSAppearance(named: NSAppearance.Name.vibrantDark)
//		scrollView.frame = self.view.bounds
//		print("scrollView \(scrollView.frame)")
//		print("mountTableView \(mountTableView.frame)")
//		mountTableView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
//			mountTableView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
//			mountTableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
//			mountTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
//			mountTableView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),

			scrollView.topAnchor.constraint(equalTo: pane.topAnchor, constant: 10),
			scrollView.leadingAnchor.constraint(equalTo: pane.leadingAnchor, constant: 10),
			scrollView.bottomAnchor.constraint(equalTo: pane.bottomAnchor, constant: -10),
			scrollView.trailingAnchor.constraint(equalTo: pane.trailingAnchor, constant: -10)
			])
		mountTableView.intercellSpacing = CGSize(width: 5.0, height: 5.0)
		return pane
	}
	*/
	
	func loadValues() {
		let disk = Disks()
		disk.getMountedVolumes { (vols) in
			disk.openSession(onSuccess: { (session) in
				for vol in vols {
					disk.getVolumeInfo(session: session, volumeURL: vol, onSuccess: { (dict) in
						let bsd = dict["bsdString"] as AnyObject
						var name: String = dict["DAVolumeName"] as! String
						if name.isEmpty {
							name = bsd as! String
						}
						let row = MountEntry(device: name, path: vol.path, options: [], isMounted: true, canMount: true, dictionary: dict)
						if let isInternal = dict["DADeviceInternal"] as? Bool {
							if isInternal {
								self.mountIntArray.append(row)
							} else {
								self.mountExtArray.append(row)
							}
						}
//						print(row.toString())
//						print("\(vol.path) :: \(dict["bsdString"] ?? "" as AnyObject) \(dict["DAVolumeName"] ?? "" as AnyObject)")
					})
				}
			})
		}
	}


}
