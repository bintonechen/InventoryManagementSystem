<template>
  <div id="manageAccount">
    <div class ="manageAccount-content-wrapper">
      <el-container>

        <!-- Header section -->
        <el-header style="height: 100px">
          <h1 class="header-title">{{manageAccountMessage}}</h1>
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
          <el-main>
            <div class="display-container">
              <el-table
                  :data="userData"
                  stripe
                  style="width: 100%"
                  @row-click="handleRowClick"
                  highlight-current-row>
                <!-- Columns for user data -->
<!--                <el-table-column-->
<!--                    prop="userID"-->
<!--                    label="User ID"-->
<!--                    width="70">-->
<!--                </el-table-column>-->
                <el-table-column
                    prop="userName"
                    label="Username"
                    width="115">
                </el-table-column>
                <el-table-column
                    prop="userFirstName"
                    label="First Name"
                    width="150">
                </el-table-column>
                <el-table-column
                    prop="userLastName"
                    label="Last Name"
                    width="150">
                </el-table-column>
                <el-table-column
                    prop="userRole"
                    label="Role"
                    width="120">
                </el-table-column>
                <el-table-column
                    prop="userEmail"
                    label="Email"
                    width="220">
                </el-table-column>
                <el-table-column
                    prop="userStatus"
                    label="Start Status">
                </el-table-column>
              </el-table>
            </div>
          </el-main>

          <!-- Aside section for action buttons -->
          <el-aside width="200px">
            <div class="button-container">
              <el-button type="danger" class="action-button" @click="goBack">Back</el-button>
              <el-button type="primary" class="action-button" @click="addUser">Add</el-button>
              <el-button type="primary" class="action-button" @click ="editUser">Edit</el-button>

              <!-- v-if method -->
<!--              <el-button type="primary" class="action-button" @click="addUser" v-if="currentUser.userRole ==='Manager'">Add</el-button>-->
<!--              <el-button type="primary" class="action-button" v-if="currentUser.userRole ==='Manager'">Edit</el-button>-->
<!--              <el-button type="primary" class="action-button" v-if="currentUser.userRole ==='Manager'">Delete</el-button>-->

            </div>
          </el-aside>
        </el-container>

        <!-- Dialog for editing user information -->
        <el-dialog title="Edit User" :visible.sync="editDialogVisible">
          <el-form :model="editForm" :rules="rules" ref="editFormRef">
            <el-form-item label="Username" prop="userName">
              <el-input v-model="editForm.userName" disabled></el-input>
            </el-form-item>
            <el-form-item label="First Name" prop="userFirstName">
              <el-input v-model="editForm.userFirstName"></el-input>
            </el-form-item>
            <el-form-item label="Last Name" prop="userLastName">
              <el-input v-model="editForm.userLastName"></el-input>
            </el-form-item>
            <el-form-item label="Role" prop="userRole">
              <el-select v-model="editForm.userRole" placeholder="Select Role">
                <el-option label="Manager" value="Manager"></el-option>
                <el-option label="Sales Assistant" value="SalesAssistant"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="Email" prop="userEmail">
              <el-input v-model="editForm.userEmail"></el-input>
            </el-form-item>
            <el-form-item label="Status" prop="userStatus">
              <el-select v-model="editForm.userStatus" placeholder="Select Status">
                <el-option label="Active" value="Active"></el-option>
                <el-option label="Inactive" value="Inactive"></el-option>
              </el-select>
            </el-form-item>
          </el-form>
          <div slot="footer" class="dialog-footer">
            <!-- Button to cancel editing -->
            <el-button @click="editDialogVisible = false">Cancel</el-button>
            <!-- Button to save the edited user data -->
            <el-button type="primary" @click="saveUser">Save</el-button>
          </div>
        </el-dialog>

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
            <el-button @click="accountInfoVisible = false">Close</el-button>
          </div>
        </el-dialog>
      </el-container>
    </div>
  </div>
</template>

<script>
// import axios from "axios";
import request from "@/utils/request";

