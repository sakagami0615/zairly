#!/bin/bash

# Docker開発環境管理スクリプト

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
COMPOSE_FILE="$ROOT_DIR/infra/docker/compose.dev.yml"

cd "$ROOT_DIR"

case "${1:-}" in
  up)
    echo "Starting Docker development environment..."
    docker compose -f "$COMPOSE_FILE" up -d
    echo ""
    echo "Services started!"
    echo "  - Frontend: http://localhost:3000"
    echo "  - Backend API: http://localhost:8000"
    echo "  - API Docs: http://localhost:8000/docs"
    echo ""
    echo "To view logs: docker compose -f $COMPOSE_FILE logs -f"
    ;;
  
  down)
    echo "Stopping Docker development environment..."
    docker compose -f "$COMPOSE_FILE" down
    echo "Services stopped!"
    ;;
  
  restart)
    echo "Restarting Docker development environment..."
    docker compose -f "$COMPOSE_FILE" restart
    echo "Services restarted!"
    ;;
  
  build)
    echo "Building Docker images..."
    docker compose -f "$COMPOSE_FILE" build
    echo "Build complete!"
    ;;
  
  rebuild)
    echo "Rebuilding and restarting services..."
    docker compose -f "$COMPOSE_FILE" up -d --build
    echo "Rebuild complete!"
    ;;
  
  logs)
    docker compose -f "$COMPOSE_FILE" logs -f "${2:-}"
    ;;
  
  exec-api)
    docker compose -f "$COMPOSE_FILE" exec api bash
    ;;
  
  exec-web)
    docker compose -f "$COMPOSE_FILE" exec web sh
    ;;
  
  clean)
    echo "Cleaning up Docker resources..."
    docker compose -f "$COMPOSE_FILE" down -v
    echo "Cleanup complete!"
    ;;

  lint)
    echo "Running linters in Docker..."
    echo ""
    echo "Linting API..."
    docker compose -f "$COMPOSE_FILE" exec api poetry run ruff check .
    docker compose -f "$COMPOSE_FILE" exec api poetry run ruff format --check .
    echo "✓ API linting complete"
    echo ""
    echo "Linting Web..."
    docker compose -f "$COMPOSE_FILE" exec web npm run lint
    echo "✓ Web linting complete"
    echo ""
    echo "All linting complete!"
    ;;

  *)
    echo "Usage: $0 {up|down|restart|build|rebuild|logs|exec-api|exec-web|clean|lint}"
    echo ""
    echo "Commands:"
    echo "  up          - Start all services"
    echo "  down        - Stop all services"
    echo "  restart     - Restart all services"
    echo "  build       - Build Docker images"
    echo "  rebuild     - Rebuild and restart services"
    echo "  logs        - View logs (optionally specify service: api or web)"
    echo "  exec-api    - Enter API container"
    echo "  exec-web    - Enter Web container"
    echo "  clean       - Stop services and remove volumes"
    echo "  lint        - Run linters in Docker containers"
    exit 1
    ;;
esac
