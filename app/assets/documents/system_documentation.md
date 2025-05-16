# RENTALOC Application Flow and Architecture

## Overview
RENTALOC is a comprehensive Rails application designed for equipment rental management. It supports the complete lifecycle of rental operations, including equipment inventory, customer management, rental contracts, maintenance tracking, and financial operations.

## Key System Components

### Authentication and Authorization
- Users authenticate through Devise
- Multi-tenancy implemented via tenant association (`acts_as_tenant`)
- Role-based authorization determines access to features

### Equipment Management
- **Equipment Inventory**: Tracks all equipment with details like code, name, status, and specifications
- **Categorization**: Equipment is organized into categories for easy search and filtering
- **Status Tracking**: Equipment status (active, inactive, maintenance, rented, etc.) is tracked
- **Documentation**: Supports attachments of photos, manuals, and other documents
- **Accessories**: Equipment can have associated accessories tracked separately
- **Maintenance**: Scheduled maintenance, alerts, and maintenance history

### Customer Management
- **Customer Records**: Complete information about customers
- **Multiple Contacts**: Support for multiple contact persons per customer
- **Multiple Addresses**: Support for multiple addresses per customer
- **Financial References**: Bank and commercial references

### Rental Process
1. **Rental Creation**:
   - Customer selection
   - Equipment selection with quantity
   - Contract terms definition
   
2. **Approval Process**:
   - Review and approval workflow
   
3. **Equipment Movements**:
   - Delivery management
   - Return processing
   - Equipment allocation tracking
   
4. **Billing**:
   - Invoice generation
   - Payment tracking
   - Financial reconciliation

5. **Completion**:
   - Rental finalization
   - Equipment status update
   - Historical record keeping

### Financial Module
- **Invoice Management**: Creation, tracking, and status updates
- **Payment Tracking**: Record of all payments received
- **Financial Reporting**: Analysis of financial performance

### Service Orders
- **Service Request**: Tracking of maintenance or repair requests
- **Service Execution**: Recording work performed on equipment
- **Status Tracking**: Start, progress, and completion tracking

### Configuration and Settings
- **User Management**: User accounts and permissions
- **Tenant Configuration**: Multi-tenancy settings
- **Equipment Categories**: Definition of equipment categories
- **Service Categories**: Definition of service types

## Data Flow

1. **User Input** → Controllers receive and validate requests
2. **Controllers** → Coordinate actions and delegate to models
3. **Models** → Apply business rules and interact with database
4. **Views** → Present data back to the user

## Key Model Relationships

- **Equipment** ↔ **RentalItems**: Equipment items included in rentals
- **Equipment** ↔ **EquipmentMaintenances**: Maintenance records for equipment
- **Rental** ↔ **RentalMovements**: Records of equipment deliveries and returns
- **Rental** ↔ **Invoices**: Financial documents generated for rentals
- **Customer** ↔ **Rentals**: Rental contracts associated with customers

## Common Operations

1. **Equipment Rental Cycle**:
   - Customer requests equipment
   - Rental agreement created
   - Equipment delivered (movement recorded)
   - Invoices generated at defined intervals
   - Equipment returned (movement recorded)
   - Rental completed

2. **Equipment Maintenance Cycle**:
   - Maintenance scheduled
   - Service order created
   - Maintenance performed and documented
   - Equipment returned to active status

3. **Financial Operations**:
   - Invoices generated for rentals
   - Payments recorded against invoices
   - Financial reports generated

## Technical Implementation Details

- **Multi-tenancy**: Implemented through `acts_as_tenant` to isolate customer data
- **Soft Deletions**: Critical records are not permanently deleted but marked as inactive
- **Audit Trail**: Changes to important records are logged
- **File Attachments**: Using Active Storage for document and image attachments
- **JSON Storage**: Complex data structures stored in JSON columns (e.g., rental_prices, additional_data)

## Fixed Issues

1. **Equipment Creation Error**:
   - Problem: NoMethodError for "undefined method 'quantity_changed?'" in Equipment model
   - Solution: Modified `update_total_quantity` method to properly handle the quantity attribute

2. **Form Submission Issues**:
   - Problem: Nested forms were preventing proper form submission
   - Solution: Restructured form partials to handle submission correctly
