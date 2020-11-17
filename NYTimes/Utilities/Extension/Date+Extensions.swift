//
//  Date+Extensions.swift
//  NYTimes
//
//  Created by Apple on 17/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

/// There are some predefined Date formates
enum DateFormat: String {
    case EEE_MMM_DD_YYYY = "EEE, MMM dd, yyyy"
    case MM_DD = "MMM d"
    case DD_MM = "d MMM"
    case MMM_D_YYYY = "MMM dd, yyyy"
    case hhmm_a_MMMDDYYYY = "h:mm a, MMM dd, yyyy"
    case MM_d_YYYY = "MM/dd/yyyy"
    case dd_MM_yyyy = "dd MM yyyy"
    case num_dd_MM_yyyy = "dd/MM/yyyy"
    case yyy_MM_dd = "yyyy-MM-dd"
    case yyyyMMDD = "yyyy/MM/dd"
    case HHmmss = "HH:mm:ss"
    case hhmm_a = "h:mm a"
    case ddMMhhmm_a = "d MMM, h:mm a"
    case MMddyyyy = "MM dd yyyy"
    case MMddyyyyhhmm_a = "MMM dd yyyy, h:mm a"
    case yyyyMMddHHMMSS = "yyyy-MM-dd HH:mm:ss"
    case EEEE = "EEEE"
    case HHMM = "HH:mm"
}

//Mark: Extension to conver dates and their formates
extension Date {
    func changeDateFormat(fromFromat currentFormat:DateFormat, toFormat changedFormat:DateFormat ) -> Date? {
        let dateString = self.getString(format: currentFormat)
        let formatedDateString = dateString.changeDateFormat(fromFromat: currentFormat, toFormat: changedFormat)
        return formatedDateString.getDate(format: changedFormat)
    }
    
    func getString(format: DateFormat) -> String {
        let dateformater = DateFormatter()
        dateformater.dateFormat = format.rawValue
        return dateformater.string(from: self)
    }
}

