import 'package:kozarni_ecome/model/product.dart';

class ViewAllModel {
  final String status;
  final List<Product> products;
  ViewAllModel({required this.status,required this.products});

  factory ViewAllModel.empty() => ViewAllModel(status: "", products: []);
}