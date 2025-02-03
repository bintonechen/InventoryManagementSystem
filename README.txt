Inventory Project - README

[ Overview ]
This project is a full-stack application for inventory management, consisting of a frontend built with Vue.js and a backend using Spring Boot. 
This guide will walk you through the steps needed to run the project on your local machine.

[ Prerequisites ]
Before you begin, ensure you have the following installed on your machine:
	• Node.js and npm (for running the Vue.js frontend)
	• Java Development Kit (JDK) (for running the Spring Boot backend)
	• Maven (for managing dependencies in the Spring Boot project)

[ Running the Project ]
Navigate to 'InventoryProject' folder and open it in your IDE.
Once your IDE has loaded the project and the environment is set, open a new Terminal window.
In your Terminal, type the following commands to start the Frontend (Vue.js):
	• cd vue
	• npm run serve

You should see output similar to the following:
	- App running at:
  	- Local: http://localhost:7000/ 
  	- Network: http://10.13.224.31:7000/.  

Now to start the Backend (Spring Boot):

	• In your project directory, navigate to ‘springboot/src/main/java/com/project/springboot/’
	• Locate and run the ’SpringbootApplication’ file.

Once Both the frontend and backend are funning:

	• Open your web browser and navigate to ‘http://localhost:7000/’ or ‘http://localhost:7000/login’ to use the application.


[ Login Credentials ]
To log in as a Manager role:
	•	Username: PhoebeBuffay 
	•	Password: Password

To log in as a Sales Assistant role:
	•	Username: RachelGreen
	•	Password: Password