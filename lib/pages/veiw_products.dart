import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class ViewProducts extends StatefulWidget {
  final String token;

  const ViewProducts({required this.token, super.key});

  @override
  _ViewProductsState createState() => _ViewProductsState();
}

class _ViewProductsState extends State<ViewProducts> {
  List<dynamic> _products = [];
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      Map<String, dynamic> payload = JwtDecoder.decode(widget.token);
      List<dynamic> farmIdList = payload['farmId'];
      print(payload);

      if (farmIdList.isEmpty) {
        throw Exception('Farm ID not found in token');
      }

      String farmId = farmIdList[0].toString();
      final response = await http.get(
        Uri.parse('http://192.168.29.99:7777/product/$farmId/products'),
        headers: {
          'Authorization': 'Bearer ${widget.token}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          _products = data;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _hasError = true;
          _errorMessage = 'Error: ${response.statusCode} ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = 'Error: $e';
      });
    }
  }

  Future<void> _deleteProduct(String productId) async {
    try {
      final response = await http.delete(
        Uri.parse('http://192.168.29.99:7777/product/delete/$productId'),
        headers: {
          'Authorization': 'Bearer ${widget.token}',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _products.removeWhere((product) => product['_id'] == productId);
        });
      } else {
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('View Products'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasError
              ? Center(child: Text('Failed to load products: $_errorMessage'))
              : _products.isEmpty
                  ? const Center(child: Text('No products available'))
                  : ListView.builder(
                      itemCount: _products.length,
                      itemBuilder: (context, index) {
                        final product = _products[index];
                        final productName = product['productName'] ?? 'Unknown Product';
                        final price = product['price']?.toString() ?? '0.00';
                        final imageName = product['image'] ?? '';

                        return ListTile(
                          title: Text(productName),
                          subtitle: Text('Price: ₹$price'),
                          leading: imageName.isNotEmpty
                              ? Image.network(
                                  'http://192.168.29.99:7777/product/uploads/$imageName',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )
                              : null,
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              await _deleteProduct(product['_id']);
                            },
                          ),
                        );
                      },
                    ),
    );
  }
}
