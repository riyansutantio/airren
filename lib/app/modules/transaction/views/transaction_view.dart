// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hexcolor/hexcolor.dart';

// import '../../../utils/utils.dart';
// import '../../../widgets/loginTextFormFieldBase.dart';
// import '../../error_handling/views/error_handling_view.dart';
// import '../controllers/transaction_controller.dart';
// import '../provider/transaction_provider.dart';


// class TransactionView extends GetView<TransactionController> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<TransactionController>(
//       init: TransactionController(p: TransactionProvider()),
//       builder: (controller) {
//         return Obx(() => Scaffold(
//               appBar:  PreferredSize(
//                       child: Container(
//                         padding: EdgeInsets.only(
//                             top: MediaQuery.of(context).padding.top),
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                               left: 5.0, top: 20.0, right: 10.0, bottom: 8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   IconButton(
//                                       onPressed: () => Get.back(),
//                                       icon: const Icon(EvaIcons.arrowBack),
//                                       color: Colors.white),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 20.0),
//                                     child: Text(
//                                       'Pelanggan',
//                                       style: GoogleFonts.montserrat(
//                                         color: Colors.white,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   GestureDetector(
//                                       onTap: () {
//                                         Get.to(ErrorHandlingView());
//                                       },
//                                       child: const Padding(
//                                         padding:  EdgeInsets.only(right: 8),
//                                         child:  Icon(EvaIcons.bellOutline,
//                                             color: Colors.white),
//                                       )),
                                  
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                             gradient: LinearGradient(colors: [
//                               HexColor('#5433FF'),
//                               HexColor('#0063F8')
//                             ]),
//                             boxShadow: const []),
//                       ),
//                       preferredSize: Size.fromHeight(Get.height * 0.1),
//                     ),
//               floatingActionButton: FloatingActionButton(
//                 onPressed: () {
//                   // Get.to(AddCustomer());
//                 },
//                 child: Icon(
//                   Icons.add,
//                   color: HexColor('#ffffff'),
//                 ),
//               ),
//               body: Container(
//                 child: Container(
//                   decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(40),
//                           topRight: Radius.circular(40)),
//                       color: Colors.white),
//                   child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: (controller.cusUserResult.isEmpty)
//                           ? noListCustomer()
//                           : ListView.builder(
//                               itemCount: controller.cusUserResult.length,
//                               itemBuilder: (context, index) {
//                                 var menu = controller.cusUserResult[index].obs;
//                                 return GestureDetector(
//                                   onTap: () {
//                                     controller.nameDetailController.text =
//                                         controller.cusUserResult[index].name!;
//                                     controller.phoneDetailNumberCusController
//                                             .text =
//                                         controller
//                                             .cusUserResult[index].phoneNumber!;
//                                     controller.addressDetailCusController.text =
//                                         controller
//                                             .cusUserResult[index].address!;
//                                     int v = controller.isRadio.value =
//                                         controller.cusUserResult[index].active!;
//                                     int v2 = controller.isRadio.value =
//                                         controller.cusUserResult[index].active!;
//                                     print(v);
//                                     controller.meterDetailCusController.text =
//                                         controller.cusUserResult[index].meter
//                                             .toString();
//                                     controller
//                                             .uniqueIdDetailCusController.text =
//                                         controller
//                                             .cusUserResult[index].uniqueId!;
//                                     Get.to(CustomerDetailView(
//                                       admin: 0,
//                                     ));
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         top: 8.0, left: 16.0, right: 16.0),
//                                     child: Container(
//                                       child: ListTile(
//                                           contentPadding:
//                                               const EdgeInsets.all(10),
//                                           dense: false,
//                                           title: Text(
//                                             controller.cusUserResult[index]
//                                                         .pamId
//                                                         .toString()
//                                                         .length <=
//                                                     9
//                                                 ? '${controller.cusUserResult[index].name}'
//                                                 : '${controller.cusUserResult[index].name!.substring(0, 9)}+..',
//                                             style: GoogleFonts.montserrat(
//                                               color: Colors.black,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                           subtitle: Padding(
//                                             padding:
//                                                 const EdgeInsets.only(top: 8.0),
//                                             child: Text(
//                                               controller.cusUserResult[index]
//                                                   .uniqueId!,
//                                               style: GoogleFonts.montserrat(
//                                                 color: HexColor('#707793'),
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.normal,
//                                               ),
//                                             ),
//                                           ),
//                                           leading: CircleAvatar(
//                                               maxRadius: 30,
//                                               backgroundColor: controller
//                                                           .cusUserResult[index]
//                                                           .active ==
//                                                       1
//                                                   ? HexColor('#05C270')
//                                                       .withOpacity(0.1)
//                                                   : HexColor('#FF3B3B')
//                                                       .withOpacity(0.1),
//                                               child: Text(
//                                                 controller.getInitials(
//                                                     controller
//                                                         .cusUserResult[index]
//                                                         .name!
//                                                         .toUpperCase()),
//                                                 style: GoogleFonts.montserrat(
//                                                   color: controller
//                                                               .cusUserResult[
//                                                                   index]
//                                                               .active ==
//                                                           1
//                                                       ? HexColor('#05C270')
//                                                       : HexColor('#FF3B3B'),
//                                                   fontSize: 14,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               )),
//                                           trailing: SizedBox(
//                                             width: 86,
//                                             height: 25,
//                                             child: Row(
//                                               children: [
//                                                 Icon(
//                                                   EvaIcons.compassOutline,
//                                                   color: HexColor('#0063F8'),
//                                                 ),
//                                                 const SizedBox(
//                                                   width: 6,
//                                                 ),
//                                                 Container(
//                                                   width: 24,
//                                                   child: Text(
//                                                     controller
//                                                                 .cusUserResult[
//                                                                     index]
//                                                                 .meter
//                                                                 .toString()
//                                                                 .length <=
//                                                             3
//                                                         ? controller
//                                                             .cusUserResult[
//                                                                 index]
//                                                             .meter
//                                                             .toString()
//                                                         : controller
//                                                                 .cusUserResult[
//                                                                     index]
//                                                                 .meter
//                                                                 .toString()
//                                                                 .substring(
//                                                                     0, 3) +
//                                                             '..',
//                                                     style:
//                                                         GoogleFonts.montserrat(
//                                                       color:
//                                                           HexColor('#707793'),
//                                                       fontSize: 14,
//                                                       fontWeight:
//                                                           FontWeight.normal,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 const Padding(
//                                                   padding: EdgeInsets.only(
//                                                       left: 8.0),
//                                                   child: Icon(
//                                                     Icons.arrow_forward,
//                                                     color: Colors.amber,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           )),
//                                       decoration: const BoxDecoration(
//                                           boxShadow: [
//                                             BoxShadow(
//                                               offset: Offset(0.0, 8.0),
//                                               color: Color.fromRGBO(
//                                                   0, 99, 248, 0.16),
//                                               blurRadius: 24,
//                                             ),
//                                           ],
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(16)),
//                                           color: Colors.white),
//                                     ),
//                                   ),
//                                 );
//                               })),
//                 ),
//                 decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                         colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
//               ),
//             ));
//       },
//     );
//   }

//   PreferredSize buildAppBarSearch(
//       BuildContext context, CustomerController controller) {
//     return PreferredSize(
//       child: Container(
//         padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//         child: Padding(
//           padding: const EdgeInsets.only(
//               left: 5.0, top: 20.0, right: 10.0, bottom: 8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   controller.isSearch.value = false;
//                   controller.searchValue.value = '';
//                 },
//                 child: const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Icon(
//                     Icons.arrow_back,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               Expanded(
//                   child: Container(
//                 child: AirenTextFormFieldBase(
//                   onSubmit: (val) {
//                     controller.searchController.clear();
//                     logger.i(val!);
//                     return null;
//                   },
//                   onChange: (val) {
//                     controller.searchValue.value = val!;
//                     return null;
//                   },
//                   suffixIcon: const Padding(
//                     padding: EdgeInsets.all(10.0),
//                     child: Icon(EvaIcons.search),
//                   ),
//                   textInputType: TextInputType.text,
//                   hintText: 'Cari..',
//                   obscureText: false,
//                   passwordVisibility: false,
//                   controller: controller,
//                   textEditingController: controller.searchController,
//                   returnValidation: (val) {
//                     if (val!.isEmpty) {
//                       return "Tarif dasar harus terisi";
//                     }
//                     return null;
//                   },
//                 ),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: Colors.white),
//               ))
//             ],
//           ),
//         ),
//         decoration: BoxDecoration(
//             gradient: LinearGradient(
//                 colors: [HexColor('#5433FF'), HexColor('#0063F8')]),
//             boxShadow: const []),
//       ),
//       preferredSize: Size.fromHeight(Get.height * 0.1),
//     );
//   }

//   Widget noListCustomer() {
//     return Center(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             "assets/emptylist.png",
//             width: 77,
//             height: 90,
//           ),
//           const SizedBox(height: 30),
//           Text(
//             "Belum ada pelanggan",
//             style: GoogleFonts.montserrat(
//                 fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             "Tambahkan pelanggan baru melalui\n tombol biru di bawah.",
//             style: GoogleFonts.montserrat(
//                 fontSize: 12,
//                 color: HexColor('#707793'),
//                 fontWeight: FontWeight.w300),
//             textAlign: TextAlign.center,
//           )
//         ],
//       ),
//     );
//   }
// }