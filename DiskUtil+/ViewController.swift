//
//  ViewController.swift
//  DiskUtil+
//
//  Created by Yuma Technical Inc. on 2020-03-16.
//  Copyright © 2020 Yuma Technical Inc. All rights reserved.
//

import Cocoa
import IOKit
import LocalAuthentication
import ServiceManagement


class ViewController: NSViewController {
	/**/
	var mountIntArray: [MountEntry] = []
	var mountExtArray: [MountEntry] = []
	var myDisks: DiskArray?
	var detailsTable1Data = ["Mount Point:", "Capacity:", "Available:", "Used:"]
	var detailsTable1Vals: [String] = []
	var detailsTable2Data = ["Type:", "Owners:", "Connection:", "Device:"]
	var detailsTable2Vals: [String] = []
	/*
	let columnMounted: NSTableColumn = {
		let view = NSTableColumn()
		view.identifier = NSUserInterfaceItemIdentifier(rawValue: "columnMounted")
		view.title = "Mounted"
		//		view.minWidth = 1
		view.maxWidth = 20
		return view
	}()
	let columnDevice: NSTableColumn = {
		let view = NSTableColumn()
		view.identifier = NSUserInterfaceItemIdentifier(rawValue: "columnDevice")
		view.title = "Device"
		view.minWidth = 60
		return view
	}()
	let columnPath: NSTableColumn = {
		let view = NSTableColumn()
		view.identifier = NSUserInterfaceItemIdentifier(rawValue: "columnPath")
		view.title = "Path"
		view.minWidth = 165
		return view
	}()
	let columnOptions: NSTableColumn = {
		let view = NSTableColumn()
		view.identifier = NSUserInterfaceItemIdentifier(rawValue: "columnOptions")
		view.title = "Options"
		view.minWidth = 200
		return view
	}()
	let columnAction: NSTableColumn = {
		let view = NSTableColumn()
		view.identifier = NSUserInterfaceItemIdentifier(rawValue: "columnAction")
		view.title = "Actions"
		view.minWidth = 200
		return view
	}()
	let scrollView: NSScrollView = {
		let view = NSScrollView()
		//		view.frame = view.bounds
		view.hasHorizontalScroller = true
		view.hasVerticalScroller = true
		return view
	}()
	lazy var mountTableView: NSTableView = {
		let view = NSTableView(frame: scrollView.bounds)
		//		view.effectiveRowSizeStyle = NSTableView.RowSizeStyle.default
		view.usesAlternatingRowBackgroundColors = true
		view.addTableColumn(columnMounted)
		view.addTableColumn(columnDevice)
		view.addTableColumn(columnPath)
		view.addTableColumn(columnOptions)
		view.addTableColumn(columnAction)
		return view
	}()
	let stack: NSStackView = {
		let view = NSStackView()
		view.orientation = NSUserInterfaceLayoutOrientation.vertical
		view.spacing = 5
		//		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()*/
	/**/
	
	@IBOutlet weak var mountBtn: NSButton!
	@IBOutlet weak var unmountBtn: NSButton!
	@IBOutlet weak var openBtn: NSButton!
	//	@IBOutlet weak var usageBarWidthConstraint: NSLayoutConstraint!
	@IBOutlet weak var usageBar: NSBox!
	@IBOutlet weak var usageNote: NSTextField!
	@IBOutlet weak var usageLegend: NSStackView!
	@IBOutlet weak var detailsTable2: NSTableView!
	@IBOutlet weak var detailsTable1: NSTableView!
	@IBOutlet weak var outlineView: NSOutlineView!
	@IBOutlet weak var usageBox: NSBox!
//	var usageRightConstraint: NSLayoutConstraint? = nil
	/*@IBOutlet weak*/ var usageLevel = NSBox()
	@IBOutlet weak var capacityLabel: NSTextField!
	@IBOutlet weak var moreInfo: NSTextField!
	@IBOutlet weak var nameField: NSTextField!
	@IBOutlet weak var detailsImage: NSImageView!

	let formatter = ByteCountFormatter()


