import Foundation

// Notification when new photo instances are added
let photoManagerContentAddedNotification = "com.raywenderlich.GooglyPuff.PhotoManagerContentAdded"
// Notification when content updates (i.e. Download finishes)
let photoManagerContentUpdatedNotification = "com.raywenderlich.GooglyPuff.PhotoManagerContentUpdated"

// Photo Credit: Devin Begley, http://www.devinbegley.com/
let overlyAttachedGirlfriendURLString = "http://i.imgur.com/UvqEgCv.png"
let successKidURLString = "http://i.imgur.com/dZ5wRtb.png"
let lotsOfFacesURLString = "http://i.imgur.com/tPzTg7A.jpg"

typealias PhotoProcessingProgressClosure = (_ completionPercentage: CGFloat) -> Void
typealias BatchPhotoDownloadingCompletionClosure = (_ error: NSError?) -> Void

private let _sharedManager = PhotoManager()

class PhotoManager {
  class var sharedManager: PhotoManager {
    return _sharedManager
  }
  

  fileprivate let concurrentPhotoQueue =
    DispatchQueue(label: "com.raywenderlich.GooglyPuff.photoQueue", attributes: .concurrent)
    
  fileprivate var _photos: [Photo] = []
  var photos: [Photo] {
    var photosCopy: [Photo]!
    concurrentPhotoQueue.sync {
        photosCopy = self._photos
    }
    return photosCopy
  }
  
  func addPhoto(_ photo: Photo) {
    concurrentPhotoQueue.async(flags: .barrier) {
        self._photos.append(photo)
        DispatchQueue.main.async {
            self.postContentAddedNotification()
        }
    }
  }
  
  func downloadPhotosWithCompletion(_ completion: BatchPhotoDownloadingCompletionClosure?) {
    DispatchQueue.global(qos: .userInitiated).async {
        var storedError: NSError?
        let downloadGroup = DispatchGroup()
        var addresses = [overlyAttachedGirlfriendURLString,
                         successKidURLString,
                         lotsOfFacesURLString]
        addresses += addresses + addresses // 1
        var blocks: [DispatchWorkItem] = [] // 2
        
        for i in 0 ..< addresses.count {
            downloadGroup.enter()
            let block = DispatchWorkItem(flags: .inheritQoS) { // 3
                let index = Int(i)
                let address = addresses[index]
                let url = URL(string: address)
                let photo = DownloadPhoto(url: url!) {
                    _, error in
                    if error != nil {
                        storedError = error
                    }
                    downloadGroup.leave()
                }
                PhotoManager.sharedManager.addPhoto(photo)
            }
            blocks.append(block)
            DispatchQueue.main.async(execute: block) // 4
        }
        
        for block in blocks[3 ..< blocks.count] { // 5
            let cancel = arc4random_uniform(2) // 6
            if cancel == 1 {
                block.cancel() // 7
                downloadGroup.leave() // 8
            }
        }
        
        downloadGroup.notify(queue: DispatchQueue.main) {
            completion?(storedError)
        }
  }
}
  
  fileprivate func postContentAddedNotification() {
    NotificationCenter.default.post(name: Notification.Name(rawValue: photoManagerContentAddedNotification), object: nil)
  }
}
