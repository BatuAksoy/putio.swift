//
//  EventsModel.swift
//  Putio
//
//  Created by Altay Aydemir on 4.12.2017.
//  Copyright © 2017 Put.io. All rights reserved.
//

import Foundation
import SwiftyJSON

open class PutioHistoryEvent {
    public enum EventType {
        case fileShared, transferCompleted, other
    }

    open var id: Int
    open var type: EventType

    open var createdAt: Date
    open var createdAtRelative: String

    open var fileID: Int

    // File Shared
    open var sharingUserName: String?
    open var fileName: String?
    open var fileSize: Int64?

    // Transfer Completed
    open var source: String?
    open var transferName: String?
    open var transferSize: Int64?

    init(json: JSON) {
        self.id = json["id"].intValue
        self.fileID = json["file_id"].intValue

        switch json["type"].stringValue {
        case "file_shared":
            self.type = .fileShared
        case "transfer_completed":
            self.type = .transferCompleted
        default:
            self.type = .other
        }

        // Put.io API currently does not provide dates compatible with iso8601, but can do in the future.
        let formatter = ISO8601DateFormatter()
        self.createdAt = formatter.date(from: json["created_at"].stringValue) ?? formatter.date(from: "\(json["created_at"].stringValue)+00:00")!

        // Ex: 5 Days Ago
        self.createdAtRelative = createdAt.timeAgoSinceDate()

        if type == .fileShared {
            self.sharingUserName = json["sharing_user_name"].stringValue
            self.fileName = json["file_name"].stringValue
            self.fileSize = json["file_size"].int64Value
        }

        if type == .transferCompleted {
            self.source = json["source"].stringValue
            self.transferName = json["transfer_name"].stringValue
            self.transferSize = json["transfer_size"].int64Value
        }
    }
}
