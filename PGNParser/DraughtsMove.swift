//
//  DraughtsMove.swift
//  PGNParser
//
//  Created by Liam on 11/04/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

import ParserCombinator

/// The positions on the board conform to an interger number.
typealias BoardPosition = Int

/**
 Describes a single move performed by one player.
 */
public struct DraughtsPieceMove {

    /// The location of the piece which should be moved.
    let origin: BoardPosition
    /// The resting position of the piece after the move is made.
    let destination: BoardPosition
    /// A flag to indicate if any opponenets pieces were captured during the move.
    let isCapture: Bool

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
    init(origin: BoardPosition, isCapture: Bool, destination: BoardPosition) {

        self.origin = origin
        self.destination = destination
        self.isCapture = isCapture
    }

}

/**
 A description of the movement of pieces by both players.
 
 A move in technical draughts terms refers to a round of moves by both players.
 Black is optional as it may not have moved in this round.
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
