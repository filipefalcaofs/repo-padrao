---
name: go-testing
description: "Aplicar em testes Go: table-driven tests, testify, httptest, mocks e testcontainers quando o projeto usa. Usar em *_test.go."
license: MIT
metadata:
  author: repo-padrao
---

# Go Testing

## Table-driven

```go
tests := []struct {
    name string
    in   Input
    want Output
    err  bool
}{
    {name: "ok", in: Input{...}, want: Output{...}},
}
for _, tt := range tests {
    t.Run(tt.name, func(t *testing.T) {
        got, err := fn(tt.in)
        if (err != nil) != tt.err { t.Fatal(err) }
        // assert got == tt.want
    })
}
```

## HTTP

```go
req := httptest.NewRequest(http.MethodGet, "/health", nil)
rec := httptest.NewRecorder()
handler.ServeHTTP(rec, req)
```

## TDD

Um teste falhando por vez; `go test ./...` antes de claim.
