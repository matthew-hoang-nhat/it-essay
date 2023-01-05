import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/address/cubit/address_cubit.dart';
import 'package:it_project/src/features/address/cubit/detail_address_cubit.dart';
import 'package:it_project/src/utils/remote/model/order/get/address.dart';
import 'package:it_project/src/utils/remote/model/order/get/district.dart';
import 'package:it_project/src/utils/remote/model/order/get/province.dart';
import 'package:it_project/src/utils/remote/model/order/get/ward.dart';
import 'package:it_project/src/widgets/load_widget.dart';
import 'package:it_project/src/widgets/me_text_field_v2.dart';

class DetailAddressScreen extends StatelessWidget {
  const DetailAddressScreen({super.key, required this.address});
  final Address address;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailAddressCubit(address: address)..initCubit(),
      child: Stack(
        children: [
          Scaffold(
              appBar: AppBar(
                title: const Text('Địa chỉ'),
                actions: [
                  saveNewAddressButton(
                      // nameController,
                      // phoneController,
                      // addressController,
                      )
                ],
              ),
              body: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        BlocBuilder<DetailAddressCubit, DetailAddressState>(
                          buildWhen: (previous, current) =>
                              previous.nameAnnouncement !=
                              current.nameAnnouncement,
                          builder: (context, state) {
                            return MeTextFieldV2(
                                text: 'Tên người nhận',
                                textEditingController: context
                                    .read<DetailAddressCubit>()
                                    .nameController,
                                announcement: state.nameAnnouncement,
                                onChanged: (value) {
                                  context.read<DetailAddressCubit>()
                                    ..setName(value)
                                    ..checkAll();
                                });
                          },
                        ),
                        BlocBuilder<DetailAddressCubit, DetailAddressState>(
                          buildWhen: (previous, current) =>
                              previous.phoneNumberAnnouncement !=
                              current.phoneNumberAnnouncement,
                          builder: (context, state) {
                            return MeTextFieldV2(
                                text: 'Số điện thoại',
                                textEditingController: context
                                    .read<DetailAddressCubit>()
                                    .phoneController,
                                announcement: state.phoneNumberAnnouncement,
                                onChanged: (value) {
                                  context.read<DetailAddressCubit>()
                                    ..setPhoneNumber(value)
                                    ..checkAll();
                                });
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
                                            .setDefault();
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
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.whiteColor),
                                            ),
                                          ],
                                        ))
                                    : const Text('Chọn làm mặc định'));
                          },
                        )
                      ],
                    ),
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
                  final province = value!;
                  context.read<DetailAddressCubit>().setProvince(province);
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
                  final district = value!;
                  context.read<DetailAddressCubit>().setDistrict(district);
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
                  final ward = value!;
                  context.read<DetailAddressCubit>().setWard(ward);
                },
              ),
            );
          },
        ),
        BlocBuilder<DetailAddressCubit, DetailAddressState>(
          builder: (context, state) {
            return MeTextFieldV2(
                textEditingController:
                    context.read<DetailAddressCubit>().streetController,
                announcement: state.streetAnnouncement,
                onChanged: (value) {
                  final street = value;
                  context.read<DetailAddressCubit>()
                    ..setStreet(street)
                    ..checkAll();
                });
          },
        )
      ],
    );
  }

  Widget saveNewAddressButton() {
    return BlocBuilder<DetailAddressCubit, DetailAddressState>(
      // buildWhen: (previous, current) =>
      //     previous.isAllValidated != current.isAllValidated,
      builder: (context, state) {
        return TextButton(
          onPressed: state.isAllValidated
              ? () async {
                  await context
                      .read<DetailAddressCubit>()
                      .callAPIUpdateAddress()
                      .then((value) async {
                    context
                        .read<AddressCubit>()
                        .getAddressesAndSetAddressAppCubit();
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
