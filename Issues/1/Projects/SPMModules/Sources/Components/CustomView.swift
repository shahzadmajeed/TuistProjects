import UIKit

public class CustomView: UIView {
    
    public convenience init(color: UIColor) {
        self.init(frame: .zero)
        setupView(color)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    public func setupView(_ color: UIColor = .red) {
        backgroundColor = color
    }
}
