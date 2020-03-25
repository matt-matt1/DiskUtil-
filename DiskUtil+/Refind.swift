//
//  Refind.swift
//  DiskUtil+
//
//  Created by Yuma Technical Inc. on 2020-03-17.
//  Copyright © 2020 Yuma Technical Inc. All rights reserved.
//

import Foundation
import SecurityFoundation
import LocalAuthentication


class Refind {

	static var is32Bit: Bool {
		return Int.bitWidth == 32
	}
	static var is64Bit: Bool {
		return Int.bitWidth == 64
	}
	
	/*
	func doMount() {
//		if (ownerUID == _my_uid && ![[contextInfo processName]
//			isEqualToString:@"WindowServer"] && ![[contextInfo processName]
//				isEqualToString:@"loginwindow"]) {
//			[self killPid:pid withSignal:signal]
//		} else {
		let flags: AuthorizationFlags = [AuthorizationFlags.noData/*.kAuthorizationFlagDefaults*/, AuthorizationFlags.interactionAllowed, AuthorizationFlags.extendRights, AuthorizationFlags.preAuthorize]
		let rights: UnsafePointer<AuthorizationRights>! = UnsafePointer(bitPattern: 0)
		let environment: UnsafePointer<AuthorizationEnvironment>! = UnsafePointer(bitPattern: 0)
			if let auth: SFAuthorization = SFAuthorization(flags: flags, rights: rights, environment: environment) {
//			if (![auth permitWithRight:"com.apple.proccesskiller.kill" flags:
//				kAuthorizationFlagDefaults|kAuthorizationFlagInteractionAllowed|
//				kAuthorizationFlagExtendRights|kAuthorizationFlagPreAuthorize])    // 2
//			{
				let authRef: AuthorizationRef = auth.authorizationRef()
				let authExtForm: AuthorizationExternalForm
				let status: OSStatus = AuthorizationMakeExternalForm(authRef, &authExtForm)
				if (errAuthorizationSuccess == status) {
					let autoData = NSData()
//					let authData: NSData = NSData(bytesNoCopy: authExtForm.bytes, length: kAuthorizationExternalFormLength) { (unsafeMutableRawPointer, int) in
//						[_agent killProcess:pid signal:signal authData: authData];                 // 6
//					}// dataWithBytes: authExtForm.bytes
//						length: kAuthorizationExternalFormLength];    // 5
				}
			}
//		}
	}
	*//*
	static func authorizationRef(fromExternalForm data: Data) throws -> AuthorizationRef? {
		// Create an AuthorizationExternalForm from it's data representation
		var authRef: AuthorizationRef?
		var authRefExtForm = data.withUnsafeBytes{ $0.load(as: AuthorizationExternalForm.self) }
		
		// Extract the AuthorizationRef from it's external form
		try executeAuthorizationFunction { AuthorizationCreateFromExternalForm(&authRefExtForm, &authRef) }
		return authRef
	}*/
	/*
	func authorize() {
		
		let authRef: AuthorizationRef? = nil//UnsafeMutablePointer<AuthorizationRef?>
//		let authData = (Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8)
		var status: OSStatus = AuthorizationCreateFromExternalForm(AuthorizationExternalForm(bytes: (Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8)), &authRef)
		if ((errAuthorizationSuccess == status) && (nil != authRef)) {
			let right: AuthorizationItem = AuthorizationItem(name: "com.apple.proccesskiller.kill", valueLength: 0, value: nil, flags: 0)
			let rights: AuthorizationItemSet = AuthorizationItemSet(count: 1, items: right as UnsafeMutablePointer<AuthorizationItem>?)// (1, &right)
			status = AuthorizationCopyRights(authRef, &rights, NULL, [AuthorizationFlags.noData/*AuthorizationFlag.Defaults*/, AuthorizationFlags.interactionAllowed, AuthorizationFlags.extendRights], nil)
			if (errAuthorizationSuccess == status) {
//			kill(pid, signal);                                                       // 5
			} else {
				print("Unauthorized attempt to signal process \(pid) with \(signal)")
			}
			AuthorizationFree(authRef, kAuthorizationFlagDefaults)
		}
	}
	*/
	func is64bitCompileTime() -> Bool {
		#if (arch(x86_64) || arch(arm64))
			return true
		#else
			return false
		#endif
	}
