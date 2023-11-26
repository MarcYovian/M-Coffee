// ignore_for_file: unnecessary_import, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_coffee_v2/src/constants/app_constants.dart';
import 'package:m_coffee_v2/src/features/cart/data/cart_repository.dart';
import 'package:m_coffee_v2/src/features/detail_product/presentation/detail_view.dart';
import 'package:m_coffee_v2/src/features/product/domain/model/product.dart';
import 'package:m_coffee_v2/src/utils/app_utils.dart';
import 'package:provider/provider.dart';

class VerticalCardMenu extends StatefulWidget {
  final Product product;
  const VerticalCardMenu({super.key, required this.product});

  @override
  State<VerticalCardMenu> createState() => _VerticalCardMenuState();
}

class _VerticalCardMenuState extends State<VerticalCardMenu> {
  @override
  Widget build(BuildContext context) {
    final productState = Provider.of<CartRepository>(context, listen: false);
    final double priceAsInt = widget.product.price?.toDouble() ?? 0;
    // print(priceAsInt);

    bool isDiscounted = false;
    int Discounted = widget.product.discount?.toInt() ?? 0;
    double persen = Discounted / 100;
    if (Discounted >= 1) {
      isDiscounted = true;
    }
    double discountPrice = priceAsInt - (priceAsInt * persen);
    // print("harga real     : ${priceAsInt}");
    // print("harga Discount : ${discountPrice}");

    return Container(
      width: 160,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailView(product: widget.product),
            ),
          );
        },
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage(
                          "assets/images/products/${widget.product.image.toString()}"),
                      width: MediaQuery.of(context).size.width,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 5, // Atur posisi ikon favorit di bagian atas gambar
                    left: 5, // Atur posisi ikon favorit di sebelah kiri gambar
                    child: TextButton(
                      onPressed: () {},
                      style: const ButtonStyle(
                        iconColor:
                            MaterialStatePropertyAll(AppConstants.primaryColor),
                        minimumSize: MaterialStatePropertyAll(Size(25, 25)),
                        iconSize: MaterialStatePropertyAll(25),
                      ),
                      child: const Icon(Icons.favorite_border),
                    ),
                  ),
                ],
              ),
              Text(
                widget.product.name.toString(),
                style: const TextStyle(
                  color: Color(0xFFFC6011),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                softWrap: false,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isDiscounted
                      ? DiscountedPrice(
                          realPrice: AppUtils.formattedPrice(priceAsInt),
                          DiscountPrice:
                              AppUtils.formattedPrice(discountPrice.toDouble()),
                          discount: widget.product.discount!.toInt())
                      : NotDiscount(price: AppUtils.formattedPrice(priceAsInt)),
                  Container(
                    height: 25,
                    child: TextButton(
                      onPressed: () {
                        productState.addToCart(widget.product);
                      },
                      style: ButtonStyle(
                        iconColor:
                            MaterialStatePropertyAll(AppConstants.primaryText),
                        iconSize: MaterialStatePropertyAll(15),
                        minimumSize: MaterialStatePropertyAll(Size(15, 15)),
                        backgroundColor:
                            MaterialStatePropertyAll(AppConstants.primaryColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.red))),
                      ),
                      child: const Icon(
                        Icons.add,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
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
              )
            ],
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
  const DiscountedPrice(
      {super.key,
      required this.realPrice,
      required this.DiscountPrice,
      required this.discount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DiscountPrice,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFC6011),
                ),
              ),
              Row(
                children: [
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
                  Text(
                    " $discount%",
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ],
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            price,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFC6011),
            ),
          ),
          Container(
            height: 30,
            child: TextButton(
              onPressed: () {},
              style: const ButtonStyle(
                iconColor: MaterialStatePropertyAll(Color(0xFFF0F5F9)),
                iconSize: MaterialStatePropertyAll(15),
                minimumSize: MaterialStatePropertyAll(Size(10, 10)),
                backgroundColor: MaterialStatePropertyAll(Color(0xFFFC6011)),
              ),
              child: const Icon(
                Icons.add,
                // size: 15,
              ),
            ),
          )
        ],
      ),
    );
  }
}
