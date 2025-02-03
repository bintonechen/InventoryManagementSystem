import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from "@/components/Login.vue"
import ManageAccount from "@/components/ManageAccount.vue";
import Customer from "@/components/Customer.vue";
import Product from "@/components/Product.vue";
import Home from "@/components/Home.vue";
import Reservation from "@/components/Reservation.vue";
import RegisterUser from "@/components/RegisterUser.vue";
import RegisterCustomer from "@/components/RegisterCustomer.vue";
import AddProduct from "@/components/AddProduct.vue";

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/login',
    name: 'Login',
    component: Login
  },{
    path: '/manageaccount',
    name: 'ManageAccount',
    component: ManageAccount
  },{
    path: '/customer',
    name: 'Customer',
    component: Customer
  },{
    path: '/product',
    name: 'Product',
    component: Product
  },{
    path: '/reservation',
    name: 'Reservation',
    component: Reservation
  },{
    path: '/manageaccount/register',
    name: 'RegisterUser',
    component: RegisterUser
  },
  {
    path: '/customer/register',
    name: 'RegisterCustomer',
    component: RegisterCustomer
  },
  {
    path: '/product/addproduct',
    name: 'AddProduct',
    component: AddProduct
  }

]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
});

// 路由守卫
// router.beforeEach((to, from, next) => {
//   let adminPaths = ['/manageaccount']
//   let user = JSON.parse(localStorage.getItem('currentUser') || '{}')
//
//   if (user.role !== 'Manager' && adminPaths.includes(to.path)) {
//     // 如果当前登录的用户不是管理员，然后当前的到达的路径是管理员才有权限访问的路径，那这个时候我就让用户去到一个没有权限的页面，不让他访问实际的页面
//     next('/manageaccount')
//     this.$message.error("Only Managers have access to this page");
//   } else {
//     next()
//   }
// })

export default router
