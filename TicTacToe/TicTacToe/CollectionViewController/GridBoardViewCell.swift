import UIKit

class GridBoardViewCell: UICollectionViewCell {
    
    static let identifier = "GridBoardViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 5.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawCross() {
        layer.addSublayer( Shapes.drawCross(in: self.bounds))
    }
    
    func drawCircle () {
        layer.addSublayer(Shapes.drawCircle(in: self.bounds))
    }
}
