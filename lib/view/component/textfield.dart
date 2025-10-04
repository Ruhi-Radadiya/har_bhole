import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final String? label; // 👈 Added label
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

  const CustomTextField({
    super.key,
    required this.hint,
    this.label, // 👈 Added
    this.image,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.maxLines = 1,
    this.controller,
    this.suffixIcon,
    this.fillColor,
    this.validator,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget textField = SizedBox(
      height: maxLines > 1 ? Get.height / 6 : Get.height / 20,
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
            ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontSize: 14,
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
      fillColor: fillColor ?? const Color(0xffF3F7FC),
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
                    height: Get.height / 50,
                    width: Get.width / 50,
                    child: Image.asset(image!, fit: BoxFit.contain),
                  )
                : null),
      prefixIconConstraints: BoxConstraints(
        minWidth: Get.width / 10,
        minHeight: Get.height / 50,
      ),
      suffixIcon: suffixIcon,
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

    // Show option to choose from camera or gallery
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choose from Gallery'),
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
              leading: Icon(Icons.photo_camera),
              title: Text('Take Photo'),
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

  Widget _buildImagePreview() {
    if (_selectedFile != null) {
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: FileImage(_selectedFile!),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return Icon(Icons.cloud_upload_outlined, size: 24);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: Get.height / 150),
        Container(
          height: Get.height / 20,
          decoration: BoxDecoration(
            color: Color(0xffF3F7FC),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: ElevatedButton(
            onPressed: _pickImage,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffF3F7FC),
              foregroundColor: Color(0xff858585),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildImagePreview(),
                SizedBox(width: 8),
                Text(
                  textAlign: TextAlign.left,
                  _selectedFile != null ? 'Change image' : 'Upload image',
                  style: TextStyle(fontSize: Get.width / 30),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        if (_fileName != null) ...[
          SizedBox(height: 8),
          Text(
            'Selected: $_fileName',
            style: TextStyle(
              fontSize: 12,
              color: Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
        SizedBox(height: Get.height / 50),
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
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xff000000),
            ),
          ),
        ),
        SizedBox(height: Get.height / 150),
        Container(
          height: Get.height / 20,
          padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
          decoration: BoxDecoration(
            color: fillColor ?? const Color(0xffF3F7FC),
            borderRadius: BorderRadius.circular(12.0),
            border: validator != null && validator!(value) != null
                ? Border.all(color: Colors.red)
                : null,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: (value != null && items.contains(value)) ? value : null,
              hint: Text(
                hint ?? 'Select',
                style: TextStyle(
                  color: const Color(0xff858585),
                  fontSize: Get.width / 30,
                ),
              ),
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down, color: Color(0xff858585)),
              style: TextStyle(fontSize: Get.width / 30, color: Colors.black),
              onChanged: onChanged,
              items: items.map((T item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(getLabel(item)),
                );
              }).toList(),
            ),
          ),
        ),
        if (validator != null && validator!(value) != null) ...[
          SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.only(left: Get.width / 50),
            child: Text(
              validator!(value)!,
              style: TextStyle(color: Colors.red, fontSize: Get.width / 35),
            ),
          ),
        ],
        SizedBox(height: Get.height / 50),
      ],
    );
  }
}
