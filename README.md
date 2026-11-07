# Campeonato de Futebol (Haskell)

Projeto de Programação Funcional — **Fase 1: modelação e núcleo funcional**.

## Descrição
Sistema para gerir um campeonato de futebol: equipas, jogos e tabela
classificativa. Nesta fase o núcleo é feito apenas com tipos de dados,
pattern matching, guards e recursão explícita.

## Estrutura
```
├── README.md
├── campeonato.cabal
├── src/
│   ├── Model.hs        -- tipos: Equipa, Jogo, Resultado, Classificacao
│   ├── Domain.hs       -- funções puras (sem IO)
│   └── SampleData.hs   -- dados de demonstração
├── app/Main.hs         -- demonstração (único módulo com IO)
├── data/               -- reservado para ficheiros (Fase 3)
└── test/               -- reservado para testes (Fase 2)
```

## Compilar e executar
Requer GHC e Cabal (instalação via [GHCup](https://www.haskell.org/ghcup/)).
```bash
cabal build
cabal run campeonato
```

## Regras implementadas
- Vitória = 3 pontos, empate = 1, derrota = 0.
- Desempate: pontos, depois diferença de golos, depois golos marcados.

## Grupo
- Diogo Campos (al2024152174)
- Diogo Gonçalves (al2025153043)
- José Silva (al2025166886)

