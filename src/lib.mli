type piece_type = Pawn | Rook | Knight | Queen | King

module type Piece = 
    sig
        val piece: string
        val calculate_valid_moves: int -> int -> (*board state*) -> int list
    end

module Pawn: Piece
module Rook: Piece
module King: Piece
module Queen: Piece
module Bishop: Piece
module Knight: Piece