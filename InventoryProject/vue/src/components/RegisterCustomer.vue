<template>
  <div id="register">
    <div class ="register-content-wrapper">
      <el-container>

        <!-- Header section -->
        <el-header style="height: 100px">
          <h1 class="header-title">{{registerMessage}}</h1>
          <div class="header-dropdown">
            <el-dropdown placement="bottom" trigger="click">
                <span class="user-greeting">
                  <!-- Display the userFirstName -->
                  Hello, {{ username }}
                  <i class="el-icon-arrow-down el-icon--right"></i>
                </span>
              <el-dropdown-menu slot="dropdown">
                <!-- Account info option -->
                <el-dropdown-item @click.native="showAccountInfo" >Account Information</el-dropdown-item>
                <!-- Logout option -->
                <el-dropdown-item @click.native="logout">Log Out</el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
          </div>
        </el-header>

        <el-container>
          <el-main>
            <div class="display-container">
              <!-- Form for customer registration -->
              <el-form :model="registerForm" :rules="rules" ref="registerForm" label-width="180px">
                <el-form-item label="First Name" prop="customerFirstName">
                  <el-input v-model="registerForm.customerFirstName"></el-input>
                </el-form-item>
                <el-form-item label="Last Name" prop="customerLastName">
                  <el-input v-model="registerForm.customerLastName"></el-input>
                </el-form-item>
                <el-form-item label="Contact Number" prop="customerContactNum">
                  <el-input v-model="registerForm.customerContactNum"></el-input>
                </el-form-item>
                <el-form-item label="Email" prop="customerEmail">
                  <el-input v-model="registerForm.customerEmail"></el-input>
                </el-form-item>
                <el-form-item label="Birth Month" prop="customerBirthMonth">
                  <!-- Options for birth month selection -->
                  <el-select  v-model="registerForm.customerBirthMonth" placeholder="January">
                    <el-option label="January" value="January"></el-option>
                    <el-option label="February" value="February"></el-option>
                    <el-option label="March" value="March"></el-option>
                    <el-option label="April" value="April"></el-option>
                    <el-option label="May" value="May"></el-option>
                    <el-option label="June" value="June"></el-option>
                    <el-option label="July" value="July"></el-option>
                    <el-option label="August" value="August"></el-option>
                    <el-option label="September" value="September"></el-option>
                    <el-option label="October" value="October"></el-option>
                    <el-option label="November" value="November"></el-option>
                    <el-option label="December" value="December"></el-option>
                  </el-select>
                </el-form-item>
                <!-- Form action buttons -->
                <el-form-item>
                  <el-button type="primary" @click="submitForm('registerForm')">Create</el-button>
                  <el-button @click="resetForm('registerForm')">Reset</el-button>
                </el-form-item>
              </el-form>
            </div>
          </el-main>

          <!-- Aside section for action buttons -->
          <el-aside width="200px">
            <div class="button-container">
              <el-button type="danger" class="action-button" @click="goBack">Back</el-button>
            </div>
          </el-aside>
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

export default {
  name: "register",
  data() {
    return {
      registerMessage: 'Register a New Customer',
      // Placeholder username
      username: "User",
      // Object to store current user data
      currentUser: null,
      // Visibility state for account info dialog
      accountInfoVisible: false,
      // Form model for customer registration
      registerForm: {
        customerFirstName: '',
        customerLastName: '',
        customerEmail: '',
        customerContactNum: '',
        customerBirthMonth:''
      },
      // Validation rules for form fields
      rules: {
        customerFirstName: [
          { required: true, message: 'First Name can not be null', trigger: 'blur' },
          { min: 2, max: 20, message: 'First Name Length should be 2 to 20', trigger: 'blur' }
        ],
        customerLastName: [
          { required: true, message: 'Last Name can not be null', trigger: 'blur' },
          { min: 2, max: 20, message: 'Last Name Length should be 2 to 20', trigger: 'blur' }
        ],
        customerEmail:[
          { required: true, message: 'Please input email address', trigger: 'blur' },
          { type: 'email', message: 'Please input correct email address', trigger: ['blur', 'change'] }
        ],
        customerContactNum: [
          { required: true, message: 'Contact Number can not be null', trigger: 'blur' }
        ],
        customerBirthMonth: [
          { required: true, message: 'Please select customer birth month', trigger: 'change' }
        ]
      }

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
    // Submit the registration form
    submitForm() {
      this.$refs['registerForm'].validate((valid) => {
        if (valid) {
          // Make the registration API request
          request.post('/customer/register',this.registerForm).then(res =>{
            if(res.code === '200'){
              this.$router.push('/customer')
              this.$message.success("register successfully")
            } else {
              this.$message.error('Failed to register. ' + res.msg + 'Please try again.' )
            }
          })
        } else {
          alert('Please enter all information accordingly');
        }
      });
    },
    // Reset the registration form fields
    resetForm(formName) {
      this.$refs[formName].resetFields();
    }

  }

}
</script>

<style scoped>
html, body, #register {
  height: 100%;
  margin: 0;
  padding: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #f0f2f5;
}

.register-content-wrapper {
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
  width: 90%;
  margin: 0;
  padding-top: 20px;
  padding-left: 80px;
  padding-right: 50px;
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