-- | Demonstracao. Todo o IO fica aqui; a logica esta em Domain.
module Main (main) where

import Domain
import Model
import SampleData

nomeDe :: Int -> String
nomeDe i = case procurarEquipa i equipas of
  Just e  -> nomeEquipa e
  Nothing -> "Desconhecida"

linha :: Classificacao -> String
linha c = nomeDe (clEquipa c) ++ " | J:" ++ show (clJogos c)
  ++ " V:" ++ show (clVitorias c) ++ " E:" ++ show (clEmpates c)
  ++ " D:" ++ show (clDerrotas c) ++ " GM:" ++ show (clGolosMarc c)
  ++ " GS:" ++ show (clGolosSofr c) ++ " Pts:" ++ show (clPontos c)

mostrar :: [Classificacao] -> IO ()
mostrar []     = return ()
mostrar (c:cs) = putStrLn (linha c) >> mostrar cs

main :: IO ()
main = do
  putStrLn "=== Tabela classificativa ==="
  mostrar (ordenarTabela (tabelaClassificativa equipas jogos))
  putStrLn ""
  putStrLn ("Total de golos no campeonato: " ++ show (totalGolos jogos))
  putStrLn ("Jogos da jornada 2: " ++ show (length (jogosDaJornada 2 jogos)))
  putStrLn ("Equipa 9 existe? " ++ show (procurarEquipa 9 equipas))
