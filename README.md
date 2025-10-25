# **Passeio do Cavalo (Haskell)**

## Descrição do Problema
Este projeto implementa uma variante do problema classico **Passeio do Cavalo**

o objetivo é verificar, para diferentes tabuleiros e posições iniciais, se é possivel encontrar um caminho aberto percorrido pelo cavalo, conforme suas regras de movimento no xadrez.

Um caminho é considerado aberto quando:

- O cavalo visita todas as casas do tabuleiro uma única vez, sem repetições.

- A última posição não pode alcançar a primeira em um único movimento (diferente de um passeio fechado).

# **Entrada**
o programa recebe um arquivo texto contendo várias linhas.
Cada linha possui quadro números inteiros, separados por espaços

```
    Linhas Colunas Linha_Inicial Coluna_Inicial
```
## **Exemplo**
```haskell
    8 8 0 0 -- 8x8 (0,0)
    9 8 1 2 -- 9x8 (1,2)
    5 6 4 5 -- 5x6 (4,5)
```

# **Saida**

Para cada linha do arquivo de entrada, o programa exibirá:
- o caminho encontrado (sequencia de posições visitadas pela peça), se existir.
- Ou uma mensagem indicando que não é possivel contruir um passeio aberto para aquele caso.

# **Estratégia Ultilizada**
A solução foi desenvolvida em Haskell utilizando uma abordagem de busca com heurística, inspirada na heurística de Warnsdorff, priorizando sempre movimentos que levam a posições com menor quantidade de próximos movimentos possíveis e ultilizando backtracking

Isso ajuda a reduzir o espaço de busca e aumenta a chance de encontrar soluções em tabuleiros maiores.

Dentro do arquivo **HorseTour.hs** a função `validMoves` monta uma lista de proximos movimentos para a posição atual do cavalo, ordenando os movimentos, de menor ao maior, de acordo com a quantidade de proximos movimentos futuros para cada movimento presente na lista, ou seja, permite a aplicação da Heurística de Warnsdorff.

Apartir dessa função é possivel desenvolver a função recursiva `horseTour`, onde:
- **Caso base**: se o tamanho do caminho for igual ao número total de casas no tabuleiro, o que significa que o cavalo já visitou todas as posições exatamente uma vez, ela retorna o caminho completo.

- **Caso Recursivo**: Caso ainda não tenha visitado todas as casas, ela calcula os movimentos válidos a partir da posição atual usando `validMoves` chamando a função `tryMoves`, declarada internamente, que para cada movimento possivel na ordem fornecida, chama recursivamente o `horseTour` adicionando essa nova posição ao caminho e se a chamada recursiva retornar um caminho válido (Just p), ela retorna esse caminho imediatamente. Caso contrário, ela tenta o próximo movimento.

# **Como Executar**
## **Pré Requisito**
- GHC ou GHCi instalado
- Opcional: pacote runghc para execução direta sem compilação

### **Execução direta**
```
runghc main.hs Entrada.txt
```
# **Arquivos Inclusos**
| Arquivo                                | Descrição                          |
| -------------------------------------- | ---------------------------------- |
| `main.hs`                              | Código fonte principal do programa |
| `ReadFile.hs`                          | Leitura do arquivo de entrada           |
| `Entrada.txt`                          | Arquivo exemplo de entrada         |
| `HourseTour.hs`                        | Código que implementa a solução do problema    |

# **Integrantes**
- Camille de sá
- Leticia Leal
- Paulo Jorge Campos Cardoso
