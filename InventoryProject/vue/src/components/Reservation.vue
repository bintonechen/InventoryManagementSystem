<template>
  <div id="reservation">
    <div class ="reservation-content-wrapper">
      <el-container>

        <!-- Header section -->
        <el-header style="height: 100px">
          <h1 class="header-title">{{reservationMessage}}</h1>
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
            <!-- Search container for reservation search criteria -->
            <div class="search-container">
              <el-row :gutter="24">
                <el-col :span="5">
                  <!-- Input for searching by associate -->
                  <el-input v-model="searchCriteria.associate" placeholder="Associate"></el-input>
                </el-col>
                <el-col :span="5">
                  <!-- Input for searching by customer name -->
                  <el-input v-model="searchCriteria.customerName" placeholder="Customer Name"></el-input>
                </el-col>
                <el-col :span="5">
                  <!-- Input for searching by customer email -->
                  <el-input v-model="searchCriteria.customerEmail" placeholder="Customer Email"></el-input>
                </el-col>
                <el-col :span="5">
                  <!-- Input for searching by product barcode -->
                  <el-input v-model="searchCriteria.productBarcode" placeholder="Product Barcode"></el-input>
                </el-col>
                <el-col :span="4">
                  <!-- Button to trigger reservation search -->
                  <el-button type="primary" @click="searchReservations">Search</el-button>
                </el-col>
              </el-row>
            </div>

            <!-- Display container for reservation data table -->
            <div class="display-container">
              <el-table
                  :data="filteredReservationData"
                  stripe
                  style="width: 100%"
                  @row-click="handleRowClick"
                  highlight-current-row>
                <!-- Columns for reservation data -->
                <el-table-column
                    fixed
                    prop="reservationID"
                    label="Reservation ID"
                    width="120">
                </el-table-column>
                <el-table-column
                    prop="userName"
                    label="Associate"
                    width="120">
                </el-table-column>
                <el-table-column
                    prop="customerFirstName"
                    label="Customer Name"
                    width="130">
                </el-table-column>
                <el-table-column
                    prop="customerEmail"
                    label="Customer Email"
                    width="210">
                </el-table-column>
                <el-table-column
                    prop="productBarcode"
                    label="Product Barcode"
                    width="130">
                </el-table-column>
                <el-table-column
                    prop="createdDate"
                    label="Created Date"
                    width="150">
                </el-table-column>
                <el-table-column
                    prop="reservationStatus"
                    label="Status">
                </el-table-column>
              </el-table>
            </div>
          </el-main>

          <!-- Aside section for action buttons -->
          <el-aside width="200px">
            <div class="button-container">
              <el-button type="danger" class="action-button" @click="goBack">Back</el-button>
              <el-button type="primary" class="action-button" @click="showAddForm" >Add</el-button>
              <el-button type="primary" class="action-button" @click="completeReservation">Complete</el-button>
              <el-button type="primary" class="action-button" @click="cancelReservation">Cancel</el-button>
            </div>
          </el-aside>
        </el-container>

        <!-- Dialog for displaying account information -->
        <el-dialog title="Account Information" :visible.sync="accountInfoVisible">
          <el-form label-position="top" :model="currentUser">
            <!-- Form fields for account information -->
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

        <!-- Confirmation Dialog for completion -->
        <el-dialog title="Confirm Completion" :visible.sync="confirmationDialogVisible">
          <span>Confirm to complete this reservation?</span>
          <span slot="footer" class="dialog-footer">
            <el-button @click="confirmationDialogVisible = false">No</el-button>
            <el-button type="primary" @click="confirmCompletion">Yes</el-button>
          </span>
        </el-dialog>

        <!-- Confirmation Dialog for Cancellation -->
        <el-dialog title="Confirm Cancelation" :visible.sync="cancelationDialogVisible">
          <span>Confirm to cancel this reservation?</span>
          <span slot="footer" class="dialog-footer">
            <el-button @click="cancelationDialogVisible = false">No</el-button>
            <el-button type="primary" @click="confirmCancelation">Yes</el-button>
          </span>
        </el-dialog>

        <!-- Dialog for creating a new reservation -->
        <el-dialog title="Add Reservation" :visible.sync="addDialogVisible">
          <el-form :model="addForm" :rules="rules" ref="addFormRef">
            <el-form-item label="Associate" prop="userName">
              <el-select v-model="addForm.userName" placeholder="Select Associate">
                <el-option
                    v-for="user in activeUsers"
                    :key="user.userName"
                    :label="user.userFirstName + ' ' + user.userLastName"
                    :value="user.userName">
                </el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="Customer Name" prop="customerFirstName">
              <el-input v-model="addForm.customerFirstName"></el-input>
            </el-form-item>
            <el-form-item label="Customer Email" prop="customerEmail">
              <el-input v-model="addForm.customerEmail"></el-input>
            </el-form-item>
            <el-form-item label="Product Barcode" prop="productBarcode">
              <el-input v-model="addForm.productBarcode" @change="checkProductAvailability"></el-input>
              <span v-if="productAvailability">There are {{ productAvailability }} available to be reserved</span>
            </el-form-item>
            <el-form-item label="Created Date" prop="createdDate">
              <el-date-picker v-model="addForm.createdDate" type="date" placeholder="Select Date" :default-value="currentDate"></el-date-picker>
            </el-form-item>
          </el-form>
          <div slot="footer" class="dialog-footer">
            <!-- Button to cancel adding a reservation -->
            <el-button @click="addDialogVisible = false">Cancel</el-button>
            <!-- Button to save the new reservation -->
            <el-button type="primary" @click="saveReservation">Save</el-button>
          </div>
        </el-dialog>

      </el-container>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";

