# repo-padrao-abp-mvc

**Linguagem:** .NET (C#) · **UI:** mvc

Template pronto para **ABP + mvc**.

## Clone

```bash
git clone https://github.com/filipefalcaofs/repo-padrao-abp-mvc.git meu-app
cd meu-app
rm -rf .git && git init
abp new MeuApp -u mvc -d ef
```

Copiar `.mcp.json` já incluído; abrir solution no ABP Studio. Ver [`docs/stacks/ABP.md`](docs/stacks/ABP.md).

## Já incluído

- 16 rules oficiais ABP + `abp-mcp`, `abp-ui`
- UI rule: `ui-mvc`
- `.abp-stack.json` — UI **mvc**

