// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/address/cubit/address_cubit.dart';
import 'package:it_project/src/features/app/cubit/app_cubit.dart';
import 'package:it_project/src/utils/remote/model/order/get/address.dart';
import 'package:it_project/src/widgets/load_widget.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({
    Key? key,
    this.isAllowChoose = false,
  }) : super(key: key);
  final bool? isAllowChoose;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
            appBar: AppBar(
              title: const Text('Địa chỉ'),
              actions: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        if (context
                                .read<AddressCubit>()
                                .state
                                .addresses
                                .length >
                            2) {
                          Fluttertoast.showToast(
                              msg: "Tối đa 3 địa chỉ",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          return;
                        }
                        context.push(Paths.addAddressScreen);
                      },
                      child: Text(
                        'Thêm địa chỉ',
                        style: GoogleFonts.nunito(color: AppColors.whiteColor),
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: SafeArea(
                child: Column(
              children: [
                BlocBuilder<AddressCubit, AddressState>(
                  bloc: context.read<AddressCubit>(),
                  buildWhen: (previous, current) =>
                      // previous.addressId != current.addressId ||
                      previous.addresses != current.addresses,
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView(
                        shrinkWrap: true,
                        children: state.addresses
                            .map((e) => _InlineAddress(
                                  address: e,
                                  isAllowChoose: isAllowChoose,
                                ))
                            .toList(),
                      ),
                    );
                  },
                ),
                BlocBuilder<AddressCubit, AddressState>(
                  buildWhen: (previous, current) =>
                      previous.isEmpty != current.isEmpty,
                  builder: (context, state) {
                    if (state.isEmpty) {
                      return Container(
                        height: 200,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              MaterialCommunityIcons.map_legend,
                              size: 100,
                              color: AppColors.primaryColor,
                            ),
                            Text(
                              'Chưa có địa chỉ...',
                              style: GoogleFonts.nunito(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Thêm địa chỉ để đặt hàng và tạo đơn hàng',
                              style: GoogleFonts.nunito(
                                  color: AppColors.greyColor, fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    }

                    return Container();
                  },
                )
              ],
            ))),
        BlocBuilder<AddressCubit, AddressState>(
          buildWhen: (previous, current) =>
              previous.isLoading != current.isLoading,
          builder: (context, state) {
            if (state.isLoading) return const LoadingWidget();
            return Container();
          },
        )
      ],
    );
  }
}

class _InlineAddress extends StatelessWidget {
  final Address address;
  final bool? isAllowChoose;

  const _InlineAddress({required this.address, required this.isAllowChoose});
  @override
  Widget build(BuildContext context) {
    final String addressId = address.id!;
    return Slidable(
        enabled: true,
        key: ValueKey(addressId),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              flex: 1,
              onPressed: (context) {
                context.read<AddressCubit>().deleteAddress(address.id!);
              },
              backgroundColor: AppColors.redColor,
              foregroundColor: Colors.white,
              icon: Icons.archive,
              label: 'Xóa',
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            context.push(Paths.detailAddressScreen, extra: address);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    isAllowChoose == true
                        ? BlocBuilder<AddressCubit, AddressState>(
                            builder: (context, state) {
                              return Radio<String?>(
                                  value: addressId,
                                  groupValue: state.addressId,
                                  onChanged: (value) {
                                    context
                                        .read<AddressCubit>()
                                        .setAddressId(value);
                                    context
                                        .read<AppCubit>()
                                        .changeSelectAddress(address);
                                  });
                            },
                          )
                        : Container(),
                    const Icon(
                      MaterialCommunityIcons.google_maps,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(
                        width: 100,
                        child: Text(
                          address.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                    const SizedBox(width: 10),
                    Text(address.phoneNumber),
                    const SizedBox(width: 10),
                    if (address.isDefault)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                        ),
                        child: Text(
                          'Mặc định',
                          style:
                              GoogleFonts.nunito(color: AppColors.whiteColor),
                        ),
                      ),
                    const Spacer(),
                    Icon(
                      MaterialCommunityIcons.chevron_right,
                      color: AppColors.greyColor,
                    ),
                  ],
                ),
                Text(address.address),
              ],
            ),
          ),
        ));
  }
}
