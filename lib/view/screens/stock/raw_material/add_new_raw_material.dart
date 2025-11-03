import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../main.dart';
import '../../../../model/raw_material_model/raw_material_model.dart';
import '../../../component/textfield.dart';

class AddNewRawMaterial extends StatefulWidget {
  const AddNewRawMaterial({super.key});

  @override
  State<AddNewRawMaterial> createState() => _AddNewRawMaterialState();
}

final List<String> categories = ["0", "1", "2"];

class _AddNewRawMaterialState extends State<AddNewRawMaterial> {
  bool isEditMode = false;

  @override
  void initState() {
    super.initState();

    final args = Get.arguments;
    if (args != null &&
        args is Map &&
        args['isEdit'] == true &&
        args['material'] != null) {
      // Controller already filled in the list screen, but to be safe call fill again:
      final RawMaterialModel m = args['material'] as RawMaterialModel;
      rawMaterialController.fillMaterialData(m);
      setState(() => isEditMode = true);
    } else {
      rawMaterialController.clearAllFields();
      setState(() => isEditMode = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: Get.height / 30),

            // ---------- HEADER ----------
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
                            isEditMode
                                ? 'Edit Raw Material'
                                : 'Add New Raw Material',
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

            // ---------- BODY ----------
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
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        label: "Material Code",
                        controller:
                            rawMaterialController.materialCodeController,
                        isReadOnly: isEditMode,
                        hint: '',
                      ),
                      Text(
                        "Auto-generated unique code",
                        style: TextStyle(
                          fontSize: Get.width / 41.5,
                          color: const Color(0xff868686),
                        ),
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Material Name",
                        hint: "Enter Name",
                        controller:
                            rawMaterialController.materialNameController,
                      ),
                      SizedBox(height: Get.height / 60),
                      Obx(() {
                        if (premiumCollectionController.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (premiumCollectionController
                            .errorMessage
                            .isNotEmpty) {
                          return Text(
                            premiumCollectionController.errorMessage.value,
                            style: const TextStyle(color: Colors.red),
                          );
                        }

                        final categories = premiumCollectionController
                            .premiumCollection
                            .map((e) => e.categoryName)
                            .where((name) => name.isNotEmpty)
                            .toSet()
                            .toList();

                        if (categories.isEmpty) {
                          return const Text("No categories available");
                        }
                        return CustomDropdownField<String>(
                          label: "Category",
                          value:
                              createProductController
                                  .selectedCategoryName
                                  .value
                                  .isEmpty
                              ? null
                              : createProductController
                                    .selectedCategoryName
                                    .value,
                          items: categories,
                          onChanged: (val) {
                            if (val != null) {
                              createProductController
                                      .selectedCategoryName
                                      .value =
                                  val;

                              final selected = premiumCollectionController
                                  .premiumCollection
                                  .firstWhereOrNull(
                                    (e) => e.categoryName == val,
                                  );

                              if (selected != null) {
                                createProductController
                                        .selectedCategoryId
                                        .value =
                                    selected.categoryId;
                              }
                            }
                          },
                          getLabel: (item) => item,
                        );
                      }),
                      SizedBox(height: Get.height / 60),

                      Obx(
                        () => CustomDropdownField<int>(
                          label: "Supplier",
                          items: [
                            0,
                            1,
                            2,
                            3,
                          ], // adapt to your supplier ids list
                          value: rawMaterialController.selectedSupplier.value,
                          getLabel: (val) => val.toString(),
                          onChanged: (val) =>
                              rawMaterialController.selectedSupplier.value =
                                  val!,
                        ),
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Unit",
                        hint: "Enter Unit",
                        controller:
                            rawMaterialController.unitOfMeasureController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Initial Stock",
                        hint: "0",
                        controller:
                            rawMaterialController.currentQuantityController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Minimum Stock Level",
                        hint: "0",
                        controller:
                            rawMaterialController.minStockLevelController,
                        keyboardType: TextInputType.number,
                      ),
                      Text(
                        "Alert when stock falls below this level",
                        style: TextStyle(
                          fontSize: Get.width / 41.5,
                          color: const Color(0xff868686),
                        ),
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Maximum Stock Level",
                        hint: "0",
                        controller:
                            rawMaterialController.maxStockLevelController,
                        keyboardType: TextInputType.number,
                      ),
                      Text(
                        "Maximum stock to maintain",
                        style: TextStyle(
                          fontSize: Get.width / 41.5,
                          color: const Color(0xff868686),
                        ),
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Cost per Unit",
                        hint: "Enter Cost",
                        controller: rawMaterialController.costPriceController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Location",
                        hint: "Enter Location",
                        controller: rawMaterialController.locationController,
                      ),
                      SizedBox(height: Get.height / 60),

                      Obx(
                        () => CustomDropdownField<String>(
                          label: "Status",
                          items: ["Active", "InActive"],
                          value: rawMaterialController.selectedStatus.value,
                          getLabel: (val) => val,
                          onChanged: (val) =>
                              rawMaterialController.selectedStatus.value = val!,
                        ),
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Description",
                        hint: "Description",
                        controller: rawMaterialController.descriptionController,
                      ),
                      SizedBox(height: Get.height / 60),

                      UploadFileField(
                        label: "Material Image",
                        onFileSelected: (val) =>
                            rawMaterialController.materialImagePath.value = val,
                      ),
                      Text(
                        "Upload an image of the material (optional)",
                        style: TextStyle(
                          fontSize: Get.width / 41.5,
                          color: const Color(0xff868686),
                        ),
                      ),

                      SizedBox(height: Get.height / 60),

                      // ---------- SUBMIT BUTTON ----------
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
                            onPressed: rawMaterialController.isLoading.value
                                ? null
                                : () {
                                    if (isEditMode &&
                                        rawMaterialController
                                            .stockId
                                            .value
                                            .isNotEmpty) {
                                      rawMaterialController.updateMaterial(
                                        rawMaterialController.stockId.value,
                                      );
                                    } else {
                                      rawMaterialController.addRawMaterial();
                                    }
                                  },
                            child: rawMaterialController.isLoading.value
                                ? SizedBox(
                                    height: Get.height / 40,
                                    width: Get.height / 40,
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    isEditMode
                                        ? "Update Material"
                                        : "Add Raw Material",
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
