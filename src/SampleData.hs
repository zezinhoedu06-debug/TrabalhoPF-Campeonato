-- | Dados de demonstracao: 4 equipas, 3 jornadas (todos contra todos).
module SampleData (equipas, jogos) where

import Model

equipas :: [Equipa]
equipas =
  [ Equipa 1 "FC Porto"     "Porto"
  , Equipa 2 "SL Benfica"   "Lisboa"
  , Equipa 3 "Sporting CP"  "Lisboa"
  , Equipa 4 "SC Braga"     "Braga"
  ]

jogos :: [Jogo]
jogos =
  [ Jogo 1 1 1 2 2 1
  , Jogo 2 1 3 4 1 1
  , Jogo 3 2 2 3 0 0
  , Jogo 4 2 4 1 0 3
  , Jogo 5 3 1 3 1 2
  , Jogo 6 3 2 4 4 0
  ]
