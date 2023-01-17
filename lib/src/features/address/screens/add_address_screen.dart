import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/address/cubit/address_cubit.dart';
import 'package:it_project/src/features/address/cubit/add_address_cubit.dart';
import 'package:it_project/src/utils/remote/model/order/get/district.dart';
import 'package:it_project/src/utils/remote/model/order/get/province.dart';
import 'package:it_project/src/utils/remote/model/order/get/ward.dart';
import 'package:it_project/src/widgets/load_widget.dart';
import 'package:it_project/src/widgets/me_text_field_v2.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddAddressCubit()..initCubit(),
      child: Stack(
        children: [
          Scaffold(
              appBar: AppBar(
                title: const Text('Địa chỉ'),
                actions: [saveNewAddressButton()],
              ),
              body: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          BlocBuilder<AddAddressCubit, AddAddressState>(
                            buildWhen: (previous, current) =>
                                previous.nameAnnouncement !=
                                current.nameAnnouncement,
                            builder: (context, state) {
                              return MeTextFieldV2(
                                  text: 'Tên người nhận',
                                  textEditingController: context
                                      .read<AddAddressCubit>()
                                      .nameController,
                                  announcement: state.nameAnnouncement,
                                  onChanged: (value) {
                                    context.read<AddAddressCubit>()
                                      ..setName(value)
                                      ..checkAll();
                                  });
                            },
                          ),
                          const SizedBox(height: 10),
                          BlocBuilder<AddAddressCubit, AddAddressState>(
                            buildWhen: (previous, current) =>
                                previous.phoneNumberAnnouncement !=
                                current.phoneNumberAnnouncement,
                            builder: (context, state) {
                              return MeTextFieldV2(
                                  text: 'Số điện thoại',
                                  textEditingController: context
                                      .read<AddAddressCubit>()
                                      .phoneController,
                                  announcement: state.phoneNumberAnnouncement,
                                  onChanged: (value) {
                                    context.read<AddAddressCubit>()
                                      ..setPhoneNumber(value)
                                      ..checkAll();
                                  });
                            },
                          ),
                          const SizedBox(height: 10),
                          addressComponent(context),
                        ],
                      ),
                    )),
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
                  final province = value!;
                  context.read<AddAddressCubit>()
                    ..setProvince(province)
                    ..checkAll();
                },
              ),
            );
          },
        ),
        const SizedBox(height: 10),
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
                  final district = value!;
                  context.read<AddAddressCubit>()
                    ..setDistrict(district)
                    ..checkAll();
                },
              ),
            );
          },
        ),
        const SizedBox(height: 10),
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
                  final ward = value!;
                  context.read<AddAddressCubit>()
                    ..setWard(ward)
                    ..checkAll();
                },
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        BlocBuilder<AddAddressCubit, AddAddressState>(
          builder: (context, state) {
            return MeTextFieldV2(
                text: 'Địa chỉ cụ thể',
                textEditingController:
                    context.read<AddAddressCubit>().addressController,
                announcement: '',
                onChanged: (value) {
                  context.read<AddAddressCubit>()
                    ..setStreet(value)
                    ..checkAll();
                });
          },
        ),
      ],
    );
  }

  Widget saveNewAddressButton() {
    return BlocBuilder<AddAddressCubit, AddAddressState>(
      buildWhen: (previous, current) =>
          previous.isAllValidated != current.isAllValidated,
      builder: (context, state) {
        return TextButton(
          onPressed: state.isAllValidated
              ? () async {
                  await context
                      .read<AddAddressCubit>()
                      .callAPIAddNewAddress()
                      .then((value) async {
                    context
                        .read<AddressCubit>()
                        .getAddressesAndSetAddressAppCubit();
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
