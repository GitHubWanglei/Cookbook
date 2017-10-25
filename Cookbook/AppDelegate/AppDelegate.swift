//
//  AppDelegate.swift
//  Cookbook
//
//  Created by wanglei on 2017/10/17.
//  Copyright © 2017年 wanglei. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var windowNumber = 0

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        if let window = NSApp.mainWindow {
            windowNumber = window.windowNumber
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if flag == false {
            if let window = NSApp.window(withWindowNumber: windowNumber){
                window.makeKeyAndOrderFront(self)
                return true
            }
        }
        return flag
    }

}

