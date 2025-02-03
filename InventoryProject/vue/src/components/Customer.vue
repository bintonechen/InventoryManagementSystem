<template>
  <div id="customerManagement">
    <div class ="customerManagement-content-wrapper">
      <el-container>

        <!-- Header section -->
        <el-header style="height: 100px">
          <h1 class="header-title">{{customerManagementMessage}}</h1>
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
            <!-- Search container for customer search criteria -->
            <div class="search-container">
              <el-row :gutter="24">
                <el-col :span="5">
                  <!-- Input for searching by email -->
                  <el-input v-model="searchCriteria.email" placeholder="Email"></el-input>
                </el-col>
                <el-col :span="5">
                  <!-- Input for searching by contact number -->
                  <el-input v-model="searchCriteria.contactNumber" placeholder="Contact Number"></el-input>
                </el-col>
                <el-col :span="5">
                  <!-- Input for searching by first name -->
                  <el-input v-model="searchCriteria.firstName" placeholder="First Name"></el-input>
                </el-col>
                <el-col :span="5">
                  <!-- Input for searching by last name -->
                  <el-input v-model="searchCriteria.lastName" placeholder="Last Name"></el-input>
                </el-col>
                <el-col :span="4">
                  <!-- Action button -->
                  <el-button type="primary" @click="searchCustomers">Search</el-button>
                </el-col>
              </el-row>
            </div>

            <!-- Display container for customer data table -->
            <div class="display-container">
              <el-table
                  :data="filteredCustomerData"
                  stripe
                  style="width: 100%"
                  @row-click="handleRowClick"
                  highlight-current-row>
                <el-table-column
                    fixed
                    prop="customerID"
                    label="Customer ID"
                    width="115">
                </el-table-column>
                <el-table-column
                    prop="customerFirstName"
                    label="First Name"
                    width="150">
                </el-table-column>
                <el-table-column
                    prop="customerLastName"
                    label="Last Name"
                    width="150">
                </el-table-column>
                <el-table-column
                    prop="customerEmail"
                    label="Email"
                    width="220">
                </el-table-column>
                <el-table-column
                    prop="customerContactNum"
                    label="Contact Number"
                    width="180">
                </el-table-column>
                <el-table-column
                    prop="customerBirthMonth"
                    label="Birth Month">
                </el-table-column>
              </el-table>
            </div>
          </el-main>

          <!-- Aside section for action buttons -->
          <el-aside width="200px">
            <div class="button-container">
              <el-button type="danger" class="action-button" @click="goBack">Back</el-button>
              <el-button type="primary" class="action-button" @click="addCustomer">Add</el-button>
              <el-button type="primary" class="action-button" @click ="editCustomer">Edit</el-button>
            </div>
          </el-aside>
        </el-container>

        <!-- Dialog for editing customer information -->
        <el-dialog title="Edit Customer" :visible.sync="editDialogVisible">
          <el-form :model="editForm" :rules="rules" ref="editFormRef">
            <el-form-item label="Customer ID" prop="customerID">
              <el-input v-model="editForm.customerID" disabled></el-input>
            </el-form-item>
            <el-form-item label="First Name" prop="customerFirstName">
              <el-input v-model="editForm.customerFirstName"></el-input>
            </el-form-item>
            <el-form-item label="Last Name" prop="customerLastName">
              <el-input v-model="editForm.customerLastName"></el-input>
            </el-form-item>
            <el-form-item label="Email" prop="customerEmail">
              <el-input v-model="editForm.customerEmail"></el-input>
            </el-form-item>
            <el-form-item label="Contact Number" prop="customerContactNum">
              <el-input v-model="editForm.customerContactNum"></el-input>
            </el-form-item>
            <el-form-item label="Birth Month" prop="customerBirthMonth">
              <el-select v-model="editForm.customerBirthMonth" placeholder="Select Birth Month">
                <!-- Options for birth month selection -->
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
          </el-form>
          <div slot="footer" class="dialog-footer">
            <!-- Button to cancel editing -->
            <el-button @click="editDialogVisible = false">Cancel</el-button>
            <!-- Button to save the edited customer data -->
            <el-button type="primary" @click="saveCustomer" >Save</el-button>
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
  name:"CustomerManagement",
  data(){
    return{
      customerManagementMessage:'Customer Management',
      username:"User", // Default placeholder
      // Array to store customer data
      customerData:[],
      // Array to store filtered customer data
      filteredCustomerData: [],
      // Object to store current user data
      currentUser: null,
      // Visibility state for edit dialog
      editDialogVisible: false,
      // Visibility state for account info dialog
      accountInfoVisible: false,
      // Form model for editing customer details
      editForm: {
        customerID: '',
        customerFirstName: '',
        customerLastName: '',
        customerEmail: '',
        customerContactNum: '',
        customerBirthMonth: ''
      },
      // Search criteria model for filtering customers
      searchCriteria: {
        email: '',
        contactNumber: '',
        firstName: '',
        lastName: ''
      },
      // Validation rules for form fields
      rules: {
        customerFirstName: [
          {required: true, message: 'First Name can not be null', trigger: 'blur'},
          {min: 2, max: 20, message: 'First Name Length should be 2 to 20', trigger: 'blur'}
        ],
        customerLastName: [
          {required: true, message: 'Last Name can not be null', trigger: 'blur'},
          {min: 2, max: 20, message: 'Last Name Length should be 2 to 20', trigger: 'blur'}
        ],
        customerEmail: [
          {required: true, message: 'Please input email address', trigger: 'blur'},
          {type: 'email', message: 'Please input correct email address', trigger: ['blur', 'change']}
        ],
        customerContactNum: [
          {required: true, message: 'Please input contact number', trigger: 'blur'},
          {min: 6, max: 15, message: 'Contact Number Length should be 6 to 15', trigger: 'blur'}
        ],
        customerBirthMonth: [
          {required: true, message: 'Please select birth month', trigger: 'change'}
        ]
      }
    }
  },

  mounted(){
    // Fetch all customer data on component mount
    request.get('/customer/selectAll').then(res =>{
      this.customerData = res.data;
      this.filteredCustomerData = res.data;
    });

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
    // Navigate back to the previous page
    goBack(){
      this.$router.go(-1);
    },
    // Load customer data from the server
    loadCustomerData() {
      request.get('/customer/selectAll').then(res => {
        this.customerData = res.data;
        this.filteredCustomerData = res.data;
      }).catch(error => {
        console.error("There was an error loading the customer data:", error);
        this.$message.error("Failed to load customer data. Please try again.");
      });
    },
    // Navigate to the add customer page
    addCustomer(){
      // Retrieve the current user from local storage
      const currentUser = JSON.parse(localStorage.getItem("currentUser"));
      // Check if current user data exists
      if (currentUser) {
        this.$router.push({
          path: '/customer/register',
        });
      } else {
        // If no user data is found
        this.$message.error("please log in to add a new customer");
      }
    },
    // Handle row click event in the customer table
    handleRowClick(row) {
      this.selectedCustomer = row;
    },
    // Edit the selected customer
    editCustomer() {
      if (this.selectedCustomer) {
        this.editForm = { ...this.selectedCustomer };
        this.editDialogVisible = true;
      } else {
        this.$message.warning("Please select a Customer to edit");
      }
    },
    // Save the edited customer data
    saveCustomer(){
      this.$refs.editFormRef.validate((valid) => {
        if (valid) {
          // Call API to save the user data
          request.put('/customer/update', this.editForm).then(res => {
            if (res.code === '200') {
              this.$message.success("Customer update updated successfully");
              this.editDialogVisible = false;
              // Refresh the table data
              this.loadCustomerData();
            } else {
              this.$message.error('Failed to update customer. ' + res.msg + ' Please try again.');
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
    // Filter customers based on search criteria
    searchCustomers() {
      this.filteredCustomerData = this.customerData.filter(customer => {
        return (!this.searchCriteria.email || customer.customerEmail.includes(this.searchCriteria.email)) &&
            (!this.searchCriteria.contactNumber || customer.customerContactNum.includes(this.searchCriteria.contactNumber)) &&
            (!this.searchCriteria.firstName || customer.customerFirstName.includes(this.searchCriteria.firstName)) &&
            (!this.searchCriteria.lastName || customer.customerLastName.includes(this.searchCriteria.lastName));
      });
    }


  }
}
</script>

<style scoped>
html, body, #customerManagement {
  height: 100%;
  margin: 0;
  padding: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #f0f2f5;
}

.customerManagement-content-wrapper {
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

.search-container {
  width: 100%;
  margin: 0;
  padding: 5px;
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
  width: 150px;
  margin: 10px 0;
  justify-content: center;
}

</style>
