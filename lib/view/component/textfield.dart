import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final String? label;
  final String? image;
  final bool isPassword;
  final TextInputType keyboardType;
  final IconData? icon;
  final int maxLines;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Color? fillColor;
  final String? Function(String?)? validator;
  final bool isReadOnly;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.hint,
    this.label,
    this.image,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.maxLines = 1,
    this.controller,
    this.suffixIcon,
    this.fillColor,
    this.validator,
    this.onChanged,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget textField = SizedBox(
      child: validator != null
          ? TextFormField(
              textInputAction: TextInputAction.next,
              controller: controller,
              maxLines: maxLines,
              cursorColor: const Color(0xff000000),
              obscureText: isPassword,
              keyboardType: keyboardType,
              readOnly: isReadOnly,
              style: TextStyle(fontSize: Get.width / 30),
              validator: validator,
              decoration: _decoration(),
              onChanged: onChanged,
            )
          : TextField(
              textInputAction: TextInputAction.next,
              controller: controller,
              maxLines: maxLines,
              cursorColor: const Color(0xff000000),
              obscureText: isPassword,
              keyboardType: keyboardType,
              readOnly: isReadOnly,
              style: TextStyle(fontSize: Get.width / 30),
              decoration: _decoration(),
              onChanged: onChanged,
            ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontSize: Get.width / 26,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(height: Get.height / 150),
        ],
        textField,
      ],
    );
  }

  InputDecoration _decoration() {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.red),
      ),
      filled: true,
      fillColor: fillColor ?? const Color(0xffFAF7F6),
      hintText: hint,
      hintStyle: TextStyle(
        color: const Color(0xff858585),
        fontSize: Get.width / 30,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      prefixIcon: icon != null
          ? Icon(icon, color: const Color(0xffC0C5CF), size: Get.width / 16)
          : (image != null
                ? SizedBox(
                    height: Get.height / 45,
                    width: Get.width / 45,
                    child: Image.asset(
                      image!,
                      fit: BoxFit.contain,
                      color: Color(0xffBEBEBE),
                    ),
                  )
                : null),
      prefixIconConstraints: BoxConstraints(
        minWidth: Get.width / 10,
        minHeight: Get.height / 50,
      ),
      suffixIcon: suffixIcon,
      // suffixIcon: suffixIcon ??
      //           (suffixImage != null
      //               ? Padding(
      //             padding: EdgeInsets.all(Get.width / 60),
      //             child: Image.asset(
      //               suffixImage!,
      //               fit: BoxFit.contain,
      //               color: const Color(0xffBEBEBE),
      //             ),
      //           )
      //               : null),
      //       suffixIconConstraints: BoxConstraints(
      //         minWidth: Get.width / 10,
      //         minHeight: Get.height / 50,
      //       ),
      contentPadding: EdgeInsets.symmetric(
        vertical: Get.height / 80,
        horizontal: Get.width / 25,
      ),
      errorStyle: TextStyle(fontSize: Get.width / 35, color: Colors.red),
    );
  }
}

class FieldValidator {
  /// Validate required fields (with field names)
  static bool validateRequired(Map<String, TextEditingController> fields) {
    for (var entry in fields.entries) {
      if (entry.value.text.trim().isEmpty) {
        Get.snackbar(
          "Error",
          "${entry.key} is required",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
          margin: const EdgeInsets.all(12),
          duration: const Duration(seconds: 2),
        );
        return false;
      }
    }
    return true;
  }
}

class UploadFileField extends StatefulWidget {
  final String label;
  final Function(String) onFileSelected;

  const UploadFileField({
    super.key,
    required this.label,
    required this.onFileSelected,
  });

  @override
  State<UploadFileField> createState() => _UploadFileFieldState();
}

