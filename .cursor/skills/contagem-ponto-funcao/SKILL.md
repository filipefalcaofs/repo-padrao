---
name: contagem-ponto-funcao
description: Use when the user asks for contagem de ponto de função, APF, IFPUG, análise de pontos de função, preencher planilha de contagem, estimar tamanho funcional, revisar TD/AR/TR, ALI/AIE/EE/CE/SE, ou validar contagem para contrato/fiscal.
---

# Contagem de Ponto de Função

## Princípio

Conte pela visão funcional do usuário, não pelo código. O código-fonte, rotas, endpoints, classes, migrations e tabelas físicas podem ajudar a tirar dúvidas, mas a contagem deve ser defensável por requisitos, telas, fluxos, regras de negócio, modelo conceitual e evidências funcionais.

Uma função só entra na contagem se for reconhecida pelo usuário e pertencer à fronteira definida.

## Fluxo Obrigatório

1. Defina o propósito da contagem: desenvolvimento, melhoria, aplicação/baseline ou estimativa.
2. Defina a fronteira da aplicação e os atores/sistemas externos.
3. Levante evidências funcionais: requisitos, telas, fluxos, manuais, regras, relatórios, protótipos, integrações e entrevistas.
4. Identifique grupos funcionais em linguagem de negócio.
5. Classifique funções de dados: `ALI` e `AIE`.
6. Classifique funções transacionais por processo elementar: `EE`, `CE`, `SE`.
7. Para cada função contável, registre TD e AR/TR com memória auditável.
8. Revise itens auxiliares e remova o que não for processo elementar.
9. Valide a planilha: fórmulas, totais, grupos sem pontuação, justificativas e ausência de termos técnicos indevidos.

## Processo Elementar

Conte uma transação apenas se ela atender a todos os critérios:

- Tem significado para o usuário.
- É uma transação completa.
- É autocontida.
- Deixa o negócio em estado consistente ou entrega resposta funcional completa.

Não conte separadamente passos que só existem para viabilizar outra função, salvo quando o usuário os reconhece como consulta/operação completa e obrigatória. Exemplo: consulta a SEFAZ por CGA pode ser `CE` própria se for etapa obrigatória, acionada pelo usuário, com retorno funcional usado para concluir o cadastro.

## Tipos de Função

| Tipo | Use quando |
|---|---|
| `ALI` | Grupo lógico de dados mantido pela aplicação dentro da fronteira. |
| `AIE` | Grupo lógico de dados usado pela aplicação, mas mantido por outro sistema. |
| `EE` | Entrada externa que mantém dados, altera estado ou dispara processo de negócio. |
| `CE` | Consulta simples, com entrada/saída, sem cálculo relevante e sem atualização de dados. |
| `SE` | Saída com cálculo, derivação, relatório, arquivo, PDF, notificação funcional ou processamento relevante. |

## O Que Não Contar Separadamente

- Rotas, endpoints, controllers, services, componentes, jobs ou código.
- Tabelas físicas isoladas, pivôs e campos técnicos sem significado funcional próprio.
- Abas, modais, botões, CSS, paginação, ordenação e máscaras.
- Callback técnico, popup técnico, health check, sessão, cache, fila, token interno.
- Busca auxiliar, pré-validação ou carregamento parcial quando não forem transações completas para o usuário.
- Notificação automática se for apenas consequência de um `EE` já contado, salvo se for saída funcional autônoma exigida pelo usuário/contrato.

## Funções de Dados

Agrupe dados por domínio funcional, não por tabela.

`ALI/AIE` não é tela, tabela, endpoint ou aba. É um grupo lógico de dados
reconhecido pelo usuário. Antes de separar um novo `ALI/AIE`, aplique o teste
CPM de independência:

- O grupo de dados tem significado para o negócio por si só, sem depender de
  uma ocorrência de outro grupo?
- Se a ocorrência do dado pai fosse excluída, este dado continuaria existindo
  e tendo significado funcional independente para o usuário?
- Ele é criado/excluído de forma independente, ou é criado/excluído junto com o
  dado pai?

Se a resposta indicar dependência funcional, não conte como `ALI/AIE` separado.
Conte como `TR/RLR` dentro do arquivo lógico principal. Exemplos comuns de
subgrupos dependentes que normalmente viram `TR/RLR`: itens/detalhes,
endereços, contatos, retificações, movimentações, documentos anexos, vínculos,
históricos, versões, tentativas, substituições, condições, ações e execuções.

