import UIKit

class TicTacToeViewController: UIViewController {
    let gridVc: GridBoardViewController
    
    let winnerLabel = {
        let label = UILabel(frame: CGRectMake(40, 60, 340, 50))
        label.text = "Trips to Win"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .black
        label.backgroundColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let resetButton = {
        let button = UIButton(frame: CGRectMake(150, 660, 120, 40))
        button.backgroundColor = .red
        button.setTitle("Play again", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    var winnerView = {
        let view = UIView(frame: CGRectMake(145, 120, 110, 110))
        view.backgroundColor = .clear
        return view
    }()
    
    let flowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }()
    
    init() {
        gridVc = GridBoardViewController(collectionViewLayout: flowLayout)
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
        
        self.view.addSubview(winnerLabel)
        self.view.addSubview(winnerView)
        self.view.addSubview(resetButton)
        self.addChild(gridVc)
        
        let collectionView = gridVc.collectionView!
        self.view.addSubview(collectionView)
        collectionView.frame = CGRectMake(40, 270, view.frame.width - 80, view.frame.width - 80)
        flowLayout.itemSize = CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height/3)
        collectionView.collectionViewLayout = flowLayout
        gridVc.didMove(toParent: self)
        
        resetButton.addTarget(self, action: #selector(resetGame), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showWinnerSignForUser() {
        showWinnerLabel()
        winnerView.layer.addSublayer(Shapes.drawCross(in: winnerView.frame))
    }
    
    func showWinnerSignForBot() {
        showWinnerLabel()
        winnerView.layer.addSublayer(Shapes.drawCircle(in: winnerView.frame))
    }
    
    @objc func resetGame() {
        gridVc.stopTimer()
        removeSublayers(from: winnerView)
        let cells = gridVc.collectionView.visibleCells
        for cell in cells {
            removeSublayers(from: cell)
            cell.isUserInteractionEnabled = true
            cell.backgroundColor = .white
        }
        if self.winnerLabel.text == "Winner" {
            if let subLayers = gridVc.collectionView.layer.sublayers {
                subLayers[subLayers.endIndex - 1].removeFromSuperlayer()
            }
        }
        
        winnerLabel.text = "Trips to Win"
        gridVc.userChoices.removeAll()
        gridVc.botChoices.removeAll()
    }
    
    func showDrawGameAlert() {
        let alertController = UIAlertController(title: "Game has been drawn", message: "Tap ok to start again", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showWinnerLabel() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {[weak self] in
            guard let self = self else {
                return
            }
            self.winnerLabel.text = "Winner"
            self.winnerLabel.transform = .identity
        }, completion: nil)
    }
    
    func removeSublayers(from customView: UIView) {
        if let sublayers = customView.layer.sublayers {
            for layer in sublayers {
                layer.removeFromSuperlayer()
            }
        }
    }
}
