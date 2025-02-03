<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">
  <div id="home">
    <div class="home-content-wrapper">
      <el-container>
        <!-- Header section -->
        <el-header style="height: 100px">
          <h1 class="header-title">{{homePageMessage}}</h1>
          <div class="header-dropdown">
            <el-dropdown placement="bottom" trigger="click">
              <span class="user-greeting">
                <!-- Display the userFirstName -->
                Hello, {{ username }}
                <i class="el-icon-arrow-down el-icon--right"></i>
              </span>
              <el-dropdown-menu slot="dropdown">
                <!-- Account info option -->
                <el-dropdown-item @click.native="showAccountInfo">Account Information</el-dropdown-item>
                <!-- Logout option -->
                <el-dropdown-item @click.native="logout">Log Out</el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
          </div>
        </el-header>

        <el-container>
          <!-- Aside menu -->
          <el-aside width="200px">
            <el-menu>

<!--              <el-submenu index="1">-->
<!--                <template v-slot:title>Store Reports</template>-->
<!--                <el-menu-item index="1-1">Store Productivity</el-menu-item>-->
<!--                <el-menu-item index="1-2">Associate Productivity</el-menu-item>-->
<!--              </el-submenu>-->

              <el-submenu index="2">
                <template v-slot:title>Customers</template>
                <el-menu-item index="1-1" @click="goToCustomerPage">Customer Management</el-menu-item>
                <el-menu-item index="1-2" @click="goToReservationPage">Customer Reservation</el-menu-item>
              </el-submenu>

<!--              <el-menu-item index="3">Deliveries</el-menu-item>-->

              <el-menu-item index="4" @click="goToUserPage">Users</el-menu-item>
            </el-menu>
          </el-aside>

          <!-- Main content area -->
          <el-main>
            <div class="button-container">
              <el-row>

<!--                <el-button type="primary" > &nbsp Start Transaction &nbsp </el-button>-->

                <el-button type="primary" @click="goToProductPage" style="width: 180px" > &nbsp Item Inquiry &nbsp </el-button>
                <el-button type="primary" @click="goToReservationPage" style="width: 180px" > &nbsp Create Reservation &nbsp </el-button>
              </el-row>
            </div>
          </el-main>
        </el-container>

        <!-- Dialog for displaying account information -->
        <el-dialog title="Account Information" :visible.sync="accountInfoVisible">
          <el-form label-position="top" :model="currentUser">
            <el-form-item label="First Name">
              <el-input v-model="currentUser.userFirstName" disabled></el-input>
            </el-form-item>
            <el-form-item label="Last Name">
              <el-input v-model="currentUser.userLastName" disabled></el-input>
            </el-form-item>
            <el-form-item label="Username">
              <el-input v-model="currentUser.userName" disabled></el-input>
            </el-form-item>
            <el-form-item label="Email">
              <el-input v-model="currentUser.userEmail" disabled></el-input>
            </el-form-item>
            <el-form-item label="Role">
              <el-input v-model="currentUser.userRole" disabled></el-input>
            </el-form-item>
          </el-form>
          <div slot="footer" class="dialog-footer">
            <!-- Button to close the account info dialog -->
            <el-button @click="accountInfoVisible = false">Close</el-button>
          </div>
        </el-dialog>


      </el-container>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";

export default{
  name:"Home",
  data(){
    return {
      homePageMessage: "Home Page",
      // Placeholder username
      username:"User",
      // Object to store current user data
      currentUser: null,
      // Visibility state for account info dialog
      accountInfoVisible: false,
    }
  },

  mounted(){
    // Retrieve the current user from local storage
    const currentUser = JSON.parse(localStorage.getItem("currentUser"));
    // Set the currentUser data
    this.currentUser = currentUser;

    if (currentUser && currentUser.userFirstName) {
      // Set the username to the user's first name
      this.username = currentUser.userFirstName;
    } else {
      // If no user data is found, show an error message and redirect to login
      this.$message.error("No user data found. Please log in again.");
      this.$router.push('/login');
    }
  },

  methods:{
    // Logout method
    logout(){
      localStorage.removeItem('currentUser')
      this.$router.push('/login')
      this.$message.success("logout successfully")
    },
    // Show account information dialog
    showAccountInfo() {
      this.accountInfoVisible = true;
    },
    // Navigate to the customer management page
    goToCustomerPage(){
      // Retrieve the current user from local storage
      const currentUser = JSON.parse(localStorage.getItem("currentUser"));
      // Check if current user data exists
      if (currentUser) {
        this.$router.push({
          path: '/customer',
          // query: { user: JSON.stringify(currentUser) }
        });
      } else {
        // If no user data is found
        this.$message.error("No user found. Please log in first.");
        this.$router.push('/login');
      }
    },
    // Navigate to the user management page
    goToUserPage(){
      // Retrieve the current user from local storage
      const currentUser = JSON.parse(localStorage.getItem("currentUser"));
      // Check if current user data exists
      if (currentUser) {
        this.$router.push({
          path: '/manageaccount',
        });
      } else {
        // If no user data is found
        this.$message.error("No user found. Please log in first.");
        this.$router.push('/login');
      }
    },
    // Navigate to the product page
    goToProductPage(){
      // Retrieve the current user from local storage
      const currentUser = JSON.parse(localStorage.getItem("currentUser"));
      // Check if current user data exists
      if (currentUser) {
        this.$router.push({
          path: '/product',
        });
      } else {
        // If no user data is found
        this.$message.error("No user found. Please log in first.");
        this.$router.push('/login');
      }
    },
    // Navigate to the reservation page
    goToReservationPage(){
      // Retrieve the current user from local storage
      const currentUser = JSON.parse(localStorage.getItem("currentUser"));
      // Check if current user data exists
      if (currentUser) {
        this.$router.push({
          path: '/reservation',
        });
      } else {
        // If no user data is found
        this.$message.error("No user found. Please log in first.");
        this.$router.push('/login');
      }
    }
  }
}
</script>

<style scoped>
html, body, #home {
  height: 100%;
  margin: 0;
  padding: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #f0f2f5;
}

.home-content-wrapper {
  width: 90%;
  max-width: 1200px;
  height: 80%;
  min-height: 500px;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

.el-container {
  height: 100%;
}

.el-header{
  display: flex;
  background-color: #B3C0D1;
  color: #333;
  text-align: center;
  line-height: 50px;
}

.el-aside {
  background-color: #D3DCE6;
  color: #333;
  text-align: center;
  line-height: 200px;
}

.el-main {
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  align-items: center;
  padding-bottom: 50px;
  background-color: #E9EEF3;
  color: #333;
  text-align: center;
  line-height: 160px;
}

.button-container .el-button {
  margin: 0 60px;
}

.user-dropdown {
  position: absolute;
  cursor: pointer;
}

.header-title {
  position: absolute;
  left: 50%;
  transform: translateX(-50%);
}

.header-dropdown {
  position: absolute;
  right: 11%;
}

.user-greeting {
  display: flex;
  align-items: center;
  cursor: pointer;
  margin-left: 5px;
}

</style>
