//
//  DraughtsMove.swift
//  PGNParser
//
//  Created by Liam on 11/04/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

import ParserCombinator

/// The positions on the board conform to an integer number.
typealias BoardPosition = Int

/**
 Describes a single move performed by one player.
 */
public struct DraughtsPieceMove {

    /// The location of the piece which should be moved.
    let origin: BoardPosition
    /// The resting position of the piece after the move is made.
    let destination: BoardPosition
    /// A list of intermediate positions the piece passed through to get to its destination.
    let intermediatePositions: [BoardPosition]
    /// A flag to indicate if any opponenets pieces were captured during the move.
    let isCapture: Bool

}

extension DraughtsPieceMove {

    /**
     A constructor with the parameters in the order of draughts portable game notation.
     
     This constructor simplifies the creation of a parser for the move.
     It should remain in an extension so that it does not replace the default constructor.
     
     - parameter origin: The location of the piece that is to be moved.
     
     - parameter isCapture: True if the piece captures another piece, false if none are captured.
     
     - parameter intermediates: Any position which the piece moved through between its origin and destination.

     - parameter destination: The location at which the piece resides after the move.
     */
    init(origin: BoardPosition, isCapture: Bool, intermediates: [BoardPosition], destination: BoardPosition) {

        self.origin = origin
        self.isCapture = isCapture
        self.intermediatePositions = intermediates
        self.destination = destination

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
    let comment: String?

}

extension DraughtsMove {

    /**
     Parse the input draughts portable game notation string into an array of draughts moves.
     
     Can apply functions to values that are wrapped in a parser context.
     
     - parameter fromPortableGameNotation: The pgn string describing the moves for a draughts game.
     
     - returns: A result of the parse. If successful it will contain the move objects.
     */
    public static func parse(fromPortableGameNotation notation: String) -> ParseResult<[DraughtsMove]> {

        DraughtsNotationParser.portableGameNotation().run(withInput: notation)
    }

}
