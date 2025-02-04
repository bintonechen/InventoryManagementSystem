# Inventory Management System

## Overview
This project is a full-stack application for inventory management, featuring a frontend built with Vue.js and a backend powered by Spring Boot. This guide provides instructions for setting up and running the project on your local machine.

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
