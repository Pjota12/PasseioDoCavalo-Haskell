module Main where

import System.Environment (getArgs)
import ReadFile (readCases)
import HorseTour (horseTour, Pos, Path)


-- Função principal
main :: IO ()
main = do
    args <- getArgs
    let fileName = if null args then "entrada.txt" else head args
    cases <- readCases fileName
    putStrLn "Casos lidos:"
    print cases
    putStrLn "\n --RESULTADOS --\n"
    mapM_ resolverCaso cases
    
resolverCaso :: [Int] -> IO ()
resolverCaso [n, m, x, y]
    | n <= 0 || m <= 0 = putStrLn "Tamanho do tabuleiro inválido."
    | x < 0 || x >= n || y < 0 || y >= m = putStrLn "Posição inicial inválida."
    | otherwise = do
        let boardSize = (n, m)
        let startPos = (x, y)
        let result = horseTour boardSize [startPos] startPos
        case result of
            Just path -> do
                putStr "\nCaminho encontrado para tabuleiro "
                print boardSize
                putStr "Iniciando em "
                print startPos
                putStrLn "Caminho:"
                print path
            Nothing -> putStr "\nNenhum caminho encontrado para tabuleiro " >> print boardSize >> putStrLn ".\n"
resolverCaso _ = putStrLn "Caso inválido."



