import 'package:flutter/material.dart';
import 'package:kozarni_ecome/data/constant.dart';

import '../widgets/order/cash_on_delivery.dart';
import '../widgets/order/pre_pay.dart';

class UserOrderView extends StatelessWidget {
  const UserOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: const Center(child: Text("အော်ဒါများ",style: TextStyle(
            color: Colors.black,
          ))),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          bottom: TabBar(
              unselectedLabelColor: Colors.grey.shade400,
              labelColor: Colors.grey.shade700,
              tabs: [
                Tab(
                  child: Text(
                    "Cash On Deli",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Tab(
                  child: Text(
                    "Pre-Pay",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ]),
        ),
        body: TabBarView(children: [
          CashOnDelivery(),
          PrePay(),
        ]),
      ),
    );
  }
}
