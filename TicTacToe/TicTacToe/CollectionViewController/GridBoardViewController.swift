import UIKit

enum WinnerLineType {
    case horizontal
    case vertical
    case northWestdiagonal
    case northEastdiagonal
}

class GridBoardViewController: UICollectionViewController {
    var userChoices: [Int] = []
    var botChoices: [Int] = []
    let winningChoices: [[Int]] = [[0, 1, 2], [3, 4, 5], [6, 7, 8],
                                   [0, 3, 6], [1, 4, 7], [2, 5, 8],
                                   [0, 4, 8], [2, 4, 6]]
    
    var timer: Timer?
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(GridBoardViewCell.self, forCellWithReuseIdentifier: GridBoardViewCell.identifier)
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridBoardViewCell.identifier, for: indexPath) as! GridBoardViewCell
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! GridBoardViewCell
        cell.drawCross()
        cell.isUserInteractionEnabled = false
        cell.backgroundColor = UIColor(red: 221/255.0, green: 221/255.0, blue: 221/255.0, alpha: 1.0)
        collectionView.isUserInteractionEnabled = false
        userChoices.append(indexPath.row)
        guard !isUserWon() else {
            return
        }
        startTimer()
    }
    
    // MARK: - Private
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(botTurn), userInfo: nil, repeats: false)
    }
    
    @objc private func botTurn() {
        let range = Array(0...8)
        let uncheckedRange = range.filter {
            if userChoices.contains($0) || botChoices.contains($0) {
                return false
            }
            return true
        }
        guard !uncheckedRange.isEmpty else {
            parentController().showDrawGameAlert()
            return
        }
        let randomNumber = uncheckedRange.randomElement()!
        let cell = cell(at: randomNumber)
        cell.drawCircle()
        cell.isUserInteractionEnabled = false
        cell.backgroundColor = UIColor(red: 221/255.0, green: 221/255.0, blue: 221/255.0, alpha: 1.0)
        botChoices.append(randomNumber)
        guard !isBotWon() else {
            return
        }
        stopTimer()
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        collectionView.isUserInteractionEnabled = true
    }
    
    private func isUserWon() -> Bool {
        var counter = 0
        for array in winningChoices {
            if array.allSatisfy(userChoices.contains) {
                drawWinningLine(in: array, winnerLineType: winnertType(from: counter))
                parentController().showWinnerSignForUser()
                return true
            }
            counter += 1
        }
        return false
    }
    
    private func isBotWon() -> Bool {
        var counter = 0
        for array in winningChoices {
            if array.allSatisfy(botChoices.contains) {
                drawWinningLine(in: array, winnerLineType: winnertType(from: counter))
                parentController().showWinnerSignForBot()
                return true
            }
            counter += 1
        }
        return false
    }
    
    private func drawWinningLine(in winningArray: [Int], winnerLineType: WinnerLineType) {
        let firstCell = cell(at: winningArray[0])
        let lastCell = cell(at: winningArray[2])
        
        let points = startAndEndPointForWinningLine(startCell: firstCell, lastCell: lastCell, winnerLineType: winnerLineType)
        collectionView.layer.addSublayer(Shapes.drawLine(in: collectionView.bounds, startPoint: points.0, endPoint: points.1))
    }
    
    func startAndEndPointForWinningLine(startCell: GridBoardViewCell, lastCell: GridBoardViewCell, winnerLineType: WinnerLineType) -> (CGPoint, CGPoint) {
        var startPoint: CGPoint = CGPoint()
        var endPoint: CGPoint = CGPoint()
        if winnerLineType == .horizontal {
            startPoint  = CGPointMake(startCell.frame.minX, startCell.frame.midY)
            endPoint  = CGPointMake(lastCell.frame.maxX, lastCell.frame.midY)
        }
        
        if winnerLineType == .vertical {
            startPoint  = CGPointMake(startCell.frame.midX, startCell.frame.minY)
            endPoint  = CGPointMake(lastCell.frame.midX, lastCell.frame.maxY)
        }
        
        if winnerLineType == .northWestdiagonal {
            startPoint  = startCell.frame.origin
            endPoint  = CGPointMake(lastCell.frame.maxX, lastCell.frame.maxY)
        }
        
        if winnerLineType == .northEastdiagonal {
            startPoint  = CGPointMake(startCell.frame.maxX, startCell.frame.minY)
            endPoint  = CGPointMake(lastCell.frame.minX, lastCell.frame.maxY)
        }
        return (startPoint, endPoint)
    }
    
    func winnertType(from index: Int) -> WinnerLineType{
        switch index {
        case 0...2:
            return .horizontal
        case 3...5:
            return .vertical
        case 6:
            return .northWestdiagonal
        case 7:
            return .northEastdiagonal
        default:
            return .horizontal
        }
    }
    
    private func cell(at index: Int) -> GridBoardViewCell {
        let indexpath  = IndexPath(item: index, section: 0)
        let cell = collectionView.cellForItem(at: indexpath) as! GridBoardViewCell
        return cell
    }
    
    private func parentController() -> TicTacToeViewController {
        return self.parent as! TicTacToeViewController
    }
}
