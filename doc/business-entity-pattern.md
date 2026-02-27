# ABL Business Entity Architecture Pattern

## Overview

The Business Entity pattern provides a standardized, maintainable approach to data access in OpenEdge ABL applications. It separates UI logic from database operations through a layered architecture that promotes reusability, testability, and consistency across the application.

## Architecture Layers

### 1. UI Layer (Windows/Forms)
- **Responsibility**: User interaction and presentation
- **Access**: Never directly accesses database tables
- **Communication**: Calls Business Entity methods with datasets

### 2. Business Entity Layer
- **Responsibility**: Data access, business rules, validation
- **Inheritance**: Extends `OpenEdge.BusinessLogic.BusinessEntity`
- **Management**: Instantiated through EntityFactory (singleton pattern)

### 3. Database Layer
- **Responsibility**: Persistent storage
- **Access**: Only through data-sources attached to business entities

## Key Components

### EntityFactory (Singleton Pattern)

Centralized management of business entity lifecycle with lazy initialization.

### Dataset Definition (.i Include Files)

Defines temp-tables and datasets for data transfer with BEFORE-TABLE for change tracking.

### Business Entity Class

Encapsulates all data operations for a specific entity, inheriting from BusinessEntity.

## Standard CRUD Operations

- **Read**: Use OUTPUT DATASET (not BY-REFERENCE) with ReadData()
- **Create**: Populate temp-table, call CreateData()
- **Update**: Enable TRACKING-CHANGES, modify data, validate, call UpdateData()
- **Delete**: Mark record for deletion, call DeleteData()

## Validation Pattern

Implement validation methods that check business rules before Create/Update operations.

## Benefits

- **Maintainability**: Centralized data access logic
- **Reusability**: Business entities shared across multiple UI components
- **Testability**: Business logic isolated from UI
- **Consistency**: All data access follows same pattern
- **Scalability**: Easy to add new entities

## References

- OpenEdge Documentation: Business Entity Class
- ABL Reference: Dataset and Temp-Table Definitions
- Project Examples:
  - `src/business/CustomerEntity.cls`
  - `src/business/EntityFactory.cls`
  - `src/CustomerWin.w`
