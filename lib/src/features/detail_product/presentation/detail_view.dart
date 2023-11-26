// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:m_coffee_v2/src/constants/app_constants.dart';
import 'package:m_coffee_v2/src/features/product/domain/model/product.dart';

class DetailView extends StatefulWidget {
  final Product product;
  const DetailView({super.key, required this.product});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  int sum = 0;
  void _add() {
    setState(() {
      sum++;
    });
  }

  void _less() {
    if (sum > 0) {
      setState(() {
        sum--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double priceAsInt = widget.product.price?.toDouble() ?? 0;
    // print(priceAsInt);

    bool isDiscounted = false;
    int Discounted = widget.product.discount?.toInt() ?? 0;
    double persen = Discounted / 100;
    if (Discounted >= 1) {
      isDiscounted = true;
    }
    double discountPrice = priceAsInt - (priceAsInt * persen);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  // borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: AssetImage(
                        "assets/images/products/${widget.product.image.toString()}"),
                    width: MediaQuery.of(context).size.width,
                    height: 280,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Positioned(
                  width: MediaQuery.of(context).size.width,
                  top: 5,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: const ButtonStyle(
                            iconColor:
                                MaterialStatePropertyAll(Color(0xFFFC6011)),
                            minimumSize: MaterialStatePropertyAll(Size(30, 30)),
                            iconSize: MaterialStatePropertyAll(30),
                          ),
                          child: const Icon(CupertinoIcons.back),
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {},
                              style: const ButtonStyle(
                                iconColor:
                                    MaterialStatePropertyAll(Color(0xFFFC6011)),
                                minimumSize:
                                    MaterialStatePropertyAll(Size(30, 30)),
                                iconSize: MaterialStatePropertyAll(30),
                              ),
                              child: const Icon(Icons.favorite_border),
                            ),
                            TextButton(
                              onPressed: () {},
                              style: const ButtonStyle(
                                iconColor:
                                    MaterialStatePropertyAll(Color(0xFFFC6011)),
                                minimumSize:
                                    MaterialStatePropertyAll(Size(30, 30)),
                                iconSize: MaterialStatePropertyAll(30),
                              ),
                              child: const Icon(CupertinoIcons.cart),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (isDiscounted) DiscountedBadge(widget: widget),
                Positioned(
                  bottom: 5,
                  left: 5,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F5F9),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFFFC6011),
                          size: 12,
                        ),
                        Text(
                          " ${widget.product.rating!.toString()} | ${widget.product.numOfSales!.toString()} Terjual",
                          style: const TextStyle(
                            color: Color(0xFFFC6011),
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                "| ${widget.product.category.toString()}",
                style: const TextStyle(
                  color: Color(0xFFFC6011),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                softWrap: false,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                widget.product.name.toString(),
                style: const TextStyle(
                  color: Color(0xFFFC6011),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                softWrap: false,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                widget.product.description!.data.toString(),
                style: const TextStyle(
                  color: Color(0xFF52616B),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                softWrap: true,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Size",
                style: TextStyle(
                  color: Color(0xFFFC6011),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                softWrap: true,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: SizeProducts(),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Quantity",
                style: TextStyle(
                  color: Color(0xFFFC6011),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                softWrap: true,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          blurRadius: 1.5,
                          offset: Offset(0, 0),
                        )
                      ],
                    ),
                    child: TextButton(
                      onPressed: _less,
                      style: ButtonStyle(
                        iconColor:
                            MaterialStatePropertyAll(AppConstants.primaryColor),
                        iconSize: MaterialStatePropertyAll(20),
                        minimumSize: MaterialStatePropertyAll(Size(10, 10)),
                        backgroundColor:
                            MaterialStatePropertyAll(AppConstants.primaryText),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side:
                                  BorderSide(color: AppConstants.primaryText)),
                        ),
                      ),
                      child: const Icon(
                        Icons.remove,
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xFFFC6011),
                    ),
                    child: Center(
                      child: Text(
                        '$sum',
                        style: const TextStyle(
                          color: Color(0xFFF0F5F9),
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          blurRadius: 1.5,
                          offset: Offset(0, 0),
                        )
                      ],
                    ),
                    child: TextButton(
                      onPressed: _add,
                      style: ButtonStyle(
                        iconColor:
                            MaterialStatePropertyAll(AppConstants.primaryText),
                        iconSize: MaterialStatePropertyAll(20),
                        minimumSize: MaterialStatePropertyAll(Size(10, 10)),
                        backgroundColor:
                            MaterialStatePropertyAll(AppConstants.primaryColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side:
                                  BorderSide(color: AppConstants.primaryColor)),
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 100,
        color: const Color(0xFFF0F5F9),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isDiscounted
                  ? GrandPriceDiscounted(
                      realPrice: priceAsInt,
                      discountPrice: discountPrice,
                      sum: sum)
                  : GrandPrice(Price: priceAsInt, sum: sum),
              ElevatedButton(
                onPressed: () {
                  // Add to Cart logic
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0xFFFC6011)),
                ),
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(
                    color: Color(0xFFF0F5F9),
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GrandPrice extends StatelessWidget {
  final double Price;
  final int sum;
  const GrandPrice({super.key, required this.Price, required this.sum});

  @override
  Widget build(BuildContext context) {
    String formattedPrice(double Price) {
      final NumberFormat currencyFormat =
          NumberFormat.currency(locale: "id", symbol: "Rp", decimalDigits: 0);
      return currencyFormat.format(Price);
    }

    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Total Harga",
            style: TextStyle(
              color: Color(0xFF52616B),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            " ${formattedPrice(Price * sum)}",
            style: const TextStyle(
              color: Color(0xFFFC6011),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class GrandPriceDiscounted extends StatelessWidget {
  const GrandPriceDiscounted({
    super.key,
    required this.realPrice,
    required this.discountPrice,
    required this.sum,
  });

  final double realPrice;
  final double discountPrice;
  final int sum;

  @override
  Widget build(BuildContext context) {
    String formattedPrice(double Price) {
      final NumberFormat currencyFormat =
          NumberFormat.currency(locale: "id", symbol: "Rp", decimalDigits: 0);
      return currencyFormat.format(Price);
    }

    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Total Harga",
            style: TextStyle(
              color: Color(0xFF52616B),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                " ${formattedPrice(discountPrice * sum)}",
                style: const TextStyle(
                  color: Color(0xFFFC6011),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (sum > 0)
                Text(
                  " ${formattedPrice(realPrice * sum)}",
                  style: const TextStyle(
                    color: Color(0xFFFC6011),
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Color(0xFFFC6011),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class DiscountedBadge extends StatelessWidget {
  const DiscountedBadge({
    super.key,
    required this.widget,
  });

  final DetailView widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 5,
      right: 5,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F5F9),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          '${widget.product.discount!.toInt()}% Off',
          style: const TextStyle(
            color: Colors.red,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class SizeProducts extends StatefulWidget {
  const SizeProducts({super.key});

  @override
  State<SizeProducts> createState() => _SizeProductsState();
}

class _SizeProductsState extends State<SizeProducts> {
  int activeCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<String> sizeProducts = <String>[
      "Small",
      "Medium",
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ListView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: sizeProducts.length,
          itemBuilder: (context, index) => BtnSize(
            value: sizeProducts[index],
            isActive: index == activeCategoryIndex,
            onCategorySelected: (isActive) {
              setState(() {
                if (isActive) {
                  activeCategoryIndex = index;
                } else {
                  activeCategoryIndex = -1;
                }
              });
            },
          ),
        ),
      ],
    );
  }
}

class BtnSize extends StatefulWidget {
  final bool isActive;
  final String value;
  final Function(bool) onCategorySelected;

  const BtnSize({
    super.key,
    required this.isActive,
    required this.value,
    required this.onCategorySelected,
  });

  @override
  State<BtnSize> createState() => _BtnSizeState();
}

class _BtnSizeState extends State<BtnSize> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        onPressed: () {
          widget.onCategorySelected(!widget.isActive);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.isActive
              ? const Color(0xFFFC6011)
              : const Color(0xFFF0F5F9),
        ),
        child: Text(
          widget.value,
          style: TextStyle(
            color: widget.isActive
                ? const Color(0xFFF0F5F9)
                : const Color(0xFFFC6011),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
