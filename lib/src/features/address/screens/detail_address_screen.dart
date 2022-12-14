import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/address/cubit/address_cubit.dart';
import 'package:it_project/src/features/address/cubit/detail_address_cubit.dart';
import 'package:it_project/src/utils/helpers/validate.dart';
import 'package:it_project/src/utils/remote/model/order/get/address.dart';
import 'package:it_project/src/utils/remote/model/order/get/district.dart';
import 'package:it_project/src/utils/remote/model/order/get/province.dart';
import 'package:it_project/src/utils/remote/model/order/get/ward.dart';
import 'package:it_project/src/widgets/load_widget.dart';
import 'package:it_project/src/widgets/me_text_field.dart';

class DetailAddressScreen extends StatelessWidget {
  const DetailAddressScreen({super.key, required this.address});
  final Address address;

  @override
  Widget build(BuildContext context) {
    late final TextEditingController nameController =
        TextEditingController(text: address.name);
    late final TextEditingController addressController =
        TextEditingController(text: address.addressCode!.street);
    late final TextEditingController phoneController =
        TextEditingController(text: address.phoneNumber);

    return BlocProvider(
      create: (context) => DetailAddressCubit(address: address)..initCubit(),
      child: Stack(
        children: [
          Scaffold(
              appBar: AppBar(
                title: const Text('Địa chỉ'),
                actions: [
                  saveNewAddressButton(
                    nameController,
                    phoneController,
                    addressController,
                  )
                ],
              ),
              body: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: BlocBuilder<DetailAddressCubit, DetailAddressState>(
                    buildWhen: (previous, current) => false,
                    builder: (context, state) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            MeTextField(
                              text: 'Tên người nhận',
                              textEditingController: nameController,
                              functionValidation: (value) => null,
                              callFuncOnChange: () {
                                context.read<DetailAddressCubit>().addNewEvent(
                                    DetailAddressEnum.name,
                                    nameController.text);
                              },
                            ),
                            MeTextField(
                              text: 'Số điện thoại',
                              textEditingController: phoneController,
                              functionValidation: (value) {
                                if (value.isEmpty) return null;
                                if (Validate().isInvalidPhoneNumber(value)) {
                                  return 'Số điện thoại bao gồm 10 chữ số';
                                }
                                return null;
                              },
                              callFuncOnChange: () {
                                context.read<DetailAddressCubit>().addNewEvent(
                                    DetailAddressEnum.phoneNumber,
                                    phoneController.text);
                              },
                            ),
                            addressComponent(context),
                            BlocBuilder<DetailAddressCubit, DetailAddressState>(
                              buildWhen: (previous, current) =>
                                  previous.isDefault != current.isDefault,
                              builder: (context, state) {
                                return TextButton(
                                    onPressed: state.isDefault
                                        ? null
                                        : () {
                                            context
                                                .read<DetailAddressCubit>()
                                                .addNewEvent(
                                                    DetailAddressEnum.isDefault,
                                                    true);
                                          },
                                    child: state.isDefault
                                        ? Container(
                                            padding: const EdgeInsets.all(10),
                                            color: AppColors.primaryColor,
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Mặc định',
                                                  style: GoogleFonts.nunito(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          AppColors.whiteColor),
                                                ),
                                              ],
                                            ))
                                        : const Text('Chọn làm mặc định'));
                              },
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )),
          BlocBuilder<DetailAddressCubit, DetailAddressState>(
            buildWhen: (previous, current) =>
                previous.isLoading != current.isLoading,
            builder: (context, state) {
              if (state.isLoading) return const LoadingWidget();
              return Container();
            },
          )
        ],
      ),
    );
  }

  Column addressComponent(BuildContext context) {
    TextEditingController streetController = TextEditingController(
        text: context.read<DetailAddressCubit>().state.street);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tỉnh thành phố',
          style: GoogleFonts.nunito(color: AppColors.greyColor),
        ),
        BlocBuilder<DetailAddressCubit, DetailAddressState>(
          buildWhen: (previous, current) =>
              previous.provinces != current.provinces ||
              previous.province != current.province,
          builder: (context, state) {
            return SizedBox(
              width: 300,
              height: 50,
              child: DropdownButton<Province>(
                isExpanded: true,
                items: state.provinces
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.name),
                        ))
                    .toList(),
                value: state.province,
                onChanged: (value) {
                  context
                      .read<DetailAddressCubit>()
                      .addNewEvent(DetailAddressEnum.province, value);
                },
              ),
            );
          },
        ),
        Text(
          'Quận/Huyện',
          style: GoogleFonts.nunito(color: AppColors.greyColor),
        ),
        BlocBuilder<DetailAddressCubit, DetailAddressState>(
          buildWhen: (previous, current) =>
              previous.districts != current.districts ||
              previous.district != current.district,
          builder: (context, state) {
            return SizedBox(
              width: 300,
              height: 50,
              child: DropdownButton<District>(
                isExpanded: true,
                items: state.districts
                    ?.map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.name),
                        ))
                    .toList(),
                value: state.district,
                onChanged: (value) {
                  context
                      .read<DetailAddressCubit>()
                      .addNewEvent(DetailAddressEnum.district, value);
                },
              ),
            );
          },
        ),
        Text(
          'Phường/Xã',
          style: GoogleFonts.nunito(color: AppColors.greyColor),
        ),
        BlocBuilder<DetailAddressCubit, DetailAddressState>(
          buildWhen: (previous, current) =>
              previous.wards != current.wards || previous.ward != current.ward,
          builder: (context, state) {
            return SizedBox(
              width: 300,
              height: 50,
              child: DropdownButton<Ward>(
                isExpanded: true,
                items: state.wards
                    ?.map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.name),
                        ))
                    .toList(),
                value: state.ward,
                onChanged: (value) {
                  context
                      .read<DetailAddressCubit>()
                      .addNewEvent(DetailAddressEnum.ward, value);
                },
              ),
            );
          },
        ),
        MeTextField(
          text: 'Địa chỉ cụ thể',
          textEditingController: streetController,
          callFuncOnChange: () {
            context
                .read<DetailAddressCubit>()
                .addNewEvent(DetailAddressEnum.street, streetController.text);
          },
          functionValidation: (value) => null,
        ),
      ],
    );
  }

  Widget saveNewAddressButton(
      TextEditingController nameController,
      TextEditingController phoneController,
      TextEditingController streetController) {
    return BlocBuilder<DetailAddressCubit, DetailAddressState>(
      // buildWhen: (previous, current) =>
      //     previous.isAllValidated != current.isAllValidated,
      builder: (context, state) {
        return TextButton(
          onPressed: state.isAllValidated
              ? () async {
                  await context
                      .read<DetailAddressCubit>()
                      .updateAddress()
                      .then((value) async {
                    context.read<AddressCubit>().getAddresses();
                    context.pop();
                  });
                }
              : null,
          child: Text(
            'Cập nhật',
            style: GoogleFonts.nunito(
              color: state.isAllValidated
                  ? AppColors.whiteColor
                  : AppColors.greyColor,
            ),
          ),
        );
      },
    );
  }
}
