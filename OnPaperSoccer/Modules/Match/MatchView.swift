import UIKit

class MatchView: UIView {
    init() {
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Actions

    func draw(line: Line) {
        print(line)
    }
}
