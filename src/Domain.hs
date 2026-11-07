-- | Logica pura do campeonato. Nenhuma funcao aqui usa IO.
-- Fase 1: so recursao explicita, pattern matching e guards
-- (map/filter/folds ficam para a Fase 2).
module Domain
  ( procurarEquipa
  , resultadoDoJogo
  , jogosDaEquipa
  , jogosDaJornada
  , totalGolos
  , golosMarcadosPor
  , golosSofridosPor
  , classificacaoVazia
  , adicionarJogo
  , classificacaoEquipa
  , diferencaGolos
  , tabelaClassificativa
  , melhorQue
  , ordenarTabela
  ) where

import Model

-- | Procura uma equipa pelo id. Maybe porque pode nao existir.
procurarEquipa :: Int -> [Equipa] -> Maybe Equipa
procurarEquipa _ [] = Nothing
procurarEquipa i (e:es)
  | equipaId e == i = Just e
  | otherwise       = procurarEquipa i es

-- | Resultado de um jogo (guards).
resultadoDoJogo :: Jogo -> Resultado
resultadoDoJogo j
  | golosCasa j > golosFora j = VitoriaCasa
  | golosCasa j < golosFora j = VitoriaFora
  | otherwise                 = Empate

-- | Jogos em que a equipa participou (em casa ou fora).
jogosDaEquipa :: Int -> [Jogo] -> [Jogo]
jogosDaEquipa _ [] = []
jogosDaEquipa i (j:js)
  | equipaCasa j == i || equipaFora j == i = j : jogosDaEquipa i js
  | otherwise                              = jogosDaEquipa i js

-- | Jogos de uma determinada jornada.
jogosDaJornada :: Int -> [Jogo] -> [Jogo]
jogosDaJornada _ [] = []
jogosDaJornada n (j:js)
  | jornada j == n = j : jogosDaJornada n js
  | otherwise      = jogosDaJornada n js

-- | Total de golos marcados em todos os jogos.
totalGolos :: [Jogo] -> Int
totalGolos []     = 0
totalGolos (j:js) = golosCasa j + golosFora j + totalGolos js

-- | Golos marcados por uma equipa.
golosMarcadosPor :: Int -> [Jogo] -> Int
golosMarcadosPor _ [] = 0
golosMarcadosPor i (j:js)
  | equipaCasa j == i = golosCasa j + golosMarcadosPor i js
  | equipaFora j == i = golosFora j + golosMarcadosPor i js
  | otherwise         = golosMarcadosPor i js

-- | Golos sofridos por uma equipa.
golosSofridosPor :: Int -> [Jogo] -> Int
golosSofridosPor _ [] = 0
golosSofridosPor i (j:js)
  | equipaCasa j == i = golosFora j + golosSofridosPor i js
  | equipaFora j == i = golosCasa j + golosSofridosPor i js
  | otherwise         = golosSofridosPor i js

-- | Linha de classificacao sem jogos.
classificacaoVazia :: Int -> Classificacao
classificacaoVazia i = Classificacao i 0 0 0 0 0 0 0

-- | Atualiza a linha de uma equipa com um jogo (se a equipa nele jogou).
adicionarJogo :: Int -> Jogo -> Classificacao -> Classificacao
adicionarJogo i j c
  | equipaCasa j == i = atualizar (golosCasa j) (golosFora j) c
  | equipaFora j == i = atualizar (golosFora j) (golosCasa j) c
  | otherwise         = c

-- | Aplica um resultado (golos marcados, golos sofridos) a uma linha.
atualizar :: Int -> Int -> Classificacao -> Classificacao
atualizar marc sofr c
  | marc > sofr = base { clVitorias = clVitorias c + 1, clPontos = clPontos c + 3 }
  | marc < sofr = base { clDerrotas = clDerrotas c + 1 }
  | otherwise   = base { clEmpates  = clEmpates c + 1,  clPontos = clPontos c + 1 }
  where
    base = c { clJogos     = clJogos c + 1
             , clGolosMarc = clGolosMarc c + marc
             , clGolosSofr = clGolosSofr c + sofr }

-- | Linha de classificacao de uma equipa, percorrendo todos os jogos.
classificacaoEquipa :: Int -> [Jogo] -> Classificacao
classificacaoEquipa i []     = classificacaoVazia i
classificacaoEquipa i (j:js) = adicionarJogo i j (classificacaoEquipa i js)

-- | Diferenca de golos (marcados - sofridos).
diferencaGolos :: Classificacao -> Int
diferencaGolos c = clGolosMarc c - clGolosSofr c

-- | Tabela (sem ordenar) com uma linha por equipa.
tabelaClassificativa :: [Equipa] -> [Jogo] -> [Classificacao]
tabelaClassificativa [] _      = []
tabelaClassificativa (e:es) js =
  classificacaoEquipa (equipaId e) js : tabelaClassificativa es js

-- | A primeira linha fica acima da segunda?
-- Criterios: pontos, depois diferenca de golos, depois golos marcados.
melhorQue :: Classificacao -> Classificacao -> Bool
melhorQue a b
  | clPontos a /= clPontos b             = clPontos a > clPontos b
  | diferencaGolos a /= diferencaGolos b = diferencaGolos a > diferencaGolos b
  | otherwise                            = clGolosMarc a > clGolosMarc b

-- | Ordena a tabela (insertion sort recursivo), melhor primeiro.
ordenarTabela :: [Classificacao] -> [Classificacao]
ordenarTabela []     = []
ordenarTabela (c:cs) = inserir c (ordenarTabela cs)

inserir :: Classificacao -> [Classificacao] -> [Classificacao]
inserir c [] = [c]
inserir c (x:xs)
  | melhorQue c x = c : x : xs
  | otherwise     = x : inserir c xs
