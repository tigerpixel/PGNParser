//
//  DraughtsMove.swift
//  PGNParser
//
//  Created by Liam on 11/04/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

import Foundation
import ParserCombinator

public struct DraughtsPieceMove {
    
    let from: Int
    let to: Int
    let hasCapture: Bool
    
}

extension DraughtsPieceMove {
    
    init(from: Int, hasCapture: Bool, to: Int) {
        self.from = from
        self.to = to
        self.hasCapture = hasCapture
    }
    
}

public struct DraughtsMove {
    
    let white: DraughtsPieceMove
    let black: DraughtsPieceMove?
    
}

public enum Winner {
    
    case black
    case white
    case draw
    
}

extension DraughtsMove {
    
    /** */
    public static func parse(fromPortableGameNotation notation: String) -> ParseResult<[DraughtsMove]> {
        
        return DraughtsNotationParser.portableGameNotation().run(withInput: notation)
    }
    
}
