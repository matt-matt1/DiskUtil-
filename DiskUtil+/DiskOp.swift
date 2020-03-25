//
//  DiskOp.swift
//  DiskUtil+
//
//  Created by Yuma Technical Inc. on 2020-03-25.
//  Copyright © 2020 Yuma Technical Inc. All rights reserved.
//

import Cocoa

class DiskOp: NSViewController {

    var callbackSession: DASession?
	let volumeDidDisappearCallback: DADiskDisappearedCallback = { (disk, context) in
		// do something with disk
	}

	
	func setSession() {
		callbackSession = DASessionCreate(kCFAllocatorDefault)
	}
	
	func registerDiskDisappear() {
//		let callbackSession = DASessionCreate(kCFAllocatorDefault)
		DASessionSetDispatchQueue(callbackSession!, DispatchQueue.global())
		DARegisterDiskDisappearedCallback(callbackSession!, nil, volumeDidDisappearCallback, nil)
	}

	func unregisterCallback() {
		//cast the function pointer to a void pointer explicitly
		let cb = unsafeBitCast(volumeDidDisappearCallback, to: UnsafeMutableRawPointer.self)
		DAUnregisterCallback(callbackSession!, cb, nil)
	}
	
}
