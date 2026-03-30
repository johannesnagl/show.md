import Cocoa
import Quartz

class PreviewViewController: NSViewController, QLPreviewingController {
    func preparePreviewOfFile(at url: URL, completionHandler handler: @escaping (Error?) -> Void) {
        handler(nil)
    }
}
