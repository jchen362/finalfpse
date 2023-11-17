(lang dune 3.10)

(generate_opam_files)

(authors "Jianwei Chen" "Sana Mahmood" "Brandon Wong")

(maintainers "jchen362@jh.edu" "smahmo12@jh.edu" "bwong19@jh.edu")

(package
 (name chess_ai)
 (synopsis "An AI-based chess move suggester")
 (description
  "This package uses a minimax algorithm with alpha-beta pruning to suggest moves for a chess player given a starting board state.")
 (depends core ounit2 dream yojson))
