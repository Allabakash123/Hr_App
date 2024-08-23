// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:school/utils/constants/colors.dart';

// import '../../common/widgets/loaders/animation_loader.dart';
// import '../helpers/helper_function.dart';


// class TFullScreenLoader{
//   static void openLoadingDialog(String text,String image){
//     showDialog(
//       context: Get.overlayContext!,
//       barrierDismissible: false,
//      builder: (_)=>PopScope(
//       canPop: false,
//       child:Container(
//         color: THelperFunctions.isDarkMode(Get.context!)?TColors.dark:TColors.white,
//         width: double.infinity,
//         height: double.infinity,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(height: 250,),
//               TAnimationLoaderWidget(text:text,image: image,),
//             ]
//           ),
//         ),
//       )
//      )
//     );
//   }


//   static stopLoading(){
//     Navigator.of(Get.overlayContext!).pop();
//   }
//  } 


// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:t_store/utils/constants/colors.dart';
// // import 'package:t_store/utils/helpers/helper_function.dart';
// // import '../../common/widgets/loaders/animation_loader.dart';

// // class TFullScreenLoader {
// //   static void openLoadingDialog(String text, String docerAnimation,) {
// //     showDialog(
// //       context: Get.overlayContext!,
// //       barrierDismissible: false,
// //       builder: (_) => SafeArea(
// //         child: Scaffold(
// //           backgroundColor: THelperFunctions.isDarkMode(Get.context!)
// //               ? TColors.dark
// //               : TColors.white,
// //           body: SingleChildScrollView(
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 TAnimationLoaderWidget(text: text, image: '',),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   static stopLoading() {
// //     Navigator.of(Get.overlayContext!).pop();
// //   }
// // }
