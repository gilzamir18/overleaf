# Development Workflow (educatex)

Este documento descreve o fluxo de desenvolvimento a partir do ambiente local configurado com `scripts/start-local.sh` e `scripts/stop-local.sh`.

## 1. Preparar ambiente (1x ou ao reiniciar a máquina)

1. `cd /home/gilzamir/educadev/educatex`
2. `./scripts/start-local.sh`
3. `docker compose ps` para confirmar serviços up.
4. Abra `http://localhost` no navegador.

> Se o serviço não subir, veja logs:
> - `docker compose logs -f sharelatex`
> - `docker compose logs -f mongo`
> - `docker compose logs -f redis`

## 2. Fazer alteração de código

1. Edite arquivos no workspace:
   - Backend: `server-ce/`, `services/*`, `libraries/*`
   - Frontend: `services/web` (etc.)
2. Se for dependência Node: `npm install` no root ou pacote adequado conforme `workspaces`.
3. Se for TypeScript: `npm run lint` / `npm run format`.

## 3. Compilação / rebuild local

### Opção 1: rebuild full Docker image (mais lento, mais confiável)

- `cd /home/gilzamir/educadev/educatex/server-ce`
- `make build-base build-community`
- Voltar e `docker compose restart sharelatex`
- ou `docker compose up -d --build`

### Opção 2: rebuild apenas o container

- `cd /home/gilzamir/educadev/educatex`
- `docker compose up -d --build sharelatex`

## 4. Verificar mudança em execução

1. Abra `http://localhost`
2. Faça login (usuário de teste / registro padrão)
3. Crie ou abra projeto e rode compilação LaTeX
4. Observe logs:
   - `docker compose logs -f sharelatex`
   - `docker compose logs -f <serviço relacionado>`
5. Teste feature manualmente no UI e/ou CLI de API.

## 5. Testes automáticos

1. Verificar testes no pacote modificado.
2. Rodar:
   - `npm test`
   - `npm run lint`
   - Testes Cypress/Mocha conforme local do serviço.
3. Atualizar/escrever novos testes de integração se necessário.

## 6. Commit + branch + push

1. `git checkout -b feature/<descrição>`
2. `git add ...` / `git commit -m "feature: ..."`
3. `git push -u origin feature/<descrição>`
4. Abrir PR no GitHub.

## 7. Parada local (quando terminar)

- `cd /home/gilzamir/educadev/educatex`
- `./scripts/stop-local.sh`

## Dica extra

- Se a mudança for só JS/TS e não exige rebuild completo, use volume mount para reload.
- Para problemas estranhos:
  - `docker compose down --volumes --remove-orphans`
  - `docker compose up -d --build`