export default{
  name:"Reservation",
  data(){
    const currentDate = new Date().toISOString().split('T')[0]; // Get current date in YYYY-MM-DD format
    return{
      reservationMessage:'Customer Reservation',
      username:"User",
      // Array to store reservation data
      reservationData:[],
      // Array to store filtered reservation data
      filteredReservationData: [],
      // Object to store current user data
      currentUser: null,
      // Visibility state for add dialog
      addDialogVisible: false,
      // Visibility state for account info dialog
      accountInfoVisible: false,
      // Visibility state for completion confirmation dialog
      confirmationDialogVisible: false,
      // Visibility state for cancellation confirmation dialog
      cancelationDialogVisible: false,
      // Search criteria model for filtering reservations
      searchCriteria: {
        associate: '',
        customerName: '',
        customerEmail: '',
        productBarcode: ''
      },
      // Object to store the selected reservation data
      selectedReservation: null,
      // Form model for adding a new reservation
      addForm: {
        userName: '',
        customerFirstName: '',
        customerEmail: '',
        productBarcode: '',
        createdDate: currentDate,
        reservationStatus:'Active'
      },
      // Array to store all user data
      allUsers: [],
      // Array to store active user data
      activeUsers: [],
      // Variable to store product availability
      productAvailability: null,
      // Validation rules for form fields
      rules: {
        userName: [{ required: true, message: 'Please select an associate', trigger: 'change' }],
        customerFirstName: [{ required: true, message: 'Customer name can not be null', trigger: 'blur' }],
        customerEmail: [{ required: true, message: 'Customer email can not be null', trigger: 'blur' }],
        productBarcode: [{ required: true, message: 'Product barcode can not be null', trigger: 'blur' }],
        createdDate: [{ required: true, message: 'Date can not be null', trigger: 'change' }]
      }
    }
  },

  mounted(){
    // this.loadReservationData();

    // Fetch all reservation data on component mount
    request.get('/reservation/selectAll').then(res =>{
      this.reservationData = res.data;
      this.filteredReservationData = res.data;
    });

    // Load all users and filter active ones
    request.get('/manageaccount/selectAll').then(res => {
      this.allUsers = res.data;
      this.activeUsers = this.allUsers.filter(user => user.userStatus === 'Active');
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

    // Check if a product barcode is provided in the route query
    const productBarcode = this.$route.query.productBarcode;
    if (productBarcode) {
      this.addForm.productBarcode = productBarcode;
      this.showAddForm();
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
    // Search reservations based on criteria
    searchReservations() {
      this.filteredReservationData = this.reservationData.filter(reservation => {
        return (!this.searchCriteria.associate || reservation.userName.includes(this.searchCriteria.associate)) &&
            (!this.searchCriteria.customerName || reservation.customerFirstName.includes(this.searchCriteria.customerName)) &&
            (!this.searchCriteria.customerEmail || reservation.customerEmail.includes(this.searchCriteria.customerEmail)) &&
            (!this.searchCriteria.productBarcode || reservation.productBarcode.includes(this.searchCriteria.productBarcode));
      });
    },
    // Handle row click event in the reservation table
    handleRowClick(row) {
      this.selectedReservation = row;
    },
    // Show the form for adding a new reservation
    showAddForm() {
      this.addDialogVisible = true;
    },
    // Complete the selected reservation
    completeReservation(){
      if (this.selectedReservation) {
        this.confirmationDialogVisible = true;
      } else {
        this.$message.warning("Please select a select a Reservation to complete");
      }
    },
    // Load reservation data from the server
    loadReservationData() {
      request.get('/reservation/selectAll').then(res => {
        this.reservationData = res.data;
        this.filteredReservationData = res.data;
      }).catch(error => {
        console.error("There was an error loading the reservation data:", error);
        this.$message.error("Failed to load reservation data. Please try again.");
      });
    },
    // Check product availability
    checkProductAvailability() {
      const barcode = this.addForm.productBarcode;
      request.get(`/product/${barcode}`).then(res => {
        const product = res.data;
        this.productAvailability = product.quantityInStock - product.reservedQuantity;
      }).catch(error => {
        console.error("There was an error checking product availability:", error);
        this.productAvailability = null;
        this.$message.error("Failed to check product availability. Please try again.");
      });
    },
    // Save the new reservation
    saveReservation() {
      this.$refs.addFormRef.validate(valid => {
        if (valid) {
          request.post('/reservation/add', this.addForm).then(res => {
            if (res.code === '200') {
              this.$message.success("Reservation added successfully");

              // Update product database
              const productBarcode = this.addForm.productBarcode;

              request.get(`/product/${productBarcode}`).then(productRes => {
                const product = productRes.data;
                product.reservedQuantity += 1;

                console.log('Updating product:', product); // Log product to debug

                request.put('/product/update', product).then(productUpdateRes => {
                  if (productUpdateRes.code === '200') {
                    this.$message.success("Product updated successfully");
                  } else {
                    this.$message.error('Failed to update product. ' + productUpdateRes.msg);
                  }

                  // Refresh the table data
                  this.loadReservationData();

                  // Reset the form and hide the dialog after product update
                  this.$refs.addFormRef.resetFields();
                  this.addDialogVisible = false;

                }).catch(error => {
                  console.error("There was an error updating the product:", error);
                  this.$message.error("Failed to update product. Please try again.");
                });
              }).catch(error => {
                console.error("There was an error fetching the product:", error);
                this.$message.error("Failed to fetch product. Please try again.");
              });
            } else {
              this.$message.error('Failed to add reservation. ' + res.msg);
            }
          }).catch(error => {
            console.error("There was an error adding the reservation:", error);
            this.$message.error("Failed to add reservation. Please try again.");
          });
        } else {
          this.$message.error("Please correct the errors in the form.");
          return false;
        }
      });
    },

    // Confirm the completion of the selected reservation
    confirmCompletion() {
      const reservation = this.selectedReservation;
      // Update reservation status to 'completed'
      reservation.reservationStatus = 'completed';

      request.put('/reservation/update', reservation).then(res => {
        if (res.code === '200') {
          this.$message.success("Reservation completed successfully");
          this.confirmationDialogVisible = false;

          // Update product database
          request.get(`/product/${reservation.productBarcode}`).then(productRes => {
            const product = productRes.data;
            product.quantityInStock -= 1;
            product.reservedQuantity -= 1;
            request.put('/product/update', product).then(productUpdateRes => {
              if (productUpdateRes.code === '200') {
                this.$message.success("Product updated successfully");
                // Refresh the table data
                this.loadReservationData();
              } else {
                this.$message.error('Failed to update product. ' + productUpdateRes.msg);
              }
            }).catch(error => {
              console.error("There was an error updating the product:", error);
              this.$message.error("Failed to update product. Please try again.");
            });
          }).catch(error => {
            console.error("There was an error fetching the product:", error);
            this.$message.error("Failed to fetch product. Please try again.");
          });

        } else {
          this.$message.error('Failed to complete reservation. ' + res.msg);
        }
      }).catch(error => {
        console.error("There was an error completing the reservation:", error);
        this.$message.error("Failed to complete reservation. Please try again.");
      });
    },

    // Cancel the selected reservation
    cancelReservation() {
      if (this.selectedReservation) {
        this.cancelationDialogVisible = true;
      } else {
        this.$message.warning("Please select a Reservation to cancel");
      }
    },

    // Confirm the cancellation of the selected reservation
    confirmCancelation() {
      const reservation = this.selectedReservation;
      // Update reservation status to 'cancelled'
      reservation.reservationStatus = 'cancelled';

      request.put('/reservation/update', reservation).then(res => {
        if (res.code === '200') {
          this.$message.success("Reservation cancelled successfully");
          this.cancelationDialogVisible = false;

          // Update product database
          request.get(`/product/${reservation.productBarcode}`).then(productRes => {
            const product = productRes.data;
            product.reservedQuantity -= 1;
            request.put('/product/update', product).then(productUpdateRes => {
              if (productUpdateRes.code === '200') {
                this.$message.success("Product updated successfully");
                // Refresh the table data
                this.loadReservationData();
              } else {
                this.$message.error('Failed to update product. ' + productUpdateRes.msg);
              }
            }).catch(error => {
              console.error("There was an error updating the product:", error);
              this.$message.error("Failed to update product. Please try again.");
            });
          }).catch(error => {
            console.error("There was an error fetching the product:", error);
            this.$message.error("Failed to fetch product. Please try again.");
          });

        } else {
          this.$message.error('Failed to cancel reservation. ' + res.msg);
        }
      }).catch(error => {
        console.error("There was an error canceling the reservation:", error);
        this.$message.error("Failed to cancel reservation. Please try again.");
      });
    },
  }
}
</script>

<style scoped>
html, body, #reservation {
  height: 100%;
  margin: 0;
  padding: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #f0f2f5;
}

.reservation-content-wrapper {
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
