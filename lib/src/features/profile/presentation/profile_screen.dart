import 'package:flutter/material.dart';
import 'package:m_coffee_v2/src/constants/app_constants.dart';
import 'package:m_coffee_v2/src/features/crud_product/presentation/create_product.dart';
import 'package:m_coffee_v2/src/features/profile/data/profile_repository.dart';
import 'package:m_coffee_v2/src/features/profile/presentation/widget/CardProduct.dart';
import 'package:m_coffee_v2/src/utils/api_client.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ProfileRepository.items = ApiClient.fetchProducts();
    ProfileRepository.filteredItems = [];
  }

  void filterSearchResults(String query) {
    ProfileRepository.items.then((value) {
      setState(() {
        ProfileRepository.filteredItems = value
            .where(
                (item) => item.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // var testingProduct = ApiClient.fetchProducts();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateProduct(),
                  ),
                );
              },
              icon: Icon(Icons.add)),
        ],
        backgroundColor: AppConstants.primaryColor,
      ),
      body: Container(
        margin: EdgeInsetsDirectional.only(top: 5),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
              Expanded(
                child: FutureBuilder<List<Products>>(
                  future: ProfileRepository.filteredItems.isNotEmpty
                      ? Future.value(ProfileRepository.filteredItems)
                      : ProfileRepository.items,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Error : ${snapshot.error}");
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) =>
                            CardProduct(product: snapshot.data![index]),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
