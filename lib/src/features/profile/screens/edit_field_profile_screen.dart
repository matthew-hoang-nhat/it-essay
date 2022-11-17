// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:it_project/src/configs/constants/app_colors.dart';
// import 'package:it_project/src/features/profile/widgets/me_edit_text_field.dart';

// enum EditFieldProfileEnum {
//   name,
//   phoneNumber,
//   email,
// }

// class EditFieldProfileScreen extends StatelessWidget {
//   const EditFieldProfileScreen({super.key, required this.type, this.content});
//   final EditFieldProfileEnum type;
//   final String? content;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.whiteGreyColor,
//       appBar: AppBar(
//         foregroundColor: AppColors.brownColor,
//         title: Text(
//           getTitle(),
//           style: GoogleFonts.nunito(color: AppColors.brownColor),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {},
//             style: ButtonStyle(
//               textStyle: MaterialStateTextStyle.resolveWith(
//                   (states) => GoogleFonts.nunito(color: AppColors.redColor)),
//               foregroundColor:
//                   MaterialStateProperty.all(AppColors.primaryColor),
//             ),
//             child: const Text(
//               'Lưu',
//             ),
//           )
//         ],
//       ),
//       body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         const SizedBox(height: 5),
//         meEditTextField(TextEditingController(text: content)),
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 10),
//           child: Text('Tối đa 100 ký tự'),
//         ),
//       ]),
//     );
//   }

//   String getTitle() {
//     switch (type) {
//       case EditFieldProfileEnum.name:
//         return 'Sửa tên';

//       case EditFieldProfileEnum.email:
//         return 'Sửa email';

//       case EditFieldProfileEnum.phoneNumber:
//         return 'Sửa số điện thoại';
//     }
//   }
// }
