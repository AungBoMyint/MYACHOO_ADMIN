import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/controller/upload_controller.dart';

class SizePriceItemWidget extends StatefulWidget {
  final String id;
  final String sizeText;
  final String price;
  const SizePriceItemWidget({
    Key? key,
    required this.id,
    required this.sizeText,
    required this.price,
  }) : super(key: key);

  @override
  State<SizePriceItemWidget> createState() => _SizePriceItemWidgetState();
}

class _SizePriceItemWidgetState extends State<SizePriceItemWidget> {
  TextEditingController _textController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  @override
  void initState() {
    _textController.text = widget.sizeText.isNotEmpty ? widget.sizeText : "";
    _priceController.text = widget.price.isNotEmpty ? widget.price : "0";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UploadController controller = Get.find();
    return AnimatedContainer(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 500),
      padding: EdgeInsets.only(top: 5),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //SizeText
          Expanded(
            child: TextFormField(
              validator: controller.sizeValidator,
              controller: _textController,
              onChanged: (value) => controller.changeSizePriceText(
                value,
                widget.id,
              ),
              decoration: InputDecoration(
                hintText: 'အရွယ်အစား',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          //Space
          const SizedBox(width: 5),
          //Price
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.number,
              validator: controller.sizeValidator,
              controller: _priceController,
              onChanged: (value) => controller.changeSizePricePrice(
                value,
                widget.id,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                hintText: 'စျေးနှုန်း',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          //Delete Icon
          IconButton(
            onPressed: () => controller.deleteSizePrice(widget.id),
            icon: Icon(
              FontAwesomeIcons.trash,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
