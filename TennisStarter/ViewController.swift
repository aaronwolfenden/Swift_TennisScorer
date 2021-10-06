import UIKit

class ViewController: UIViewController {
    private var set = Sets()
    private var match = Match()
    private var game = Game()
    private var game_point_p1: Int = 0
    private var game_point_p2: Int = 0
    private var firstPass = true

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateServerLabel()
    }

    @IBOutlet weak var p1NameLabel: UILabel!
    @IBOutlet weak var p2NameLabel: UILabel!
    
    @IBOutlet weak var p1PointsLabel: UILabel!
    @IBOutlet weak var p2PointsLabel: UILabel!
    
    @IBOutlet weak var p1GamesLabel: UILabel!
    @IBOutlet weak var p2GamesLabel: UILabel!
    
    @IBOutlet weak var p1SetsLabel: UILabel!
    @IBOutlet weak var p2SetsLabel: UILabel!

    @IBOutlet weak var p1PreviousSetsLabel: UILabel!
    @IBOutlet weak var p2PreviousSetsLabel: UILabel!
    
    @IBOutlet weak var playerOneButton: UIButton!
    @IBOutlet weak var playerTwoButton: UIButton!
    
    /* Function when player 1 is pressed */
    @IBAction func p1AddPointPressed(_ sender: UIButton) {
        game.addPointToPlayer1()
        if set.checkForSetTie(){
            match.tieBreakerServer()
            updateServerLabel()
        }
        if game.complete(){
            set.addGamePointP1()
            p1GamesLabel.text = set.getGamesP1Points()
            if set.checkForSetTie() && match.getSetPlayedAmount() != 4{
                game = Game_Tiebreak()
                match.resetCounter()
                set.flagSetTie()
            }
            else{
              game = Game()
            }
            match.callForNewBalls()
            match.rotateServer()
            updateServerLabel()
            if set.setComplete(){
                match.add_set_point_p1()
                if firstPass == true{
                    p1PreviousSetsLabel.text = String(set.getGamesP1Points())
                    p2PreviousSetsLabel.text = String(set.getGamesP2Points())
                    firstPass = false
                }
                else{
                    p1PreviousSetsLabel.text = String(p1PreviousSetsLabel.text! + "," + set.getGamesP1Points())
                    p2PreviousSetsLabel.text = String(p2PreviousSetsLabel.text! + "," + set.getGamesP2Points())
                }
                p1SetsLabel.text = match.get_set_p1_points()
                p1GamesLabel.text = "0"
                p2GamesLabel.text = "0"
                set = Sets()
                if match.matchComplete(){
                    displayFinishedMatchMessage()
                    playerOneButton.isEnabled = false
                    playerTwoButton.isEnabled = false
                    
                }
            }
        }
        p1PointsLabel.text = game.player1Score()
        p2PointsLabel.text = game.player2Score()
        showGamePoints()
    }

    /* Function when player 2 is pressed */
    @IBAction func p2AddPointPressed(_ sender: UIButton) {
        game.addPointToPlayer2()
        if set.checkForSetTie(){
            match.tieBreakerServer()
            updateServerLabel()
        }
        if game.complete(){
            set.addGamePointP2()
            p2GamesLabel.text = set.getGamesP2Points()
            if set.checkForSetTie() && match.getSetPlayedAmount() != 4{
                game = Game_Tiebreak()
                match.resetCounter()
                set.flagSetTie()
            }
            else{
                game = Game()
            }
            match.callForNewBalls()
            match.rotateServer()
            updateServerLabel()
            if set.setComplete(){
                match.add_set_point_p2()
                if firstPass == true{
                    p1PreviousSetsLabel.text = String(set.getGamesP1Points())
                    p2PreviousSetsLabel.text = String(set.getGamesP2Points())
                    firstPass = false
                }
                else{
                    p1PreviousSetsLabel.text = String(p1PreviousSetsLabel.text! + "," + set.getGamesP1Points())
                    p2PreviousSetsLabel.text = String(p2PreviousSetsLabel.text! + "," + set.getGamesP2Points())
                }
                p2SetsLabel.text = match.get_set_p2_points()
                p1GamesLabel.text = "0"
                p2GamesLabel.text = "0"
                set = Sets()
                if match.matchComplete(){
                    displayFinishedMatchMessage()
                    playerOneButton.isEnabled = false
                    playerTwoButton.isEnabled = false
                }
            }
        }
        p2PointsLabel.text = game.player2Score()
        p1PointsLabel.text = game.player1Score()
        showGamePoints()
    }

    /* Function when restart is pressed */
    @IBAction func Restart(_ sender: UIButton) {
        /* Reinitialises Classes & UI */
        match = Match()
        set = Sets()
        game = Game()
        firstPass = true
        p1GamesLabel.text = set.getGamesP1Points()
        p2GamesLabel.text = set.getGamesP2Points()
        p1PointsLabel.text = game.player1Score()
        p2PointsLabel.text = game.player1Score()
        p1SetsLabel.text = match.get_set_p1_points()
        p2SetsLabel.text = match.get_set_p2_points()
        p1PreviousSetsLabel.text = ""
        p2PreviousSetsLabel.text = ""
        playerOneButton.isEnabled = true
        playerTwoButton.isEnabled = true
        p1NameLabel.backgroundColor = UIColor.yellow
        p2NameLabel.backgroundColor = UIColor.white
    }
    
    /* Sets The Name Label Colour For Server */
    func updateServerLabel(){
        if match.getCurrentServer() == 1{
            p1NameLabel.backgroundColor = UIColor.yellow
            p2NameLabel.backgroundColor = UIColor.white
        }
        else{
            p1NameLabel.backgroundColor = UIColor.white
            p2NameLabel.backgroundColor = UIColor.yellow
        }
        
    }
    
    /* Sets The Background Colour For Game Point */
    func showGamePoints(){
        if game.gamePointsForPlayer1() > 0{
            p1PointsLabel.backgroundColor = UIColor.green
            p2PointsLabel.backgroundColor = UIColor.white
        }
        else if game.gamePointsForPlayer2() > 0{
            p2PointsLabel.backgroundColor = UIColor.green
            p1PointsLabel.backgroundColor = UIColor.white
        }
        else{
            p2PointsLabel.backgroundColor = UIColor.white
            p1PointsLabel.backgroundColor = UIColor.white
        }
    }
    
    /* Calls an alert box to tell the user the match has finished */
    func displayFinishedMatchMessage(){
        var winning_player: String = ""
        if match.player1WonMatch(){
            winning_player = "Player One"
        }
        else if match.player2WonMatch(){
            winning_player = "Player Two"
        }
        
        let alert = UIAlertController(title: "Congratulations", message: winning_player + " Won The Match!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Continue", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"Continue\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