/*
	func getSystemUUID() -> String? {
		let dev = IOServiceMatching("IOPlatformExpertDevice")
		let platformExpert: io_service_t = IOServiceGetMatchingService(kIOMasterPortDefault, dev)
		let serialNumberAsCFString = IORegistryEntryCreateCFProperty(platformExpert, kIOPlatformUUIDKey as CFString, kCFAllocatorDefault, 0)
		IOObjectRelease(platformExpert)
//		let ser: CFTypeRef = serialNumberAsCFString.takeUnretainedValue()
//		if let result = ser as? String {
//			return result
//		}
		return nil
	}
*/
	func getMacSerialNumber() -> String {
		var serialNumber: String? {
			let platformExpert = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice") )
			guard platformExpert > 0 else {
				return nil
			}
			guard let serialNumber = (IORegistryEntryCreateCFProperty(platformExpert, kIOPlatformSerialNumberKey as CFString, kCFAllocatorDefault, 0).takeUnretainedValue() as? String)?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) else {
				return nil
			}
			IOObjectRelease(platformExpert)
			return serialNumber
		}
		return serialNumber ?? "Unknown"
	}
	
	func getMacSystemType() -> String {
		var serialNumber: String? {
			let platformExpert: io_service_t = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice"))
			guard platformExpert > 0 else {
				return nil
			}
//			if let asdf = IORegistryEntryCreateCFProperty(platformExpert, kio as CFString, kCFAllocatorDefault, 0) {
//				if let value = asdf.takeUnretainedValue() as? Any {
//					print(value)
//				}
//			}
			guard let serialNumber = (IORegistryEntryCreateCFProperty(platformExpert, kIODeviceTreePlane as CFString, kCFAllocatorDefault, 0).takeUnretainedValue() as? String)?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) else {
				return nil
			}
			IOObjectRelease(platformExpert)
			return serialNumber
		}
		return serialNumber ?? "Unknown"
	}
	
	func screenNames() -> [String] {
		var names = [String]()
		var object: io_object_t
		var serialPortIterator = io_iterator_t()
		let matching = IOServiceMatching("IODisplayConnect")
		
		let kernResult = IOServiceGetMatchingServices(kIOMasterPortDefault,
													  matching,
													  &serialPortIterator)
		if KERN_SUCCESS == kernResult && serialPortIterator != 0 {
			repeat {
				object = IOIteratorNext(serialPortIterator)
				let info = IODisplayCreateInfoDictionary(object, UInt32(kIODisplayOnlyPreferredName)).takeRetainedValue() as NSDictionary as! [String:AnyObject]
				if let productName = info["DisplayProductName"] as? [String:String],
					let firstKey = Array(productName.keys).first {
					names.append(productName[firstKey]!)
				}
				
			} while object != 0
		}
		IOObjectRelease(serialPortIterator)
		return names
	}
	
	func systemType() -> String? {
		let out = "ioreg -l -p IODeviceTree | grep firmware-abi".run()
		let value = out?.match("<\"(.*)\">")
		if ((value?.count) != nil) {
			return value!.first![1]
		}
		return nil
	}

	func systemTypeInt() -> String? {
		let out = "ioreg -l -p IODeviceTree | grep firmware-abi".run()
		let value = out?.match("<\"(\\d*)\">")
		if ((value?.count) != nil) {
			return value!.first![1]
		}
		return nil
	}
	
	func mount() {
		var out = "sudo mkdir /Volumes/ESP".run()
		if out != nil && out!.isEmpty {
			out = "sudo mount -t msdos /dev/disk0s1 /Volumes/ESP".run()
		}
	}


}
