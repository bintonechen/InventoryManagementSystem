<template>
  <div id="itemInquiry">
    <div class ="ItemInquiry-content-wrapper">
      <el-container>

        <!-- Header section -->
        <el-header style="height: 100px">
          <h1 class="header-title">{{itemInquiryPageMessage}}</h1>
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
            <!-- Search container for product search criteria -->
            <div class="search-container">
              <el-row :gutter="24">
                <el-col :span="5">
                  <!-- Input for searching by barcode -->
                  <el-input v-model="searchCriteria.barcode" placeholder="Barcode"></el-input>
                </el-col>
                <el-col :span="5">
                  <!-- Input for searching by product name -->
                  <el-input v-model="searchCriteria.productName" placeholder="Product Name"></el-input>
                </el-col>
                <el-col :span="5">
                  <!-- Input for searching by product collection -->
                  <el-input v-model="searchCriteria.productCollection" placeholder="Collection"></el-input>
                </el-col>
                <el-col :span="5">
                  <!-- Input for searching by release year -->
                  <el-input v-model="searchCriteria.releaseYear" placeholder="Release Year"></el-input>
                </el-col>
                <el-col :span="4">
                  <!-- Button to trigger product search -->
                  <el-button type="primary" @click="searchProducts">Search</el-button>
                </el-col>
              </el-row>
            </div>

            <!-- Display container for product data table -->
            <div class="display-container">
              <el-table
                  :data="filteredProductData"
                  stripe
                  style="width: 100%"
                  @row-click="handleRowClick"
                  highlight-current-row>
                <el-table-column
                    prop="productBarcode"
                    label="Barcode"
                    width="115">
                </el-table-column>
                <el-table-column
                    prop="productName"
                    label="Product Name"
                    width="210">
                </el-table-column>
                <el-table-column
                    prop="productPrice"
                    label="Price"
                    width="115">
                </el-table-column>
                <el-table-column
                    prop="productCollection"
                    label="Collection"
                    width="115">
                </el-table-column>
                <el-table-column
                    prop="productColour"
                    label="Colour"
                    width="115">
                </el-table-column>
                <el-table-column
                    prop="productReleaseYear"
                    label="Release Year"
                    width="115">
                </el-table-column>
                <el-table-column
                    prop="quantityInStock"
                    label="In Stock">
                </el-table-column>
                <el-table-column
                    prop="reservedQuantity"
                    label="Reserved">
                </el-table-column>
              </el-table>
            </div>
          </el-main>

          <!-- Aside section for action buttons -->
          <el-aside width="200px">
            <div class="button-container">
              <el-button type="danger" class="action-button" @click="goBack">Back</el-button>
              <el-button type="primary" class="action-button" @click="addProduct">Add</el-button>
              <el-button type="primary" class="action-button" @click ="editProduct">Edit</el-button>
              <el-button type="primary" class="action-button" @click ="goToReservationPage">Reserve</el-button>
            </div>
          </el-aside>
        </el-container>

        <!-- Dialog for editing product information -->
        <el-dialog title="Edit Product" :visible.sync="editDialogVisible">
          <el-form :model="editForm" :rules="rules" ref="editFormRef">
            <el-form-item label="Barcode" prop="productBarcode">
              <el-input v-model="editForm.productBarcode" disabled></el-input>
            </el-form-item>
            <el-form-item label="Product Name" prop="productName">
              <el-input v-model="editForm.productName"></el-input>
            </el-form-item>
            <el-form-item label="Price" prop="productPrice">
              <el-input v-model.number="editForm.productPrice" type="number"></el-input>
            </el-form-item>
            <el-form-item label="Collection" prop="productCollection">
              <el-input v-model="editForm.productCollection"></el-input>
            </el-form-item>
            <el-form-item label="Colour" prop="productColour">
              <el-input v-model="editForm.productColour"></el-input>
            </el-form-item>
            <el-form-item label="Release Year" prop="productReleaseYear">
              <el-input v-model.number="editForm.productReleaseYear" type="number"></el-input>
            </el-form-item>
            <el-form-item label="In Stock" prop="quantityInStock">
              <el-input v-model.number="editForm.quantityInStock" type="number"></el-input>
            </el-form-item>
            <el-form-item label="Reserved" prop="reservedQuantity">
              <el-input v-model.number="editForm.reservedQuantity" type="number"></el-input>
            </el-form-item>
          </el-form>
          <div slot="footer" class="dialog-footer">
            <el-button @click="editDialogVisible = false">Cancel</el-button>
            <el-button type="primary" @click="saveProduct">Save</el-button>
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
  name:"ItemInquiry",
  data(){
    const currentYear = new Date().getFullYear();
    return {
      itemInquiryPageMessage: "Item Inquiry",
      username:"User",
      // Array to store product data
      productData: [],
      // Array to store filtered product data
      filteredProductData: [],
      // Object to store current user data
      currentUser:null,
      // Object to store the selected product data
      selectedProduct: null,
      // Visibility state for edit dialog
      editDialogVisible: false,
      // Visibility state for account info dialog
      accountInfoVisible: false,
      // Form model for editing product details
      editForm: {
        productBarcode: '',
        productName: '',
        productPrice: '',
        productCollection: '',
        productColour: '',
        productReleaseYear: '',
        quantityInStock: '',
        reservedQuantity: ''
      },
      // Search criteria model for filtering products
      searchCriteria: {
        barcode: '',
        productName: '',
        productCollection: '',
        releaseYear: ''
      },
      // Validation rules for form fields
      rules: {
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
        ]
      }
    }
  },

  mounted(){
    // Fetch all product data on component mount
    request.get('/product/selectAll').then( res =>{
      this.productData = res.data;
      this.filteredProductData = res.data;
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
    // Navigate back to the previous page
    goBack(){
      this.$router.go(-1); // Navigate to the previous page
    },
    // Show account information dialog
    showAccountInfo() {
      this.accountInfoVisible = true;
    },
    // Load product data from the server
    loadProductData() {
      request.get('/product/selectAll').then(res => {
        this.productData = res.data;
        this.filteredProductData = res.data;
      }).catch(error => {
        console.error("There was an error loading the product data:", error);
        this.$message.error("Failed to load product data. Please try again.");
      });
    },
    // Navigate to the add product page
    addProduct(){
      // Retrieve the current user from local storage
      const currentUser = JSON.parse(localStorage.getItem("currentUser"));
      // Check if current user data exists
      if (currentUser) {
        this.$router.push({
          path: '/product/addproduct',
        });
      } else {
        // If no user data is found
        this.$message.error("Please log in to add a product");
      }
    },
    // Handle row click event in the product table
    handleRowClick(row) {
      this.selectedProduct = row;
    },
    // Edit the selected product
    editProduct() {
      if (this.selectedProduct) {
        this.editForm = { ...this.selectedProduct };
        this.editDialogVisible = true;
      } else {
        this.$message.warning("Please select a product to edit");
      }
    },
    // Save the edited product data
    saveProduct() {
      console.log("Save Product Clicked"); // Debugging log
      this.$refs.editFormRef.validate((valid) => {
        if (valid) {
          console.log("Form Validated, Saving Product...", this.editForm); // Debugging log
          // Call API to save the user data
          request.put('/product/update', this.editForm).then(res => {
            if (res.code === '200') {
              this.$message.success("Product updated successfully");
              this.editDialogVisible = false;
              // Refresh the table data
              this.loadProductData();
            } else {
              this.$message.error('Failed to update product. ' + res.msg + ' Please try again.');
            }
          }).catch(error => {
            console.error("There was an error updating the product:", error);
            this.$message.error("Failed to update product. Please try again.");
          });
        } else {
          this.$message.error("Please correct the errors in the form.");
          return false;
        }
      });
    },
    // Filter products based on search criteria
    searchProducts() {
      this.filteredProductData = this.productData.filter(product => {
        return (!this.searchCriteria.barcode || product.productBarcode.includes(this.searchCriteria.barcode)) &&
            (!this.searchCriteria.productName || product.productName.includes(this.searchCriteria.productName)) &&
            (!this.searchCriteria.productCollection || product.productCollection.includes(this.searchCriteria.productCollection)) &&
            (!this.searchCriteria.releaseYear || product.productReleaseYear.toString().includes(this.searchCriteria.releaseYear));
      });
    },
    // Navigate to the reservation page with the selected product's barcode
    goToReservationPage() {
      if (this.selectedProduct) {
        // Navigate to the reservation page with the selected product's barcode
        this.$router.push({
          path: '/reservation',
          query: { productBarcode: this.selectedProduct.productBarcode }
        });
      } else {
        this.$message.warning("Please select a product to reserve");
      }
    }
  }
}
</script>

<style scoped>
html, body, #itemInquiry {
  height: 100%;
  margin: 0;
  padding: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #f0f2f5;
}

.ItemInquiry-content-wrapper {
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
  display: flex;
  justify-content: center;
}


</style>