class _UploadFileFieldState extends State<UploadFileField> {
  File? _selectedFile;
  String? _fileName;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () async {
                Get.back();
                final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                  maxWidth: 800,
                  maxHeight: 800,
                  imageQuality: 80,
                );
                if (image != null) {
                  setState(() {
                    _selectedFile = File(image.path);
                    _fileName = image.name;
                  });
                  widget.onFileSelected(image.path);
                  Get.snackbar(
                    'Success',
                    '${widget.label} selected',
                    snackPosition: SnackPosition.TOP,
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Take Photo'),
              onTap: () async {
                Get.back();
                final XFile? image = await picker.pickImage(
                  source: ImageSource.camera,
                  maxWidth: 800,
                  maxHeight: 800,
                  imageQuality: 80,
                );
                if (image != null) {
                  setState(() {
                    _selectedFile = File(image.path);
                    _fileName = image.name;
                  });
                  widget.onFileSelected(image.path);
                  Get.snackbar(
                    'Success',
                    '${widget.label} selected',
                    snackPosition: SnackPosition.TOP,
                  );
                }
              },
            ),
            SizedBox(height: Get.height / 30),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = Get.width;
    final screenHeight = Get.height;

    // The label remains the same
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: screenWidth / 26,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        SizedBox(height: screenHeight / 150),

        GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: screenHeight / 20,
            decoration: BoxDecoration(
              color: const Color(0xffFAF7F6),
              borderRadius: BorderRadius.circular(8.0),
            ),
            clipBehavior: Clip.antiAlias,

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: screenWidth * 0.3,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: Color(0xffFAF7F6)),
                  child: Text(
                    "Choose File",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: screenWidth / 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    alignment: Alignment.centerLeft,
                    color: const Color(0xffF2F1F0),

                    child: Text(
                      _fileName ?? "No File Chosen",
                      style: TextStyle(
                        fontSize: screenWidth / 30,
                        color: _fileName == null
                            ? Colors.black54
                            : Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: screenHeight / 50),
      ],
    );
  }
}

class CustomDropdownField<T> extends StatelessWidget {
  final String label;
  final List<T> items;
  final T? value;
  final String Function(T) getLabel;
  final void Function(T?) onChanged;
  final String? hint;
  final Color? fillColor;
  final String? Function(T?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.items,
    required this.value,
    required this.getLabel,
    required this.onChanged,
    this.hint,
    this.fillColor,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = Get.width;
    final screenHeight = Get.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: TextStyle(
              fontSize: screenWidth / 26,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(height: screenHeight / 150),
        ],
        Container(
          height:
              screenHeight / 20 + screenHeight / 80, // same as CustomTextField
          padding: EdgeInsets.symmetric(horizontal: screenWidth / 25),
          decoration: BoxDecoration(
            color: fillColor ?? const Color(0xffFAF7F6),
            borderRadius: BorderRadius.circular(12.0),
            border: validator != null && validator!(value) != null
                ? Border.all(color: Colors.red)
                : null,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: (value != null && items.contains(value)) ? value : null,
              hint: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  hint ?? 'Select',
                  style: TextStyle(
                    fontSize: screenWidth / 28,
                    color: const Color(0xff858585),
                  ),
                ),
              ),
              isExpanded: true,
              icon:
                  suffixIcon ??
                  const Icon(Icons.arrow_drop_down, color: Color(0xffC0C5CF)),
              style: TextStyle(
                fontSize: screenWidth / 30,
                color: Colors.black,
                height: 1.2, // ensures vertical centering
              ),
              onChanged: onChanged,
              alignment: Alignment.centerLeft,
              selectedItemBuilder: (BuildContext context) {
                // ensures selected value uses same font size and alignment
                return items.map((T item) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      getLabel(item),
                      style: TextStyle(
                        fontSize: screenWidth / 30,
                        color: Colors.black,
                        height: 1.2,
                      ),
                    ),
                  );
                }).toList();
              },
              items: items.map((T item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    getLabel(item),
                    style: TextStyle(fontSize: screenWidth / 30),
                  ),
                );
              }).toList(),
              dropdownColor: fillColor ?? const Color(0xffFAF7F6),
            ),
          ),
        ),
        if (validator != null && validator!(value) != null) ...[
          SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.only(left: screenWidth / 50),
            child: Text(
              validator!(value)!,
              style: TextStyle(color: Colors.red, fontSize: screenWidth / 35),
            ),
          ),
        ],
      ],
    );
  }
}

class CustomDateField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final VoidCallback onTap;
  final Color? fillColor;
  final String? hint;

  const CustomDateField({
    super.key,
    required this.label,
    required this.controller,
    required this.onTap,
    this.fillColor,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = Get.width;
    final screenHeight = Get.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: screenWidth / 26,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: screenHeight / 150),
        ],
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: screenHeight / 20 + screenHeight / 80, // same as textfield
            padding: EdgeInsets.symmetric(horizontal: screenWidth / 25),
            decoration: BoxDecoration(
              color: fillColor ?? const Color(0xffFAF7F6),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.transparent),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      controller.text.isEmpty
                          ? (hint ?? "Select Date")
                          : controller.text,
                      style: TextStyle(
                        fontSize: screenWidth / 30,
                        color: controller.text.isEmpty
                            ? const Color(0xff858585)
                            : Colors.black,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  color: Color(0xffC0C5CF),
                  size: Get.width / 18,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
