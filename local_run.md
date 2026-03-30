# Local Run Instructions (educatex)

Este arquivo descreve o fluxo mínimo para rodar localmente o Overleaf Community Edition neste diretório.

## 1. Pré-requisitos

- Docker instalado
- Docker Compose (plugin `docker compose` ou binário `docker-compose`)
- Make (opcional, para build local do container)

## 2. Scripts disponíveis

- `scripts/start-local.sh`: compila (opcional) e sobe os containers em background
- `scripts/stop-local.sh`: derruba containers

## 3. Uso

```bash
cd /home/gilzamir/educadev/educatex
./scripts/start-local.sh
```

Aguarde o script terminar e abra o navegador em:

- http://localhost

## 4. Verificar status

```bash
docker compose ps
docker compose logs -f sharelatex
```

## 5. Parar ambiente

```bash
cd /home/gilzamir/educadev/educatex
./scripts/stop-local.sh
```

## 6. Notas

- O script cria os volumes em `~/sharelatex_data`, `~/mongo_data`, `~/redis_data`.
- Caso não queira build local, o docker compose usa imagem `sharelatex/sharelatex` pronta.
