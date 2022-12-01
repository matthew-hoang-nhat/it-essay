import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/address/cubit/address_cubit.dart';
import 'package:it_project/src/features/address/cubit/add_address_cubit.dart';
import 'package:it_project/src/utils/helpers/validate.dart';
import 'package:it_project/src/utils/remote/model/order/get/district.dart';
import 'package:it_project/src/utils/remote/model/order/get/province.dart';
import 'package:it_project/src/utils/remote/model/order/get/ward.dart';
import 'package:it_project/src/widgets/load_widget.dart';
import 'package:it_project/src/widgets/me_text_field.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    late final TextEditingController nameController = TextEditingController();
    late final TextEditingController addressController =
        TextEditingController();
    late final TextEditingController phoneController = TextEditingController();

    return BlocProvider(
      create: (context) => AddAddressCubit()..initCubit(),
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
                  child: BlocBuilder<AddAddressCubit, AddAddressState>(
                    buildWhen: (previous, current) => false,
                    builder: (context, state) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            MeTextField(
                              text: 'Tên người nhận',
                              textEditingController: nameController,
                              functionValidation: (value) {
                                if (value.isNotEmpty &&
                                    Validate().isInvalidName(value)) {
                                  return 'Tên không được chứa số và kí tự đặt biệt';
                                }
                                return null;
                              },
                              callFuncOnChange: () {
                                context.read<AddAddressCubit>().addNewEvent(
                                    AddAddressEnum.name, nameController.text);
                                context.read<AddAddressCubit>().checkAll();
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
                                context.read<AddAddressCubit>().addNewEvent(
                                    AddAddressEnum.phoneNumber,
                                    phoneController.text);
                                context.read<AddAddressCubit>().checkAll();
                              },
                            ),
                            addressComponent(context),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )),
          BlocBuilder<AddAddressCubit, AddAddressState>(
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
        text: context.read<AddAddressCubit>().state.street);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tỉnh thành phố',
          style: GoogleFonts.nunito(color: AppColors.greyColor),
        ),
        BlocBuilder<AddAddressCubit, AddAddressState>(
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
                      .read<AddAddressCubit>()
                      .addNewEvent(AddAddressEnum.province, value);
                  context.read<AddAddressCubit>().checkAll();
                },
              ),
            );
          },
        ),
        Text(
          'Quận/Huyện',
          style: GoogleFonts.nunito(color: AppColors.greyColor),
        ),
        BlocBuilder<AddAddressCubit, AddAddressState>(
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
                      .read<AddAddressCubit>()
                      .addNewEvent(AddAddressEnum.district, value);
                  context.read<AddAddressCubit>().checkAll();
                },
              ),
            );
          },
        ),
        Text(
          'Phường/Xã',
          style: GoogleFonts.nunito(color: AppColors.greyColor),
        ),
        BlocBuilder<AddAddressCubit, AddAddressState>(
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
                      .read<AddAddressCubit>()
                      .addNewEvent(AddAddressEnum.ward, value);
                  context.read<AddAddressCubit>().checkAll();
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
                .read<AddAddressCubit>()
                .addNewEvent(AddAddressEnum.street, streetController.text);
            context.read<AddAddressCubit>().checkAll();
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
    return BlocBuilder<AddAddressCubit, AddAddressState>(
      buildWhen: (previous, current) =>
          previous.isAllValidated != current.isAllValidated,
      builder: (context, state) {
        return TextButton(
          onPressed: state.isAllValidated
              ? () async {
                  await context
                      .read<AddAddressCubit>()
                      .addNewAddress()
                      .then((value) async {
                    context.read<AddressCubit>().getAddresses();
                    context.pop();
                  });
                }
              : null,
          child: Text(
            'Thêm địa chỉ',
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
