# repo-padrao-abp-blazor

Template pronto para **ABP + blazor**.

## Clone

```bash
git clone https://github.com/filipefalcaofs/repo-padrao-abp-blazor.git meu-app
cd meu-app
rm -rf .git && git init
abp new MeuApp -u blazor -d ef
```

Copiar `.mcp.json` já incluído; abrir solution no ABP Studio. Ver [`docs/stacks/ABP.md`](docs/stacks/ABP.md).

## Já incluído

- 16 rules oficiais ABP + `abp-mcp`, `abp-ui`
- UI rule: `ui-blazor`
- `.abp-stack.json` — UI **blazor**

