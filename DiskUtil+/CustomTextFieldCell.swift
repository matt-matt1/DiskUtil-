//
//  CustomTextFieldCell.swift
//  DiskUtil+
//
//  Created by Yuma Technical Inc. on 2020-03-23.
//  Copyright © 2020 Yuma Technical Inc. All rights reserved.
//
/*
import Cocoa


class CustomTextFieldCell: NSTextFieldCell {

	// When the background changes (as a result of selection/deselection) switch appropriate colours
	override var backgroundStyle: NSView.BackgroundStyle {
		didSet {
			if (backgroundStyle == NSView.BackgroundStyle.dark) {
				if self.textColor == NSColor.red {
					self.textColor = NSColor.yellow
				}
			} else if (backgroundStyle == NSView.BackgroundStyle.light) {
				if (self.textColor == NSColor.yellow) {
					self.textColor = NSColor.red
				}
			}
		}
	}
	// When the colour changes, switch to a better alternative for the cell's current background
	override var textColor: NSColor? {
		didSet {
			if self.textColor != nil {
				if backgroundStyle == NSView.BackgroundStyle.dark {
					if self.textColor == NSColor.red {
						self.textColor = NSColor.yellow
					}
				} else if backgroundStyle == NSView.BackgroundStyle.light {
					if (self.textColor == NSColor.yellow) {
						self.textColor = NSColor.red
					}
				}
			}
		}
	}

}
*/
