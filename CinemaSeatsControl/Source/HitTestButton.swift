import UIKit

internal class HitTestButton: UIButton {

    internal var hitTestInset: UIEdgeInsets = UIEdgeInsets.zero

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let hitRect: CGRect = bounds.inset(by: hitTestInset)
        return hitRect.contains(point)
    }

}
