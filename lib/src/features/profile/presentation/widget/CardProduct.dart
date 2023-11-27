// ignore_for_file: unnecessary_import, non_constant_identifier_names, camel_case_types

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_coffee_v2/src/features/crud_product/presentation/update_product.dart';
import 'package:m_coffee_v2/src/features/profile/data/profile_repository.dart';
import 'package:m_coffee_v2/src/utils/api_client.dart';
import 'package:m_coffee_v2/src/utils/app_utils.dart';

class CardProduct extends StatefulWidget {
  final Products product;
  const CardProduct({super.key, required this.product});

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  @override
  Widget build(BuildContext context) {
    var widthSize = AppUtils.width(context);
    var wrapLines = 1;
    var flexImage = 0;
    var flexData = 0;
    var menuTextSize = 20;
    var imageHeigth = 150;
    if (widthSize < 310) {
      wrapLines = 2;
      flexImage = 2;
      flexData = 3;
      menuTextSize = 16;
      imageHeigth = 120;
    } else {
      flexImage = 1;
      flexData = 2;
    }

    final double priceAsInt = widget.product.price.toDouble();

    bool isDiscounted = false;
    int Discounted = widget.product.discount.toInt();
    double persen = Discounted / 100;
    if (Discounted >= 1) {
      isDiscounted = true;
    }
    double discountPrice = priceAsInt - (priceAsInt * persen);

    return Container(
      // width: 400,
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F5F9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 5,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: flexImage,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image(
                    image: FileImage(File(
                        "C:/Users/marce/OneDrive/Dokumen/assets/images/products/${widget.product.image.toString()}")),
                    width: MediaQuery.of(context).size.width,
                    height: imageHeigth.toDouble(),
                    fit: BoxFit.cover,
                  ),
                ),
                if (isDiscounted) discountBadge(widget: widget),
              ],
            ),
          ),
          Expanded(
            flex: flexData,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "| ${widget.product.category}",
                        style: const TextStyle(
                          color: Color(0xFFFC6011),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateProduct(data: widget.product),
                                ),
                              );
                            },
                            style: const ButtonStyle(
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.all(5)),
                              iconColor:
                                  MaterialStatePropertyAll(Color(0xFFFC6011)),
                              minimumSize:
                                  MaterialStatePropertyAll(Size(20, 20)),
                              iconSize: MaterialStatePropertyAll(20),
                            ),
                            child: const Icon(Icons.edit),
                          ),
                          TextButton(
                            onPressed: () async {
                              // Show confirmation dialog
                              bool confirmDelete = await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Konfirmasi Hapus'),
                                  content: Text(
                                      'Apakah Anda yakin ingin menghapus data ini?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: Text('Batal'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: Text('Hapus'),
                                    ),
                                  ],
                                ),
                              );
                              // Perform delete operation if confirmed
                              if (confirmDelete == true) {
                                await ApiClient.deleteData(
                                    widget.product.id.toString());
                                // Refresh data after deletion
                                setState(() {
                                  ProfileRepository.items =
                                      ApiClient.fetchProducts();
                                });
                              }
                            },
                            style: const ButtonStyle(
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.all(5)),
                              iconColor:
                                  MaterialStatePropertyAll(Color(0xFFFC6011)),
                              minimumSize:
                                  MaterialStatePropertyAll(Size(20, 20)),
                              iconSize: MaterialStatePropertyAll(20),
                            ),
                            child: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    widget.product.name.toString(),
                    style: TextStyle(
                      color: Color(0xFFFC6011),
                      fontSize: menuTextSize.toDouble(),
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: false,
                    maxLines: wrapLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (widthSize > 310)
                    Text(
                      widget.product.description.toString(),
                      style: const TextStyle(
                        color: Color(0xFFFC6011),
                        fontSize: 12,
                        fontWeight: FontWeight.w100,
                      ),
                      softWrap: false,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  isDiscounted
                      ? DiscountedPrice(
                          realPrice: AppUtils.formattedPrice(priceAsInt),
                          DiscountPrice:
                              AppUtils.formattedPrice(discountPrice.toDouble()),
                          discount: widget.product.discount.toInt(),
                        )
                      : NotDiscount(price: AppUtils.formattedPrice(priceAsInt)),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xFFFC6011),
                        size: 12,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        "${widget.product.rating.toString()} | ${widget.product.numOfSales.toString()} Terjual",
                        style: const TextStyle(
                            color: Color(0xFFFC6011),
                            fontSize: 12,
                            fontWeight: FontWeight.w100),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class discountBadge extends StatelessWidget {
  const discountBadge({
    super.key,
    required this.widget,
  });

  final CardProduct widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 5, // Atur posisi ikon favorit di bagian atas gambar
      left: 5, // Atur posisi ikon favorit di sebelah kiri gambar
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFFC6011),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          "${widget.product.discount.toInt()}%",
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class DiscountedPrice extends StatelessWidget {
  final String realPrice;
  final String DiscountPrice;
  final int discount;
  const DiscountedPrice({
    super.key,
    required this.realPrice,
    required this.DiscountPrice,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    var widthSize = AppUtils.width(context);
    var priceSize = 16;
    if (widthSize < 310) {
      priceSize = 12;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          Text(
            DiscountPrice,
            style: TextStyle(
              fontSize: priceSize.toDouble(),
              fontWeight: FontWeight.w700,
              color: Color(0xFFFC6011),
            ),
          ),
          if (widthSize > 310)
            const SizedBox(
              width: 4,
            ),
          if (widthSize > 310)
            Text(
              realPrice,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w100,
                color: Color(0xFFFC6011),
                decoration: TextDecoration.lineThrough,
                decorationColor: Color(0xFFFC6011),
              ),
            ),
        ],
      ),
    );
  }
}

class NotDiscount extends StatelessWidget {
  final String price;
  const NotDiscount({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        price,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Color(0xFFFC6011),
        ),
      ),
    );
  }
}
