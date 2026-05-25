# repo-padrao-abp-react

**Linguagem:** .NET (C#) · **UI:** react

Template pronto para **ABP + react**.

## Clone

```bash
git clone https://github.com/filipefalcaofs/repo-padrao-abp-react.git meu-app
cd meu-app
rm -rf .git && git init
abp new MeuApp --template app --modern --ui-framework react
```

Copiar `.mcp.json` já incluído; abrir solution no ABP Studio. Ver [`docs/stacks/ABP.md`](docs/stacks/ABP.md).

## Já incluído

- 16 rules oficiais ABP + `abp-mcp`, `abp-ui`
- UI rule: `ui-react`
- `.abp-stack.json` — UI **react**
- Skill: `abp-react-development`
