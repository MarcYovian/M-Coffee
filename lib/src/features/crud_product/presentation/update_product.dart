import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_coffee_v2/src/constants/app_constants.dart';
import 'package:m_coffee_v2/src/features/crud_product/presentation/widgets/star_widget.dart';
import 'package:m_coffee_v2/src/utils/api_client.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class UpdateProduct extends StatefulWidget {
  final Products? data;
  const UpdateProduct({super.key, this.data});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  File? imageFile;
  String? imgName;

  final _picker = ImagePicker();

  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  double rating = 2.5;

  // List kategori
  List<String> categories = [
    "Coffee",
    "Noodle",
    "Rice",
    "Snack",
    "Spaghetti",
    "Tea",
    "Toast",
  ];
  String? category;
  int lastValidValue = 0;

  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController discountController;
  late TextEditingController descriptionController;
  late TextEditingController numOfSalesController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.data?.name);
    priceController =
        TextEditingController(text: widget.data?.price.toString());
    discountController =
        TextEditingController(text: widget.data?.discount.toString());
    descriptionController =
        TextEditingController(text: widget.data?.description);
    numOfSalesController =
        TextEditingController(text: widget.data?.numOfSales.toString());
    category = widget.data?.category;
    rating = widget.data!.rating;
    imageFile = File(
        "C:/Users/marce/OneDrive/Dokumen/assets/images/products/${widget.data?.image}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Product"),
        backgroundColor: AppConstants.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _openImagePicker,
                child: Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                    border: imageFile == null
                        ? Border.all(
                            color: Colors.black54,
                            style: BorderStyle.solid,
                            width: 2.0,
                          )
                        : null,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: imageFile == null
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.photo,
                                  size: 48.0, color: Colors.black54),
                              SizedBox(height: 8.0),
                              Text(
                                'Select Image',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            imageFile!,
                            height: 200.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Product Name",
                  hintText: "Enter a product name",
                ),
              ),
              const Gap(5),
              TextField(
                controller: priceController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: "Product Price",
                  hintText: "Enter a product price",
                ),
              ),
              const Gap(10),
              SizedBox(
                width: double.infinity,
                child: DropdownButton(
                  isExpanded: true,
                  value: category,
                  hint: const Text("Choose a category"),
                  items: const <DropdownMenuItem<String>>[
                    DropdownMenuItem(
                      value: "coffee",
                      child: Text("Coffee"),
                    ),
                    DropdownMenuItem(
                      value: "noodle",
                      child: Text("Noodle"),
                    ),
                    DropdownMenuItem(
                      value: "rice",
                      child: Text("Rice"),
                    ),
                    DropdownMenuItem(
                      value: "snack",
                      child: Text("Snack"),
                    ),
                    DropdownMenuItem(
                      value: "spaghetti",
                      child: Text("Spaghetti"),
                    ),
                    DropdownMenuItem(
                      value: "tea",
                      child: Text("Tea"),
                    ),
                    DropdownMenuItem(
                      value: "toast",
                      child: Text("Toast"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      category = value!;
                    });
                  },
                ),
              ),
              const Gap(5),
              TextField(
                controller: discountController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    int inputValue = int.parse(value);

                    if (inputValue > 100) {
                      discountController.text = lastValidValue.toString();
                    } else {
                      lastValidValue = inputValue;
                    }
                  }
                },
                decoration: const InputDecoration(
                  labelText: "Product discount",
                  hintText: "Enter a product discount",
                ),
              ),
              const Gap(15),
              const Text(
                "Product Rating",
                style:
                    TextStyle(fontSize: 16, color: AppConstants.secondaryColor),
              ),
              Slider(
                value: rating,
                min: 0.0,
                max: 5.0,
                divisions: 50,
                activeColor: AppConstants.primaryColor,
                onChanged: (value) {
                  setState(() {
                    rating = value;
                  });
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StarRating(rating: rating),
                  const Gap(15),
                  Text(
                    rating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.primaryColor,
                    ),
                  ),
                ],
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "Product description",
                  hintText: "Enter a product description",
                ),
              ),
              const Gap(5),
              TextField(
                controller: numOfSalesController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: "Product Sales",
                  hintText: "Enter a product sales",
                ),
              ),
              const Gap(15),
              ElevatedButton(
                onPressed: () async {
                  if (imageFile == null ||
                      nameController.text.isEmpty ||
                      priceController.text.isEmpty ||
                      discountController.text.isEmpty ||
                      descriptionController.text.isEmpty ||
                      numOfSalesController.text.isEmpty ||
                      category == null) {
                    // Menampilkan alert jika ada data yang belum diisi
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            "Error",
                            style: TextStyle(color: AppConstants.primaryText),
                          ),
                          content: const Text(
                            "Please fill in all the fields",
                            style: TextStyle(color: AppConstants.primaryText),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "OK",
                                style:
                                    TextStyle(color: AppConstants.primaryText),
                              ),
                            ),
                          ],
                          backgroundColor: AppConstants.primaryColor,
                        );
                      },
                    );
                  } else {
                    // Save image to direktori
                    final directory = await getApplicationDocumentsDirectory();
                    final subDirectory =
                        Directory('${directory.path}/assets/images/products/');
                    final fileName = basename(imageFile!.path);
                    imgName = fileName;
                    if (!(await subDirectory.exists())) {
                      await subDirectory.create(recursive: true);
                    }
                    imageFile =
                        await imageFile!.copy('${subDirectory.path}/$fileName');

                    // add new Data
                    final newProduct = Products(
                      id: widget.data?.id,
                      name: nameController.text,
                      image: imgName.toString(),
                      price: int.parse(priceController.text),
                      discount: int.parse(discountController.text),
                      description: descriptionController.text,
                      rating: double.parse(rating.toStringAsFixed(1)),
                      numOfSales: int.parse(numOfSalesController.text),
                      category: category.toString(),
                    );
                    await ApiClient.UpdateProducts(newProduct);
                    Navigator.pop(context);
                  }
                },
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(AppConstants.primaryColor),
                ),
                child: const Text("Add Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
