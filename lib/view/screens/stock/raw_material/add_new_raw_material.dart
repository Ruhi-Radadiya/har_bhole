import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../main.dart';
import '../../../../routes/routes.dart';
import '../../../component/textfield.dart';

class AddNewRawMaterial extends StatefulWidget {
  const AddNewRawMaterial({super.key});

  @override
  State<AddNewRawMaterial> createState() => _AddNewRawMaterialState();
}

final List<String> categories = ["0", "1", "2"];

class _AddNewRawMaterialState extends State<AddNewRawMaterial> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
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
                            'Add New Raw Material',
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
                child: Container(
                  padding: EdgeInsets.all(Get.width / 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.viewAllRawMaterial);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xffF78520),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'View All Material',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Get.width / 34.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height / 40),
                      CustomTextField(
                        label: "Material Code",
                        controller:
                            addRawMaterialController.materialCodeController,
                        isReadOnly: true,
                        hint: '',
                      ),
                      Text(
                        "Auto-generated unique code",
                        style: TextStyle(
                          fontSize: Get.width / 41.5,
                          color: Color(0xff868686),
                        ),
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Material Name",
                        hint: "Enter Name",
                        controller:
                            addRawMaterialController.materialNameController,
                      ),
                      SizedBox(height: Get.height / 60),
                      Obx(
                        () => CustomDropdownField<String>(
                          label: "Category",
                          value:
                              addRawMaterialController
                                  .selectedCategory
                                  .value
                                  .isEmpty
                              ? null
                              : addRawMaterialController.selectedCategory.value,
                          items: categories,
                          onChanged: (val) =>
                              addRawMaterialController.selectedCategory.value =
                                  val!,
                          getLabel: (item) => item,
                        ),
                      ),
                      SizedBox(height: Get.height / 60),
                      Obx(
                        () => CustomDropdownField<int>(
                          label: "Supplier",
                          items: [1, 2, 3],
                          value:
                              addRawMaterialController.selectedSupplier.value,
                          getLabel: (val) => val.toString(),
                          onChanged: (val) =>
                              addRawMaterialController.selectedSupplier.value =
                                  val!,
                        ),
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Unit",
                        hint: "Enter Unit",
                        controller:
                            addRawMaterialController.unitOfMeasureController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Initial Stock",
                        hint: "0",
                        controller:
                            addRawMaterialController.currentQuantityController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Minimum Stock Level",
                        hint: "0",
                        controller:
                            addRawMaterialController.minStockLevelController,
                        keyboardType: TextInputType.number,
                      ),
                      Text(
                        "Alert when stock falls below this level",
                        style: TextStyle(
                          fontSize: Get.width / 41.5,
                          color: Color(0xff868686),
                        ),
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Maximum Stock Level",
                        hint: "0",
                        controller:
                            addRawMaterialController.maxStockLevelController,
                        keyboardType: TextInputType.number,
                      ),
                      Text(
                        "Maximum stock to maintain",
                        style: TextStyle(
                          fontSize: Get.width / 41.5,
                          color: Color(0xff868686),
                        ),
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Cost per Unit",
                        hint: "tesr",
                        controller:
                            addRawMaterialController.costPriceController,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Address",
                        hint: "tesr",
                        controller: addRawMaterialController.locationController,
                      ),

                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Cost per Unit",
                        hint: "0",
                        controller:
                            addRawMaterialController.costPriceController,
                      ),
                      SizedBox(height: Get.height / 60),
                      Obx(
                        () => CustomDropdownField<String>(
                          label: "Status",
                          items: ["Active", "InActive"],
                          value:
                              addRawMaterialController
                                  .selectedStatus
                                  .value
                                  .isEmpty
                              ? "Active"
                              : addRawMaterialController.selectedStatus.value,
                          getLabel: (val) => val,
                          onChanged: (val) =>
                              addRawMaterialController.selectedStatus.value =
                                  val!,
                        ),
                      ),

                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Description",
                        hint: "Description",
                        controller:
                            addRawMaterialController.descriptionController,
                      ),

                      SizedBox(height: Get.height / 60),
                      UploadFileField(
                        label: "Material Image",
                        onFileSelected: (val) =>
                            addRawMaterialController.materialImagePath.value =
                                val,
                      ),

                      Text(
                        "Upload an image of the material (optional) ",
                        style: TextStyle(
                          fontSize: Get.width / 41.5,
                          color: Color(0xff868686),
                        ),
                      ),
                      SizedBox(height: Get.height / 60),
                      SizedBox(
                        width: double.infinity,
                        height: Get.height / 18,
                        child: Obx(
                          () => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF78520),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: addRawMaterialController.isLoading.value
                                ? null // disable button while loading
                                : () {
                                    addRawMaterialController.addRawMaterial();
                                  },
                            child: addRawMaterialController.isLoading.value
                                ? SizedBox(
                                    height: Get.height / 40,
                                    width: Get.height / 40,
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    "Add Raw Materials",
                                    style: GoogleFonts.poppins(
                                      fontSize: Get.width / 22.5,
                                      color: Colors.white,
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
            SizedBox(height: Get.height / 20),
          ],
        ),
      ),
    );
  }
}
