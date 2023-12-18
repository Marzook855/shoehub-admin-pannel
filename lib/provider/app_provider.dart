import 'dart:io';

import 'package:admin_panel/constants/constants.dart';
import 'package:admin_panel/helpers/firebase_firestore_helper/firebase_firestore.dart';
import 'package:admin_panel/models/category_model/category_model.dart';
import 'package:admin_panel/models/order_model/order_model.dart';
import 'package:admin_panel/models/product_model/product_model.dart';
import 'package:admin_panel/models/user_model/user_model.dart';

import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  List<UserModel> _userList = [];
  List<CategoryModel> _categoriesList = [];
  List<ProductModel> _productList = [];
  List<OrderModel> _completedOrderList = [];
  List<OrderModel> _cancelOrderList = [];
  List<OrderModel> _pendingOrderList = [];
  List<OrderModel> _deliveryOrderList = [];
  List<String?> _usersToken = [];

  double _totalEarning = 0.0;

  Future<void> getUserListFun() async {
    _userList = await FirebaseFirestoreHelper.instance.getUserList();
    _usersToken = _userList.map((e) => e.notificationToken).toList();
  }

  Future<void> getCompletedOrder() async {
    _completedOrderList =
        await FirebaseFirestoreHelper.instance.getCompletedOrder();
    for (var element in _completedOrderList) {
      _totalEarning += element.totalPrice;
    }
    notifyListeners();
  }

  Future<void> getCancelOrder() async {
    _cancelOrderList = await FirebaseFirestoreHelper.instance.getCancelOrder();

    notifyListeners();
  }

  Future<void> getDeliveryOrder() async {
    _deliveryOrderList =
        await FirebaseFirestoreHelper.instance.getDeliveryOrder();

    notifyListeners();
  }

  Future<void> getPendingOrder() async {
    _pendingOrderList =
        await FirebaseFirestoreHelper.instance.getPendingOrder();

    notifyListeners();
  }

  Future<void> getCategoriesListFun() async {
    _categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
  }

  Future<void> deletUserFromFirebase(UserModel userModel) async {
    notifyListeners();
    String value =
        await FirebaseFirestoreHelper.instance.deleteSingleUser(userModel.id);
    if (value == "Successfully Deleted") {
      _userList.remove(userModel);
      showMessage("Successfully Deleted");
    }

    notifyListeners();
  }

  List<UserModel> get getUserList => _userList;

  double get getTotalEarning => _totalEarning;

  List<CategoryModel> get getCategories => _categoriesList;

  List<ProductModel> get getProducts => _productList;

  List<OrderModel> get getCompletedOrderList => _completedOrderList;

  List<OrderModel> get getCancelOrderList => _cancelOrderList;

  List<OrderModel> get getPendingOrderList => _pendingOrderList;

  List<OrderModel> get getDeliveryOrderList => _deliveryOrderList;

  List<String?> get getUsersToken => _usersToken;

  Future<void> callBackFunction() async {
    await getUserListFun();
    await getCategoriesListFun();
    await getProduct();
    await getCompletedOrder();
    await getCancelOrder();
    await getPendingOrder();
    await getDeliveryOrder();
  }

  void updateUserList(int index, UserModel userModel) async {
    await FirebaseFirestoreHelper.instance.updateUser(userModel);
    _userList[index] = userModel;

    notifyListeners();
  }

  /////category delet

  Future<void> deletCategoryFromFirebase(CategoryModel categoryModel) async {
    String value = await FirebaseFirestoreHelper.instance
        .deleteSingleCategory(categoryModel.id);
    if (value == "Successfully Deleted") {
      _categoriesList.remove(categoryModel);
      showMessage("Successfully Deleted");
    }

    notifyListeners();
  }

  void updateCategoryList(int index, CategoryModel categoryModel) async {
    await FirebaseFirestoreHelper.instance.updateSingleCategory(categoryModel);
    _categoriesList[index] = categoryModel;

    notifyListeners();
  }

  void addedCategory(File image, String name) async {
    CategoryModel categoryModel =
        await FirebaseFirestoreHelper.instance.addSingleCategory(image, name);
    _categoriesList.add(categoryModel);

    notifyListeners();
  }

  Future<void> getProduct() async {
    _productList = await FirebaseFirestoreHelper.instance.getProducts();

    notifyListeners();
  }

  Future<void> deletProductsFromFirebase(ProductModel productModel) async {
    String value = await FirebaseFirestoreHelper.instance
        .deletProduct(productModel.categoryId, productModel.id);
    if (value == "Successfully Deleted") {
      _productList.remove(productModel);
      showMessage("Successfully Deleted");
    }

    notifyListeners();
  }

  void updateProductList(int index, ProductModel productModel) async {
    await FirebaseFirestoreHelper.instance.updateSingleProduct(productModel);
    _productList[index] = productModel;

    notifyListeners();
  }

  void addProduct(
    File image,
    String name,
    String categoryId,
    String price,
    String description,
  ) async {
    ProductModel productModel = await FirebaseFirestoreHelper.instance
        .addSingleProduct(image, name, categoryId, price, description);
    _productList.add(productModel);

    notifyListeners();
  }

  void updatePendingOrder(OrderModel order) {
    _deliveryOrderList.add(order);
    _pendingOrderList.remove(order);
    notifyListeners();
    showMessage("Send to Delivery");
  }

  void updateCancelPendingOrder(OrderModel order) {
    _cancelOrderList.add(order);
    _pendingOrderList.remove(order);
    showMessage("Succefully Cancel");
    notifyListeners();
  }

  void updateCancelDeliveryOrder(OrderModel order) {
    _cancelOrderList.add(order);
    _deliveryOrderList.remove(order);
    showMessage("Succefully Cancel");
    notifyListeners();
  }
}
