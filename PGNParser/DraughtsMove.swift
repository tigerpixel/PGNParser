//
//  DraughtsMove.swift
//  PGNParser
//
//  Created by Liam on 11/04/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

import Foundation
import ParserCombinator

/**
 Describes a single move performed by one player.
 */
public struct DraughtsPieceMove {
    
    let from: Int
    let to: Int
    let hasCapture: Bool
    
}

extension DraughtsPieceMove {
    
    /**
     A constructor with the parameters in the order of draughts portable game notation.
     
     This constructor simplifies the creation of a parser for the move.
     It should remain in an extension so that it does not replace the default constructor.
     
     - parameter from: The location of the piece that is to be moved.
     
     - parameter hasCapture: True if the piece captures another piece, false if none are captured.
     
     - parameter to: The location at which the piece resides after the move.
     */
    init(from: Int, hasCapture: Bool, to: Int) {
        self.from = from
        self.to = to
        self.hasCapture = hasCapture
    }
    
}

/**
 A description of the movement of pieces by both players.
 
 Black is optional as it may not have moved in this round.
 A move in technical draughts terms refers to a round of moves by both players.
 */
public struct DraughtsMove {
    
    let white: DraughtsPieceMove
    let black: DraughtsPieceMove?
    
}

extension DraughtsMove {
    
    /**
     Parse the input draughts portable game notation string into an array of draughts moves.
     
     Can apply functions to values that are wrapped in a parser context.
     
     - parameter fromPortableGameNotation: The pgn string describing the moves for a draughts game.
     
     - returns: A result of the parse. If successful it will contain the move objects.
     */
    public static func parse(fromPortableGameNotation notation: String) -> ParseResult<[DraughtsMove]> {
        
        return DraughtsNotationParser.portableGameNotation().run(withInput: notation)
    }
    
}