	/// configure the main window view
	func setupView() {
		self.view.wantsLayer = true
		self.view.translatesAutoresizingMaskIntoConstraints = false
		self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 925))
		self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 500))
	}

	
	/// arrange how numbers should be formatted
	fileprivate func setFormatter() {
		formatter.allowedUnits = ByteCountFormatter.Units.useAll
		formatter.countStyle = ByteCountFormatter.CountStyle.file
		formatter.includesUnit = true
		formatter.isAdaptive = true
		formatter.allowsNonnumericFormatting = true
		formatter.zeroPadsFractionDigits = false
	}

	
	/// setup and attach the tables & details
	fileprivate func attachTables() {
		outlineView.dataSource = self
		outlineView.delegate = self
		detailsTable1.dataSource = self
		detailsTable1.delegate = self
		detailsTable2.dataSource = self
		detailsTable2.delegate = self

		outlineView.expandItem(nil, expandChildren: true)
		outlineView.selectRowIndexes(IndexSet(integer: 0), byExtendingSelection: false)
		outlineView.action = #selector(self.selectedRow(_:))
		selectedRow(outlineView)
	}

	
	override func viewDidLoad() {
		super.viewDidLoad()
		setFormatter()//true
		setupView()
		/// put disk info into a global array
		myDisks = fillDiskArray()
		attachTables()
		usageLegend.distribution = NSStackView.Distribution.fillEqually
		usageLegend.spacing = 1
		/// setup the usage legend
//		legend.stack = usageLegend
//		usageLegend.distribution = NSStackView.Distribution.fillEqually
//		usageLevel.translatesAutoresizingMaskIntoConstraints = false
//		usageRightConstraint = usageLevel.leadingAnchor.constraint(equalTo: usageBox.trailingAnchor)
//		usageRightConstraint?.constant = 100
//		usageRightConstraint?.isActive = true
//		NSLayoutConstraint.activate([
//			usageLevel.topAnchor.constraint(equalTo: usageBox.topAnchor),
//			usageLevel.leadingAnchor.constraint(equalTo: usageBox.leadingAnchor),
//			usageLevel.bottomAnchor.constraint(equalTo: usageBox.bottomAnchor),
//			])
//		let sortbyDevice = NSSortDescriptor(key: "DeviceCol", ascending: true)
//		tableView.tableColumns[1].sortDescriptorPrototype = sortbyDevice
/*		let buttonBar = NSView(frame: NSRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: stack.frame.width, height: 50)))
		let btnStack = NSStackView()
		btnStack.orientation = NSUserInterfaceLayoutOrientation.horizontal
		btnStack.frame = buttonBar.bounds
		
		let textSmaller = NSButton(frame: NSRect(x: 0, y: 0, width: 50, height: 50))
		textSmaller.bezelStyle = NSButton.BezelStyle.roundRect
		textSmaller.title = "Smaller"
		buttonBar.addSubview(textSmaller)
		
		let textLarger = NSButton(frame: NSRect(x: 100, y: 0, width: 50, height: 50))//(title: "Larger", target: nil, action: nil)
		textLarger.bezelStyle = NSButton.BezelStyle.roundRect
		textLarger.title = "Larger"
		buttonBar.addSubview(textSmaller)
		
		stack.addArrangedSubview(buttonBar)
		stack.addArrangedSubview(drawMountsTable())*/
/*		do {
			let vols = try FileManager.default.contentsOfDirectory(atPath: "/Volumes")
			for item in vols {
				let vol = URL(fileURLWithPath: "/Volumes/\(item)")
				do {
					let values = try vol.resourceValues(forKeys: [.volumeSupportsVolumeSizesKey, .volumeNameKey, .volumeIsInternalKey, .volumeURLKey])
					if let name = values.volumeName {
						print(name, values)
					}
				}
			}
		} catch {
		}*/
//		let re = Refind()
//		print(re.systemType() ?? "")
//		re.getMacSystemType()
//		var systemVersion = ProcessInfo.processInfo.operatingSystemVersion
//		print(systemVersion)
//		print(Refind.is64Bit ? "64bit" : "32bit")//WORKS
/*		let domain: CFString!
		let executableLabel: CFString
		let auth: AuthorizationRef!
		let outError: UnsafeMutablePointer<Unmanaged<CFError>?>!
		SMJobBless(domain, executableLabel, auth, outError)*/
		/*
//		let matching = IOServiceMatching("IODeviceTree")//IODisplayConnect")
		let service: io_service_t = 0
		let key: CFString! = "IODeviceTree" as CFString
		var value: AnyObject? = IORegistryEntryCreateCFProperty(service, key, kCFAllocatorDefault, 0).takeUnretainedValue()
//		let dev = IORegistryEntryCreateCFProperty(service, kIODeviceTreePlane as CFString, kCFAllocatorDefault, 0)
		print(value)
*/
	}
	
	override var representedObject: Any? {
		didSet {
			// Update the view, if already loaded.
		}
	}


}

