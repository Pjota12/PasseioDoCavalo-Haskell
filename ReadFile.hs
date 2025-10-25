module ReadFile (readCases) where

-- Função que lê o arquivo e retorna uma lista de listas de inteiros
readCases :: FilePath -> IO [[Int]]
readCases fileName = do
    contents <- readFile fileName
    let linhas = lines contents
    let dados = map parseLinha linhas
    return dados  -- ✅ retorna a lista, sem imprimir

-- Converte uma linha em lista de inteiros
parseLinha :: String -> [Int]
parseLinha linha = map read (words linha)