export default{
  name:"ManageAccount",
  data(){
    return{
      manageAccountMessage:'Account Management',
      username:"User", // Default placeholder
      userData:[],
      currentUser: null,
      selectedUser: null,
      // Visibility state for edit dialog
      editDialogVisible: false,
      // Visibility state for account info dialog
      accountInfoVisible: false,
      // Form model for editing user details
      editForm: {
        userName: '',
        userFirstName: '',
        userLastName: '',
        userRole: '',
        userEmail: '',
        userStatus: ''
      },
      // Validation rules for form fields
      rules: {
        userFirstName: [
          {required: true, message: 'First Name can not be null', trigger: 'blur'},
          {min: 2, max: 20, message: 'First Name Length should be 2 to 20', trigger: 'blur'}
        ],
        userLastName: [
          {required: true, message: 'Last Name can not be null', trigger: 'blur'},
          {min: 2, max: 20, message: 'Last Name Length should be 2 to 20', trigger: 'blur'}
        ],
        userEmail:[
          { required: true, message: 'Please input email address', trigger: 'blur' },
          { type: 'email', message: 'Please input correct email address', trigger: ['blur', 'change'] }
        ],
        userRole: [
          { required: true, message: 'Please select user role', trigger: 'change' }
        ]
      }
    }
  },

  mounted(){

    // below is the previous method to get data without request.js in the utils folder
    // axios.get('http://localhost:9090/manageaccount/selectAll').then(res =>{
    //   console.log(res.data) // log the return data
    //   this.userData = res.data.data
    // })

    // Fetch all user data on component mount
    request.get('/manageaccount/selectAll').then(res => {
      this.userData = res.data
    });

    // Retrieve the current user from local storage
    const currentUser = JSON.parse(localStorage.getItem("currentUser"));
    // Set the currentUser data
    this.currentUser = currentUser;

    if (currentUser && currentUser.userFirstName) {
      // Set the username to the user's first name
      this.username = currentUser.userFirstName;
    } else {
      // If no user data is found, show an error message and redirect to login page
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
    // Navigate back to the previous page
    goBack(){
      this.$router.go(-1); // Navigate to the previous page
    },
    // Show account information dialog
    showAccountInfo() {
      this.accountInfoVisible = true;
    },
    // Navigate to the add user page
    addUser(){
      // Retrieve the current user from local storage
      const currentUser = JSON.parse(localStorage.getItem("currentUser"));
      // Check if current user data exists
      if (currentUser && currentUser.userRole==='Manager') {
        this.$router.push({
          path: '/manageaccount/register',
        });
      } else {
        // If no user data is found or the user is not a Manager
        this.$message.error("Only managers have the access to register a new user.");
      }
    },
    // Handle row click event in the user table
    handleRowClick(row) {
      this.selectedUser = row;
    },
    // Edit the selected user
    editUser() {
      if (this.currentUser && this.currentUser.userRole === 'Manager') {
        if (this.selectedUser) {
          this.editForm = {...this.selectedUser};
          this.editDialogVisible = true;
        } else {
          this.$message.warning("Please select a user to edit");
        }
      } else {
        this.$message.error("Only Managers can edit user details");
      }
    },
    // Save the edited user data
    saveUser() {
      this.$refs.editFormRef.validate((valid) => {
        if (valid) {
          // Call API to save the user data
          request.put('/manageaccount/update', this.editForm).then(res => {
            if (res.code === '200') {
              this.$message.success("User updated successfully");
              this.editDialogVisible = false;
              // Refresh the table data
              this.loadUserData();
            } else {
              this.$message.error('Failed to update user. ' + res.msg + ' Please try again.');
            }
          }).catch(error => {
            console.error("There was an error updating the user:", error);
            this.$message.error("Failed to update user. Please try again.");
          });
        } else {
          this.$message.error("Please correct the errors in the form.");
          return false;
        }
      });
    },
    // Load user data from the server
    loadUserData() {
      request.get('/manageaccount/selectAll').then(res => {
        this.userData = res.data;
      }).catch(error => {
        console.error("There was an error loading the user data:", error);
        this.$message.error("Failed to load user data. Please try again.");
      });
    },
  }
}

</script>

<style scoped>
html, body, #manageAccount {
  height: 100%;
  margin: 0;
  padding: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #f0f2f5;
}

.manageAccount-content-wrapper {
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
  justify-content: flex-start;
  padding-bottom: 20px;
  background-color: #E9EEF3;
  color: #333;
}

.display-container {
  width: 100%;
  height: 150px;
  margin: 0;
  padding-left: 5px;
  padding-right: 5px;
}

.button-container {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.action-button {
  width: 150px;
  margin: 10px 0;
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

.button-container .el-button {
  width: 150px; /* Ensure all buttons have the same width */
  margin: 10px 0; /* Ensure consistent vertical spacing */
  display: flex;
  justify-content: center; /* Center-align text inside buttons */
}

</style>
