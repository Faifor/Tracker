//
//  TrackerTests.swift
//  TrackerTests
//
//  Created by Данила Спиридонов on 02.10.2025.
//

import XCTest
import SnapshotTesting
@testable import Tracker

final class TrackerTests: XCTestCase {
    
    func testTrackersViewControllerLight() {
        let trackersVC = TrackersViewController()
        let trackerNC = UINavigationController(rootViewController: trackersVC)
        
        trackerNC.overrideUserInterfaceStyle = .light
        
        trackersVC.viewDidLoad()
        
        assertSnapshot(of: trackerNC, as: .image, record: false)
    }
    
    func testTrackersViewControllerDark() {
        let trackersVC = TrackersViewController()
        let trackerNC = UINavigationController(rootViewController: trackersVC)
        
        trackerNC.overrideUserInterfaceStyle = .dark
        
        trackersVC.viewDidLoad()
        
        assertSnapshot(of: trackerNC, as: .image, record: false)
    }
    
}
