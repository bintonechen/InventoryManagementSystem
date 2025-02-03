<template>
  <div id="login">
    <el-container>
      <el-main>
        <div class="login-form-container">
          <!-- Welcome message -->
          <h1>{{loginPageMessage}}</h1>

          <!-- Form for login -->
          <el-form :model="user" class="login-form" :rules="rules" ref="loginRef">
            <!-- Username input field -->
            <el-form-item label="Username" prop="userName">
              <el-input prefix-icon="el-icon-user" v-model="user.userName"></el-input>
            </el-form-item>
            <!-- Password input field -->
            <el-form-item label="Password" prop="userPassword">
              <el-input type="password" prefix-icon="el-icon-lock" v-model="user.userPassword"></el-input>
            </el-form-item>
            <!-- Login button -->
            <el-form-item>
              <el-button type="primary" @click="login">Log In</el-button>
            </el-form-item>
          </el-form>
        </div>
      </el-main>
    </el-container>
  </div>
</template>


<script>
import request from "@/utils/request";
export default{
  name:"Login",
  data(){
    return {
      loginPageMessage: "Welcome!",
      // Model for the login form inputs
      user: {
        userName: '',
        userPassword: ''
      },
      // Validation rules for the login form
      rules:{
        userName:[
            { required:true, message:'Please enter username', trigger:'blur'}, // Validation rule for username
        ],
        userPassword: [
          { required:true, message:'Please enter password', trigger:'blur'}, // Validation rule for password
        ],
      }
    }
  },
  methods: {
    // Method to handle login action
    login() {
      // Validate the form before making the API request
      this.$refs.loginRef.validate((valid) => {
        if (valid) {
          // Make the login API request
          request.post('/login/login', this.user).then(res => {
            if(res.code =='200'){ // response code 200 indicates a successful login
              this.$router.push('/') // Redirect to the home page
              this.$message.success("login successfully")
              localStorage.setItem("currentUser",JSON.stringify(res.data)) // Save the current user data in local storage
            } else {
              this.$message.error(res.msg) // Show an error message if login fails
            }
          })
        }
      })
    }
  }
}
</script>

<style scoped>
html, body, #login {
  height: 100%;
  margin: 0;
  padding: 0;
}

.el-container {
  height: 100%;
}

.el-main {
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #E9EEF3;
}

.login-form-container {
  width: 300px; /* Adjust width as needed */
  padding: 20px;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
}

.login-form {
  display: flex;
  flex-direction: column;
}

.el-form-item {
  margin-bottom: 20px;
}
</style>
