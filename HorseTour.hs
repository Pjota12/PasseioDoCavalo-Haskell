module HorseTour where

import Data.List (sortOn)
-- Posições e caminhos
type Pos = (Int, Int)
type Path = [Pos]

-- Movimentos possíveis do cavalo no xadrez
moves :: [Pos]
moves = [(2,1), (1,2), (-1,2), (-2,1), (-2,-1), (-1,-2), (1,-2), (2,-1)]

isInside :: (Int, Int) -> Pos -> Bool
isInside (n, m) (x, y) = x >= 0 && x < n && y >= 0 && y < m

-- RETORNA OS MOVIMENTOS VÁLIDOS DO CAVALO
-- validMoves :: (Int, Int) -> Path -> Pos -> [Pos]
-- validMoves boardSize path (x, y) =
--     [ (x + dx , y + dy) | (dx,dy) <- moves,isInside boardSize (x + dx, y + dy), (x + dx, y + dy) `notElem` path ]

validMoves :: (Int, Int) -> Path -> Pos -> [Pos]
validMoves boardSize path (x, y) =
    sortOn (\p -> length (nextMoves p)) possibleMoves --ordena os movimentos possíveis com base na quantidade de movimentos válidos que cada um teria na próxima jogada
    --do menor para o maior
  where
    --Cria a lista de movimentos válidos a partir da posição atual. Só inclui casas que estão dentro do tabuleiro e ainda não foram visitadas
    possibleMoves =
        [ (x+dx, y+dy)
        | (dx,dy) <- moves
        , isInside boardSize (x+dx, y+dy)
        , (x+dx, y+dy) `notElem` path
        ]

    --Para cada posição de possibleMoves, calcula quantos movimentos válidos ela teria se fossemos para lá. Ou seja, olha uma camada à frente.
    nextMoves (a, b) =
        [ (a+dx, b+dy)
        | (dx,dy) <- moves
        , isInside boardSize (a+dx, b+dy)
        , (a+dx, b+dy) `notElem` path
        ]
--VISITA TODOS OS CAMINHOS POSSÍVEIS DO CAVALO --RUIM PRA KRL--
-- horseTour :: (Int, Int) -> Path -> Pos -> [Path]
-- horseTour boardSize path currentPos
--     | length path == n * m = [path]
--     | otherwise = concat [ horseTour boardSize (nextPos : path) nextPos | nextPos <- validMoves boardSize path currentPos ]
--     where (n, m) = boardSize

-- VISITA APENAS O PRIMEIRO CAMINHO ENCONTRADO

--MAYBE
--O tipo maybe serve para representar um valor que pode ou não estar presente
-- Just x -> representa que eu achei um valor x
-- Nothing -> representa que eu não achei nenhum valor

-- Não roda para tabuleiros grandes
horseTour :: (Int, Int) -> Path -> Pos -> Maybe Path
horseTour boardSize path currentPos
    | length path == n*m = Just (reverse path) -- Se o tamanho do caminho for igual ao número de casas, retornamos o caminho
    | otherwise = tryMoves (validMoves boardSize path currentPos) 
    where 
        (n, m) = boardSize
        tryMoves [] = Nothing -- Se não houver mais movimentos válidos, retornamos Nothing
        tryMoves (nextPos:rest) =
            case horseTour boardSize (nextPos : path) nextPos of
                Just p -> Just p -- Se encontramos um caminho válido, retornamos ele
                Nothing -> tryMoves rest -- Caso contrário, tentamos o próximo moviimento

-- Roda para tabuleiros maiores
