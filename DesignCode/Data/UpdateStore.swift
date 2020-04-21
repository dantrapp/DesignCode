//
//  UpdateStore.swift
//  DesignCode
//
//  Created by Will Hustle on 4/20/20.
//  Copyright © 2020 Will Hustle. All rights reserved.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject {
    @Published var updates: [Update] = updateData
}
