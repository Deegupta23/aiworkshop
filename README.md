# AI Workshop - OpenEdge ABL Project

This repository contains an OpenEdge ABL project demonstrating the Business Entity pattern for data access and management.

## Project Structure

- `src/` - Source code
  - `business/` - Business entity classes and dataset definitions
  - `*.w` - Window files (UI)
- `doc/` - Documentation
- `dump/` - Database schema files
- `.windsurf/` - Windsurf AI IDE configuration
  - `rules/` - Code style and syntax rules
  - `workflows/` - Development workflows

## Business Entity Pattern

This project demonstrates the Business Entity architecture pattern, which provides:
- Separation of UI logic from database operations
- Reusable business logic components
- Centralized data validation
- Factory pattern for entity management

See `doc/business-entity-pattern.md` for detailed documentation.

## Getting Started

1. Ensure OpenEdge 12.8+ is installed
2. Review `openedge-project.json` for project configuration
3. Use the provided workflows in `.windsurf/workflows/` for common development tasks

## Key Components

- **CustomerEntity** - Business entity for customer data access
- **EntityFactory** - Singleton factory for managing entity instances
- **CustomerWin.w** - Customer management UI
- **ItemWin.w** - Item management UI
