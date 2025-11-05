module HorseTour where

-- Posições e caminhos
type Pos = (Int, Int)
type Path = [Pos]

-- Movimentos possíveis do cavalo no xadrez
moves :: (Int, Int) -> [Pos]
moves (n,m) 
    | n <= m = [(2,1), (-2,1), (-2,-1), (2,-1),(1,2), (-1,2),(-1,-2), (1,-2)]
    | n > m = [(1,2),(1,-2), (-1,-2),(-1,2), (2,1), (2,-1),(-2,-1), (-2,1)]
        
isInside :: (Int, Int) -> Pos -> Bool
isInside (n, m) (x, y) = x >= 0 && x < n && y >= 0 && y < m


-- Quicksort customizado
quicksortBy :: (a -> a -> Bool) -> [a] -> [a]
quicksortBy _ [] = []
quicksortBy cmp (x:xs) =
    let smallerSorted = quicksortBy cmp [a | a <- xs, cmp a x]   -- "menores"
        biggerSorted  = quicksortBy cmp [a | a <- xs, not (cmp a x)]  -- "maiores ou iguais"
    in  smallerSorted ++ [x] ++ biggerSorted

-- RETORNA OS MOVIMENTOS VÁLIDOS DO CAVALO ORDENADOS PELO NÚMERO DE MOVIMENTOS VÁLIDOS A PARTIR DE CADA POSIÇÃO
validMoves :: (Int, Int) -> Path -> Pos -> [Pos]
validMoves boardSize path (x, y) =
    quicksortBy (\a b -> movesCount a < movesCount b) possibleMoves
  where
    -- Movimentos possíveis a partir da posição atual
    possibleMoves =
        [ (x+dx, y+dy)
        | (dx, dy) <- moves boardSize
        , isInside boardSize (x+dx, y+dy)
        , (x+dx, y+dy) `notElem` path
        ]

    movesCount :: Pos -> Int -- 
    movesCount (a, b) =
        length
          [ (a+dx, b+dy)
          | (dx, dy) <- moves boardSize
          , isInside boardSize (a+dx, b+dy)
          , (a+dx, b+dy) `notElem` path
          ]

isOpen :: Pos -> Pos -> (Int, Int) -> Bool
isOpen (x1, y1) (x2, y2) boardSize =
    -- Verifica se (x2, y2) é um movimento de cavalo válido a partir de (x1, y1) 
    let nextMoves = [ (x1+dx, y1+dy) | (dx,dy) <- moves boardSize, isInside boardSize (x1+dx, y1+dy)]
    in notElem(x2,y2) nextMoves


-- Não roda para tabuleiros grandes
horseTour :: (Int, Int) -> Path -> Pos -> Maybe Path
horseTour boardSize path currentPos
    | length path == n*m = 
        let firstPos = last path
            lastPos = currentPos
        in
        if isOpen firstPos lastPos boardSize
            then Just (reverse path) -- Retorna o caminho completo se for um passeio fechado
            else Nothing -- Retorna Nothing se não for um passeio fechado
    | otherwise = tryMoves (validMoves boardSize path currentPos) 
    where 
        (n, m) = boardSize
        tryMoves [] = Nothing -- Se não houver mais movimentos válidos, retornamos Nothing
        tryMoves (nextPos:rest) =
            case horseTour boardSize (nextPos : path) nextPos of
                Just p -> Just p -- Se encontramos um caminho válido, retornamos ele
                Nothing -> tryMoves rest -- Caso contrário, tentamos o próximo moviimento

