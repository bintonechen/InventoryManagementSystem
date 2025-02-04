# Inventory Management System

## Overview
This project is a full-stack application for inventory management, featuring a frontend built with Vue.js and a backend powered by Spring Boot. This guide provides instructions for setting up and running the project on your local machine.

## Background
As a part-time sales assistant at a luxury handbag counter, I have noticed some inconveniences in my work due to the lack of certain features in the inventory management application we use. For instance, we are currently handling customer reservations manually. The primary focus of this application is to provide a standardized method to handle customer reservations. Customer reservations would not only be processed in a standardized manner but also be accurately reflected in the inventory overview.

## Technology Stack
The application is developed using the following technologies:  
- **Frontend:** HTML, CSS, JavaScript, Vue.js  
- **Backend:** Java, Spring Boot  
- **Database:** MySQL
  


## Key Features
- **User Authentication and Authorization**  
  - Secure login system for users to access application functionalities.  
  - Role-based access control: Sales assistants and managers have different permissions.  
  - Only managers can add and edit user accounts.  

- **Customer Management**  
  - Add new customers to the system.  
  - Edit existing customer details.  
  - Search for customers efficiently using filters.  

- **Customer Reservation Service**  
  - Create, complete, and cancel customer reservations.  
  - Reservation status updates are reflected on the product page in real time.  

- **Inventory Management**  
  - Search for items using attributes like barcodes.  
  - Add new products to update the inventory.  
  - Create reservations for selected products.  

- **Account Management**  
  - Managers can add, edit, and delete user accounts.
 
## User Interface Preview
Below are some screenshots of the application's UI:

### Login Page  
<img width="373" alt="image" src="https://github.com/user-attachments/assets/6546e5eb-383e-4e15-94c5-a9f9d206c909" />
### Home Page
<img width="375" alt="image" src="https://github.com/user-attachments/assets/588ac10a-f8f3-446a-888e-9e70cb834d15" />





## Prerequisites
Before running the project, ensure you have the following installed:
- **Node.js** and **npm** (for running the Vue.js frontend)
- **Java Development Kit (JDK)** (for running the Spring Boot backend)
- **Maven** (for managing dependencies in the Spring Boot project)

## Running the Project
### 1. Start the Frontend (Vue.js)
1. Navigate to the project root directory: `InventoryProject/`
2. Open a terminal and run the following commands:
   ```sh
   cd vue
   npm install   # Install dependencies
   npm run serve # Start the frontend
   ```
3. You should see output similar to the following:
   ```
   App running at:
   - Local:   http://localhost:7000/
   - Network: http://10.13.224.31:7000/
   ```

### 2. Start the Backend (Spring Boot)
1. In your project directory, navigate to:
   ```sh
   cd springboot
   ```
2. Locate and run the `SpringbootApplication` file from:
   ```sh
   src/main/java/com/project/springboot/SpringbootApplication.java
   ```
3. Ensure the backend is running properly.

### 3. Access the Application
Once both the frontend and backend are running, open your web browser and go to:
- [http://localhost:7000/](http://localhost:7000/) (Home page)
- [http://localhost:7000/login](http://localhost:7000/login) (Login page)

## Login Credentials
Use the following credentials to log in:

### Manager Role
- **Username:** `PhoebeBuffay`
- **Password:** `Password`

### Sales Assistant Role
- **Username:** `RachelGreen`
- **Password:** `Password`

## Contact
For any issues or inquiries, feel free to reach out to the project maintainers.
