import Foundation

class GCD {
    
    static let searchQueue = DispatchQueue(label: "com.nva.search_queue")
    static var currentSearchTask: DispatchWorkItem?
    
    static func newSearchTask(_ task: DispatchWorkItem, _ delay: Double = 2.0) {
        currentSearchTask?.cancel()
        currentSearchTask = task
        searchQueue.asyncAfter(deadline: .now() + delay, execute: task)
    }
    
}
