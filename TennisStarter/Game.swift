import Foundation

class Game {
    private var player_one_score: Int
    private var player_two_score: Int
    
    init(){
        self.player_one_score = 0
        self.player_two_score = 0
    }
    
    /**Called to add a point to Player 1's score*/
    func addPointToPlayer1(){
        if self.player_one_score == 3 && self.player_two_score == 4{
                self.player_two_score -= 1
        }
        else{
            self.player_one_score += 1
        }
    }
    
    /**Called to add a point to Player 2's score*/
    func addPointToPlayer2(){
        if self.player_two_score == 3 && self.player_one_score == 4{
            self.player_one_score -= 1
        }
        else{
            self.player_two_score += 1
        }
    }
    
    /** Returns either 0, 15, 30, 40 or A, for games in progress, and an empty string if the game is over */
    func player1Score() -> String {
        switch self.player_one_score{
        case 0:
            return "0"
        case 1:
            return "15"
        case 2:
            return "30"
        case 3:
            return "40"
        case 4:
            return "A"
        default:
            return ""
        }
    }
    
    /** Returns either 0, 15, 30, 40 or A, for games in progress, and an empty string if the game is over */
    func player2Score() -> String {
        switch self.player_two_score{
        case 0:
            return "0"
        case 1:
            return "15"
        case 2:
            return "30"
        case 3:
            return "40"
        case 4:
            return "A"
        default:
            return ""
        }
    }
    
    /**Returns true if Player 1 has won this game*/
    func player1Won() -> Bool{
        if self.player_one_score == 5 && self.player_two_score <= 3{
            return true
        }
        if self.player_one_score == 4 && self.player_two_score <= 2{
            return true
        }
            return false
    }
    
    /**Returns true if Player 2 has won this game*/
    func player2Won() -> Bool{
        if self.player_two_score == 5 && self.player_one_score <= 3{
            return true
        }
        if self.player_two_score == 4 && self.player_one_score <= 2{
            return true
        }
            return false
    }

    
    /*Returns true if this game is over*/
    func complete() ->Bool {
        if self.player1Won() || self.player2Won(){
            return true
        }
        return false
    }
    
    
    /**Returns the number of 'game points', if any, that player 1 has. A player has a 'game point' if they would win the game if the win the next point. How many game points they have depends on how many point their opponent would need to catch up with them*/
    func gamePointsForPlayer1() -> Int{
        //only needs implementing for the 'higher' tier of marks
        if self.player_one_score >= 3{
            return self.player_one_score - self.player_two_score
        }
        else{
            return 0
        }
    }
    
    /**Returns the number of 'game points', if any, that player 2 has. A player has a 'game point' if they would win the game if the win the next point. How many game points they have depends on how many point their opponent would need to catch up with them*/
    func gamePointsForPlayer2() -> Int {
        //only needs implementing for the 'higher' tier of marks
        if self.player_two_score >= 3{
            return self.player_two_score - self.player_one_score 
        }
        else{
            return 0
        }
    
    }
}