Entidades associativas/key-to-key, pivôs, tabelas de relacionamento e vínculos
sem atributos funcionais próprios não são arquivos lógicos. Agrupe as chaves
estrangeiras como dados elementares dos arquivos lógicos relacionados quando
forem reconhecidas pelo usuário.

Dados de código, domínio simples, status, tipos e catálogos auxiliares só devem
ser contados como `ALI` quando houver manutenção funcional reconhecida pelo
usuário e o dado influenciar processos elementares como informação de controle.
Caso contrário, exclua da contagem ou trate como parte do `TD/DER` de outro
arquivo lógico.

Para cada `ALI/AIE`, registre:

```text
TD/DER considerados: [lista de dados elementares reconhecidos pelo usuário]
TR/RLR considerados: [subgrupos funcionais reconhecidos pelo usuário]
Justificativa CPM: [por que é ALI/AIE independente, ou por que subgrupos foram agrupados como TR/RLR]
Evidência funcional: [tela, requisito, relatório, fluxo, regra, entrevista]
```

Não concentre todos os `ALI/AIE` em um único bloco se a planilha estiver organizada por grupos funcionais. Posicione cada arquivo lógico no grupo em que o dado é reconhecido ou administrado.

Também não faça o oposto: não quebre um arquivo lógico em vários `ALI/AIE`
apenas porque existem várias tabelas, abas ou estruturas internas. Se o usuário
enxerga um único objeto de negócio composto, conte um `ALI/AIE` com múltiplos
`TR/RLR`.

## Funções Transacionais

Para cada `EE/CE/SE`, registre:

```text
Processo elementar: [verbo + objeto de negócio]
TD considerados: [campos de entrada/saída reconhecidos pelo usuário]
AR/TR considerados: [arquivos lógicos lidos, mantidos ou referenciados; não tabelas físicas]
Justificativa: [por que é EE, CE ou SE]
Evidência funcional: [tela, requisito, fluxo, relatório, regra, entrevista]
```

Use nomes funcionais: `Consultar estabelecimento na SEFAZ por CGA`, não `buscarSefaz` ou nome de rota.

## TD, AR e TR Auditáveis

Não use números "de cabeça". Cada TD/AR/TR deve poder ser explicado.

Checklist por função:

- [ ] O nome está em linguagem de negócio.
- [ ] O tipo funcional está justificado.
- [ ] TD lista dados reconhecidos pelo usuário, não campos técnicos.
- [ ] AR/TR lista arquivos lógicos, não tabelas físicas.
- [ ] Cada `ALI/AIE` passou pelo teste CPM de independência funcional.
- [ ] Detalhes, versões, históricos, vínculos, tentativas e itens dependentes foram tratados como `TR/RLR`, não como `ALI/AIE`.
- [ ] A função é processo elementar ou arquivo lógico.
- [ ] A evidência funcional existe ou a premissa está declarada.
- [ ] A observação permite conferência por fiscal/analista sem ler código-fonte.

Se não for possível auditar TD/AR/TR, marque como pendência ou use estimativa declarada. Não apresente como contagem detalhada definitiva.

## Planilhas Oficiais

Ao preencher modelo oficial:

- Preserve abas, fórmulas, mesclagens e estrutura do modelo.
- Não adicione abas sem autorização explícita.
- Use linhas de grupo apenas como título, sem tipo, TD, AR/TR ou PF.
- Coloque a pontuação apenas nos itens abaixo do grupo.
- Ordene grupos de forma didática quando útil: retaguarda, portal, público/transversal.
- Use `Observações` para justificar a contagem em linguagem funcional.

## Revisão Final

Antes de entregar:

1. Verifique se não há contagem em linhas de grupo.
2. Confira duplicidades e itens auxiliares indevidos.
3. Recalcule ou valide os totais.
4. Procure termos técnicos indevidos: controller, route, endpoint, request, migration, model, código-fonte.
5. Procure `ALI/AIE` suspeitos com nomes como item, detalhe, versão, histórico, vínculo, movimentação, tentativa, substituição, condição, ação, execução, anexo ou endereço; reavalie como `TR/RLR` antes de entregar.
6. Confirme que cada `ALI/AIE` tem justificativa CPM de independência funcional e que cada transação referencia arquivos lógicos, não tabelas.
7. Confirme que cada função tem justificativa de TD/DER e AR/TR.
8. Informe claramente o nível da contagem: indicativa, estimativa ou detalhada.

## Resposta ao Usuário

Quando finalizar uma contagem, informe:

- arquivo gerado/alterado;
- tipo de contagem e fronteira;
- quantidade de funções contáveis;
- total de PF não ajustado;
- principais premissas;
- limitações ou pendências de auditoria.
