import 'package:flutter/material.dart';
import 'package:test15_shop_2/card_page.dart';
import 'package:test15_shop_2/details_page.dart';

class Product {
  final String name;
  final String price;
  final String imagePath;
  final Color bgColor;
  final String brand;

  Product({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.bgColor,
    required this.brand,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  final List<String> _filters = ['All', 'Addidas', 'Nike', 'Bata'];
  int _selectedFilter = 0;

  final List<Product> _products = [
    Product(
      name: 'Men\'s Nike Shoes',
      price: '\$44.52',
      imagePath: 'assets/images/naiki.jpg',
      bgColor: const Color(0xFFE7F3FF),
      brand: 'Nike',
    ),
    Product(
      name: 'Addidas Shoes',
      price: '\$20.12',
      imagePath: 'assets/images/addason.jpg',
      bgColor: const Color(0xFFF2F2F2),
      brand: 'Addidas',
    ),
    Product(
      name: 'Bata Shoes',
      price: '\$25.12',
      imagePath: 'assets/images/bata.jpg',
      bgColor: const Color(0xFFF2F2F2),
      brand: 'Bata',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<Product> displayedProducts;
    if (_selectedFilter == 0) {
      displayedProducts = _products;
    } else {
      displayedProducts = _products
          .where((product) => product.brand == _filters[_selectedFilter])
          .toList();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Shoes\nCollection',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filters.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedFilter = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        margin: const EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          color: _selectedFilter == index
                              ? Colors.yellow[700]
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          _filters[index],
                          style: TextStyle(
                            color: _selectedFilter == index ? Colors.black : Colors.grey[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.separated(
                  itemCount: displayedProducts.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final product = displayedProducts[index];
                    return _buildProductCard(
                      product.name,
                      product.price,
                      product.imagePath,
                      product.bgColor,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
          if (index == 1) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CartPage()));
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: '',
          ),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.yellow[700],
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }

  Widget _buildProductCard(String name, String price, String imagePath, Color bgColor) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsPage(
          name: name,
          price: price,
          imagePath: imagePath,
        )));
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              price,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Image.asset(
                imagePath,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
