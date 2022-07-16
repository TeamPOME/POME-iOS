//
//  CalendarDelegate.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/16.
//

import Foundation

protocol DeliveryDateDelegate {
    func deliveryDate(startDate: Date, endDate: Date, isStartDate: Bool)
}
