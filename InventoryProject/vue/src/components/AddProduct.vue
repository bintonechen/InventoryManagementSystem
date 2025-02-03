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
                <el-dropdown-item @click.native="showAccountInfo">Account Information</el-dropdown-item>
                <!-- Logout option -->
                <el-dropdown-item @click.native="logout">Log Out</el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
          </div>
        </el-header>

        <el-container>
          <el-main>
            <!-- Main content display container -->
            <div class="display-container">
              <!-- Form for product registration -->
              <el-form :model="registerForm" :rules="rules" ref="registerForm" label-width="120px">
                <el-form-item label="Barcode" prop="productBarcode">
                  <el-input v-model="registerForm.productBarcode"></el-input>
                </el-form-item>
                <el-form-item label="Product Name" prop="productName">
                  <el-input v-model="registerForm.productName"></el-input>
                </el-form-item>
                <el-form-item label="Collection" prop="productCollection">
                  <el-input v-model="registerForm.productCollection"></el-input>
                </el-form-item>
                <el-form-item label="Colour" prop="productColour">
                  <el-input v-model="registerForm.productColour"></el-input>
                </el-form-item>
                <el-form-item label="Price" prop="productPrice">
                  <el-input v-model.number="registerForm.productPrice"></el-input>
                </el-form-item>
                <el-form-item label="Release Year" prop="productReleaseYear">
                  <el-input v-model.number="registerForm.productReleaseYear"></el-input>
                </el-form-item>
                <el-form-item label="Quantity" prop="quantityInStock">
                  <el-input v-model.number="registerForm.quantityInStock"></el-input>
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
  name: "AddProduct",
  data() {
    // Get the current year
    const currentYear = new Date().getFullYear();
    return {
      registerMessage: 'Add a New Product',
      username: "User", // Default placeholder
      currentUser: null,
      accountInfoVisible: false, // Default account info dialog visibility

      // Form model for product registration
      registerForm: {
        productBarcode: '',
        productName: '',
        productCollection: '',
        productColour: '',
        productPrice:'',
        productReleaseYear:'',
        quantityInStock:'',
        reservedQuantity:0
      },

      // Validation rules for form fields
      rules: {
        productBarcode: [
          { required: true, message: 'Product Barcode can not be null', trigger: 'blur' },
          { min: 4, max: 20, message: 'Product Barcode Length should be 4 to 20', trigger: 'blur' }
        ],
        productName: [
          { required: true, message: 'Product Name can not be null', trigger: 'blur' },
          { min: 4, max: 40, message: 'Product Name Length should be 4 to 40', trigger: 'blur' }
        ],
        productCollection: [
          { required: true, message: 'Product Collection can not be null', trigger: 'blur' },
          { min: 2, max: 20, message: 'Product Collection Length should be 2 to 20', trigger: 'blur' }
        ],
        productColour: [
          { required: true, message: 'Product Colour can not be null', trigger: 'blur' },
        ],
        productPrice: [
          { required: true, message: 'Product Price can not be null', trigger: 'blur' },
          { type:'number', message: 'Product price must be a number', trigger: 'blur' },
          { validator: (rule, value, callback) => {
              if (value <= 0) {
                callback(new Error('Product price must be greater than zero'));
              } else {
                callback();
              }
            }, trigger: 'blur'
          }
        ],
        productReleaseYear: [
          { required: true, message: 'Product Release Year can not be null', trigger: 'blur' },
          { type:'number', message: 'Product Release Year must be a number', trigger: 'blur' },
          { validator: (rule, value, callback) => {
              if (!Number.isInteger(value)) {
                callback(new Error('Product Release Year must be an integer'));
              } else if (value < 1900 || value > currentYear) {
                callback(new Error(`Product Release Year must be between 1900 and ${currentYear}`));
              } else {
                callback();
              }
            }, trigger: 'blur'
          }
        ],
        quantityInStock: [
          { required: true, message: 'Product quantity can not be null', trigger: 'blur' },
          { type:'number', message: 'Product quantity must be a number', trigger: 'blur' },
          { validator: (rule, value, callback) => {
              if (!Number.isInteger(value)) {
                callback(new Error('Product Quantity must be an integer'));
              } else if (value < 0) {
                callback(new Error('Product Quantity must be equal to or greater than zero'));
              } else {
                callback();
              }
            }, trigger: 'blur'
          }
        ],
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
    logout(){
      localStorage.removeItem('currentUser')
      this.$router.push('/login')
      this.$message.success("logout successfully")
    },
    // Navigate to the previous page
    goBack(){
      this.$router.go(-1);
    },
    // Show account information dialog
    showAccountInfo() {
      this.accountInfoVisible = true;
    },
    // Submit form method
    submitForm() {
      this.$refs['registerForm'].validate((valid) => {
        if (valid) {
          request.post('/product/addproduct',this.registerForm).then(res =>{
            if(res.code === '200'){
              this.$router.push('/product')
              this.$message.success("add product successfully")
            } else {
              this.$message.error('Failed to add product. ' + res.msg + 'Please try again.' )
            }
          })
        } else {
          alert('Please enter all information accordingly');
        }
      });
    },
    // Reset form fields
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
  height: 180px;
  margin: 0;
  padding-top: 0px;
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
  width: 150px;
  margin: 10px 0;
  display: flex;
  justify-content: center;
}

</style>