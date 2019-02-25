//
//  WallabagSession.swift
//  wallabag

import Foundation
import wallabagCommon
import wallabagKit
import RealmSwift

extension Notification.Name {
    static let wallabagStateChanged = Notification.Name("wallabag.state.changed")
}

class WallabagSession {
    enum State {
        case missingConfiguration
        case error
        case configured
        case connected
        case fetching
    }
    private let setting = WallabagSetting()
    var kit: WallabagKit?
    private var wallabagSync: WallabagSyncing?
    static let shared = WallabagSession()
    var currentState: State {
        didSet {
            Log("Update state with \(currentState)")
            NotificationCenter.default.post(name: .wallabagStateChanged, object: nil)
        }
    }
    private init() {
        currentState = setting.get(for: .wallabagIsConfigured) ? .configured : .missingConfiguration
    }

    func startSession() {
        kit = WallabagKit(
            host: setting.get(for: .host),
            clientID: setting.get(for: .clientId),
            clientSecret: setting.get(for: .clientSecret)
        )
        guard let kit = self.kit, let password = setting.getPassword() else {return}
        kit.requestAuth(
            username: setting.get(for: .username),
            password: password) { [weak self] auth in
                switch auth {
                case .success:
                    self?.currentState = .connected
                case .error(let error):
                    Log(error)
                    self?.currentState = .error
                case  .invalidParameter, .unexpectedError:
                    self?.currentState = .error
                }
        }
        wallabagSync = WallabagSyncing(kit: kit)
    }

    func add(_ url: URL) {
        guard let kit = kit, currentState == .connected else { return }
        kit.entry(add: url, queue: .main) { response in
            switch response {
            case .success(let wallabagEntry):
                do {
                    let realm = try Realm()
                    try realm.write {
                        let entry = Entry()
                        entry.hydrate(from: wallabagEntry)
                        realm.add(entry)
                    }
                } catch _ {

                }
            case .error:
                break
            }
        }
    }

    func delete(_ entry: Entry) {
        guard let kit = kit, currentState == .connected else { return }
        kit.entry(delete: entry.id) {
            do {
                let realm = try Realm()
                try realm.write {
                    realm.delete(entry)
                }
            } catch {

            }
        }
    }

    func update(_ entry: Entry) {
        guard let kit = kit, currentState == .connected else { return }
        kit.entry(
            update: entry.id,
            parameters: [
                "archive": entry.isArchived.int,
                "starred": entry.isStarred.int
            ],
            queue: .main) { _ in }
    }
}
