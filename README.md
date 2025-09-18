# Ahwa Manager App ☕

Smart Ahwa Manager is a **Flutter app** designed to help Cairo café (ahwa) owners manage daily operations efficiently.  
It uses a local SQLite database via `sqflite` to keep everything offline and simple.

---

## ✨ Features

- Add new orders with **customer name**, **drink type**, and **special notes**.
- Track **pending orders** and mark them as completed.
- Preloaded drinks list on first run (e.g., Shai, Turkish Coffee, Hibiscus).
- Automatically calculate **total price** for each order.
- Generate quick daily insights:  
  - Total number of orders  
  - Total revenue  
  - Top-selling drinks  

---

## 📂 Project Structure

- `lib/core` → Shared logic: models, repositories, database services/helpers.  
- `lib/ahwa` → UI screens and widgets (Dashboard, Add Order, Reports, etc.).  
- Uses **Repository Pattern** to separate data access from business logic.  

---
## 📂 System Design

```
├─ lib
│  ├─ ahwa
│  │  ├─ dashboard
│  │  │  ├─ dashboard_tab_screen.dart
│  │  │  └─ widget
│  │  │     └─ icon_with_text_in_row.dart
│  │  ├─ layout
│  │  │  ├─ layout.dart
│  │  │  └─ widget
│  │  │     ├─ buttons_tab_bar_widget.dart
│  │  │     ├─ floating_button.dart
│  │  │     ├─ order_drinks_dropdown_menu.dart
│  │  │     └─ order_text_form_field.dart
│  │  ├─ new_order
│  │  │  └─ add_new_order.dart
│  │  └─ reports
│  │     ├─ reports_tab_screen.dart
│  │     └─ widgets
│  │        ├─ no_top_selling_item_enter_new_orders.dart
│  │        ├─ today_summary_report_widget.dart
│  │        ├─ top_selling_item.dart
│  │        └─ total_item_count_container_widget.dart
│  ├─ core
│  │  ├─ common
│  │  │  └─ widget
│  │  │     ├─ circualr_containers
│  │  │     │  ├─ circular_container.dart
│  │  │     │  └─ circular_container_shadow.dart
│  │  │     ├─ divider
│  │  │     │  └─ horizontal_divider.dart
│  │  │     └─ heading
│  │  │        └─ section_heading.dart
│  │  ├─ constants
│  │  │  ├─ app_strings.dart
│  │  │  └─ data
│  │  │     ├─ database
│  │  │     │  ├─ database_operations_service
│  │  │     │  │  ├─ database_operations_service.dart
│  │  │     │  │  ├─ drinks_operations_service_impl.dart
│  │  │     │  │  ├─ orders_operations_service_impl.dart
│  │  │     │  │  └─ order_items_operations_service_impl.dart
│  │  │     │  ├─ initialize_data_methods
│  │  │     │  │  ├─ initialize_database_helper_service.dart
│  │  │     │  │  └─ local_database_helper.dart
│  │  │     │  ├─ order_management_service
│  │  │     │  │  ├─ order_management_service.dart
│  │  │     │  │  └─ order_management_service_impl.dart
│  │  │     │  └─ reports_service
│  │  │     │     ├─ reports_service.dart
│  │  │     │     └─ reports_service_impl.dart
│  │  │     ├─ models
│  │  │     │  ├─ drinks_model.dart
│  │  │     │  ├─ orders_model.dart
│  │  │     │  └─ order_items.dart
│  │  │     └─ repository
│  │  │        ├─ drinks_repository.dart
│  │  │        ├─ order_items_repository.dart
│  │  │        └─ order_repository.dart
│  │  └─ span_text.dart
│  └─ main.dart
```

## 🛠️ Tech Stack

- **Flutter** (UI)  
- **sqflite** (local database)  
- **OOP + SOLID principles** (Repository, abstraction, single responsibility, etc.)  

---

## 🚀 Getting Started

1. Make sure you have Flutter installed.  
2. Clone the repository:
   ```bash
   git clone https://github.com/KarimSlama/ahwa.git
   ```
![photo_5935964022677555086_y](https://github.com/user-attachments/assets/e23f2c7b-80e9-4da6-8c37-c77a14367154)
![photo_5935964022677555087_y](https://github.com/user-attachments/assets/eb59792d-cb1d-4ee9-936f-b6d339e7bc72)
![photo_5935964022677555085_y](https://github.com/user-attachments/assets/bb8c0e9a-0cd5-449a-b3de-62620fba09a9)

   
