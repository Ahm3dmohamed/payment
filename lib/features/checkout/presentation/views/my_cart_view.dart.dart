import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/core/utils/resources/color_manager.dart';
import 'package:payment/core/utils/resources/values_manager.dart';
import 'package:payment/core/widgets/build_appbar.dart';
import 'package:payment/core/widgets/checkout_button.dart';
import 'package:payment/features/checkout/data/repos/checkout_repo.dart';
import 'package:payment/features/checkout/data/repos/checkout_repo_impl.dart';
import 'package:payment/features/checkout/presentation/manager/cubit/payment_cubit_cubit.dart';
import 'package:payment/features/checkout/presentation/views/payment_details_view.dart';
import 'package:payment/features/checkout/widgets/payment_methods_bootomsheet.dart';
import 'package:payment/features/checkout/widgets/payment_methods_listview.dart';
import 'package:payment/features/checkout/widgets/product_image.dart';
import 'package:payment/features/checkout/widgets/product_info.dart';
import 'package:payment/features/checkout/widgets/quantity_control.dart';

class MyCartView extends StatefulWidget {
  const MyCartView({super.key});

  @override
  State<MyCartView> createState() => _MyCartViewState();
}

class _MyCartViewState extends State<MyCartView> {
  int _quantity = 0;
  final double _price = 100;

  void _updateQuantity(int change) {
    setState(() {
      _quantity = (_quantity + change).clamp(0, 999);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double total = _price * _quantity;
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: BuildAppBar(title: "My Cart"),
      body: Column(
        children: [
          ProductImage(size: size),
          ProductInfo(price: _price, total: total),
          QuantityControls(
            quantity: _quantity,
            onIncrease: () => _updateQuantity(1),
            onDecrease: () => _updateQuantity(-1),
          ),

          const SizedBox(height: AppSize.s16),
          //  Add a button to checkout
          CheckoutButton(
            text: "Checkout",
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => const PaymentDetailsView(),
              //     ));

              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
                context: context,
                builder: (context) {
                  // return const PaymentMethodsBottomSheet();
                  return BlocProvider(
                    create: (context) => PaymentCubit(
                      CheckoutRepoImpl(),
                    ),
                    child: const PaymentMethodsBottomSheet(),
                  );
                },
              );
            },
            total: total,
          ),
        ],
      ),
    );
  }
}
