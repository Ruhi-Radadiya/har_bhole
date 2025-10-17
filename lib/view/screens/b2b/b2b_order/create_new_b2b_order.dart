import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';

import '../../../../model/b2b_order/b2b_order_model.dart';
import '../../../../model/product_model/product_model.dart';
import '../../../component/textfield.dart';

class CreateNewB2BOrder extends StatefulWidget {
  const CreateNewB2BOrder({super.key});

  @override
  State<CreateNewB2BOrder> createState() => _CreateNewB2BOrderState();
}

class _CreateNewB2BOrderState extends State<CreateNewB2BOrder> {
  final _formKey = GlobalKey<FormState>();
  B2BOrder? editingOrder;

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null && Get.arguments is B2BOrder) {
      editingOrder = Get.arguments as B2BOrder;
      _prefillOrder(editingOrder!);

      // Prefill dropdowns
      selectedStatus = editingOrder!.status;
      selectedPaymentStatus = editingOrder!.paymentStatus;
      createB2BOrderController.statusController.text = selectedStatus;
      createB2BOrderController.paymentStatusController.text =
          selectedPaymentStatus;
    }
  }

  void _prefillOrder(B2BOrder order) {
    // Customer details
    createB2BOrderController.customerNameController.text = order.customerName;
    createB2BOrderController.customerEmailController.text = order.customerEmail;
    createB2BOrderController.customerPhoneController.text = order.customerPhone;
    createB2BOrderController.customerAddressController.text =
        order.customerAddress;
    createB2BOrderController.customerCompanyController.text =
        order.customerCompany;
    createB2BOrderController.customerGstController.text = order.customerGst;

    // Order items - taking first item for simplicity
    if (order.items.isNotEmpty) {
      final item = order.items[0];
      createB2BOrderController.productController.text = item.productName;
      createB2BOrderController.variationController.text = item.variationValue;
      createB2BOrderController.quantityController.text = item.quantity
          .toString();
      createB2BOrderController.priceController.text = item.price.toString();
      createB2BOrderController.gstController.text = order.customerGst
          .toString();
      createB2BOrderController.totalController.text = item.total.toString();
      createB2BOrderController.totalAmountController.text = order.totalAmount;
    }
  }

  void _clearAll() {
    _formKey.currentState!.reset();
    createB2BOrderController.clearAll();
  }

  final List<String> statusOptions = [
    "Pending",
    "Processing",
    "Completed",
    "Cancelled",
  ];
  final List<String> paymentStatusOptions = [
    "Pending",
    "Paid",
    "Failed",
    "Refunded",
  ];

  String selectedStatus = "Pending";
  String selectedPaymentStatus = "Pending";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: Get.height / 30),
            Container(
              padding: EdgeInsets.only(
                left: Get.width / 25,
                right: Get.width / 25,
                bottom: Get.height / 100,
              ),
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  SizedBox(height: Get.height / 100),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color(0xffF78520),
                        ),
                        onPressed: () => Get.back(),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(minWidth: Get.width / 15),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            editingOrder != null
                                ? 'Edit B2B Order'
                                : 'Create New B2B Order',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: Get.width / 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: Get.width / 15),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(Get.width / 30),
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.all(Get.width / 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle("Customer Details"),
                        CustomTextField(
                          label: "Customer Name",
                          hint: "Enter Your Name",
                          controller:
                              createB2BOrderController.customerNameController,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: "Customer Email",
                          hint: "Enter Your Email",
                          controller:
                              createB2BOrderController.customerEmailController,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: "Customer Phone",
                          hint: "Enter Your Phone Number",
                          controller:
                              createB2BOrderController.customerPhoneController,
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: "Customer Address",
                          hint: "Enter Your Address",
                          controller: createB2BOrderController
                              .customerAddressController,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: "Company",
                          hint: "Enter Your Company Name",
                          controller: createB2BOrderController
                              .customerCompanyController,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: "GST",
                          hint: "Enter GST",
                          controller:
                              createB2BOrderController.customerGstController,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: Get.height / 60),

                        _sectionTitle("Order Items"),
                        SizedBox(height: Get.height / 60),
                        Obx(
                          () => CustomDropdownField<Product>(
                            label: "Product",
                            items: productController.filteredProducts,
                            value:
                                createB2BOrderController.selectedProduct.value,
                            getLabel: (product) => product.productName,
                            onChanged: (product) {
                              createB2BOrderController.selectedProduct.value =
                                  product;
                              createB2BOrderController.productController.text =
                                  product?.productName ?? '';

                              // Set the unit price from selected product
                              createB2BOrderController.unitPrice.value =
                                  product?.sellingPrice ?? 0;

                              // Recalculate total if quantity already entered
                              createB2BOrderController.updateTotal();
                            },
                            hint: "Select Product",
                          ),
                        ),

                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: "Variation",
                          hint: "Select Variation",
                          controller:
                              createB2BOrderController.variationController,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: "Quantity",
                          hint: "0",
                          controller:
                              createB2BOrderController.quantityController,
                          keyboardType: TextInputType.number,
                          onChanged: (_) =>
                              createB2BOrderController.updateTotal(),
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: "Price",
                          hint: "0.00",
                          controller: createB2BOrderController.priceController,
                          keyboardType: TextInputType.number,
                          onChanged: (_) =>
                              createB2BOrderController.updateTotal(),
                          isReadOnly: true,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: "Total",
                          hint: "0.00",
                          controller: createB2BOrderController.totalController,
                          keyboardType: TextInputType.number,
                          isReadOnly: true,
                        ),
                        SizedBox(height: Get.height / 60),
                        if (editingOrder != null) ...[
                          Text(
                            "Quick Actions",
                            style: GoogleFonts.poppins(
                              fontSize: Get.width / 20,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xffF78520),
                            ),
                          ),
                          SizedBox(height: Get.height / 60),
                          CustomDropdownField<String>(
                            label: "Order Status",
                            items: statusOptions,
                            value: selectedStatus,
                            getLabel: (val) => val,
                            onChanged: (val) {
                              if (val != null) {
                                setState(() {
                                  selectedStatus = val;
                                  createB2BOrderController
                                          .statusController
                                          .text =
                                      val;
                                });
                              }
                            },
                            hint: "Select Status",
                          ),
                          SizedBox(height: Get.height / 60),
                          CustomDropdownField<String>(
                            label: "Payment Status",
                            items: paymentStatusOptions,
                            value: selectedPaymentStatus,
                            getLabel: (val) => val,
                            onChanged: (val) {
                              if (val != null) {
                                setState(() {
                                  selectedPaymentStatus = val;
                                  createB2BOrderController
                                          .paymentStatusController
                                          .text =
                                      val;
                                });
                              }
                            },
                            hint: "Select Payment Status",
                          ),
                          SizedBox(height: Get.height / 60),
                        ],

                        // Submit Button
                        Obx(
                          () => SizedBox(
                            width: double.infinity,
                            height: Get.height / 18,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffF78520),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed:
                                  createB2BOrderController.isLoading.value
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        if (editingOrder != null) {
                                          createB2BOrderController
                                              .updateB2BOrder(editingOrder!.id);
                                        } else {
                                          createB2BOrderController
                                              .addB2BOrder();
                                        }
                                      }
                                    },
                              child: createB2BOrderController.isLoading.value
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      editingOrder != null
                                          ? "Update Order"
                                          : "Create Order",
                                      style: GoogleFonts.poppins(
                                        fontSize: Get.width / 22.5,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height / 60),

                        // Clear Button
                        SizedBox(
                          height: Get.height / 18,
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: _clearAll,
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                color: Color(0xffF78520),
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Clear All',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: Get.width / 22.5,
                                  color: Color(0xffF78520),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.height / 20),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: Get.width / 21,
          color: Color(0xffF78520),
        ),
      ),
    );
  }
}
