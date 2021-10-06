//
//  Set.swift
//  TennisStarter
//
//  Created by Aaron Wolfenden on 08/05/2018.
//  Copyright © 2018 University of Chester. All rights reserved.
//

import Foundation

class Sets{
    private var player_one_games_points: Int
    private var player_two_games_points: Int
    private var game: Game
    private var tie_break_flag: Bool
    
    init(){
        self.player_one_games_points = 0
        self.player_two_games_points = 0
        self.game = Game()
        self.tie_break_flag = false
    }
    
    
    
    func addGamePointP1(){
        self.player_one_games_points += 1
    }
    
    func addGamePointP2(){
        self.player_two_games_points += 1
    }
    
    /* Returns true if player one has won set */
    func player1WonSet() -> Bool{
        if self.player_one_games_points >= 6{
            if self.player_one_games_points >= (self.player_two_games_points + 2){
                return true
            }
        }
        if self.tie_break_flag == true{
            if self.player_one_games_points == 7{
                return true
            }
        }
        return false
    }
    
    func player2WonSet() -> Bool{
        if self.player_two_games_points >= 6{
            if self.player_two_games_points >= (self.player_one_games_points + 2){
                return true
            }
        }
        if self.tie_break_flag == true{
            if self.player_two_games_points == 7{
                return true
            }
        }
        return false
    }
    
    func setComplete() -> Bool{
        if self.player1WonSet() == true || self.player2WonSet() == true{
            return true
        }
        return false
    }
    
    func checkForSetTie() -> Bool{
        if self.player_one_games_points == 6 && self.player_two_games_points == 6{
            return true
        }
        return false
    }
    
    func flagSetTie(){
        if tie_break_flag == false{
        tie_break_flag = true
        }
        else{
        tie_break_flag = false
        }
    }
    
    func getGamesP1Points() -> String{
        return String(self.player_one_games_points)
    }
    
    func getGamesP2Points() -> String{
        return String(self.player_two_games_points)
    }
    
    func setPointsForPlayer1() -> Int{
        return 0
    }
    func setPointsForPlayer2() -> Int{
        return 0
    }
    
    
}
