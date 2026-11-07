-- | Modelo de dominio do campeonato de futebol.
module Model
  ( Equipa(..)
  , Jogo(..)
  , Resultado(..)
  , Classificacao(..)
  ) where

-- | Uma equipa inscrita no campeonato.
data Equipa = Equipa
  { equipaId   :: Int
  , nomeEquipa :: String
  , cidade     :: String
  } deriving (Show, Eq)

-- | Um jogo ja realizado entre duas equipas (referidas pelo id).
data Jogo = Jogo
  { jogoId     :: Int
  , jornada    :: Int
  , equipaCasa :: Int
  , equipaFora :: Int
  , golosCasa  :: Int
  , golosFora  :: Int
  } deriving (Show, Eq)

-- | Resultado de um jogo do ponto de vista da equipa da casa.
data Resultado = VitoriaCasa | Empate | VitoriaFora
  deriving (Show, Eq)

-- | Linha da tabela classificativa de uma equipa.
data Classificacao = Classificacao
  { clEquipa    :: Int
  , clJogos     :: Int
  , clVitorias  :: Int
  , clEmpates   :: Int
  , clDerrotas  :: Int
  , clGolosMarc :: Int
  , clGolosSofr :: Int
  , clPontos    :: Int
  } deriving (Show, Eq)
