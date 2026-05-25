---
name: go-api-development
description: "Aplicar em APIs Go: handlers HTTP, services, repositories, context, middleware, Chi/Gin/Echo e layout internal/. Usar ao escrever ou revisar código Go de backend."
license: MIT
metadata:
  author: repo-padrao
---

# Go API Development

## Convenções

- Interfaces pequenas no consumidor (`service` define interface do `repository`).
- Injeção via construtor — não globals.
- Config via env (`os.Getenv` ou viper) — struct `Config` validada no startup.

## Handler exemplo

```go
func (h *Handler) Create(w http.ResponseWriter, r *http.Request) {
    var in CreateInput
    if err := json.NewDecoder(r.Body).Decode(&in); err != nil {
        writeError(w, http.StatusBadRequest, err)
        return
    }
    out, err := h.svc.Create(r.Context(), in)
    // ...
}
```

## Referências

- [Effective Go](https://go.dev/doc/effective_go)
- [Go project layout](https://github.com/golang-standards/project-layout)
