import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../help/hive/localStorage.dart';
import '../../controller/ProfileController.dart';
import '../../model/ItemModel.dart';
import 'IsoProfileEdit/IsoProfileEdit.dart';
import 'package:intl/intl.dart' as i;


class Profile extends GetView<ProfileController>{
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
      ),
        body: controller.obx((state) => ListView(
          children: [
            const SizedBox(height: 20),
            Align(
              alignment: const Alignment(0,-0.1),
              child: Column(
                children: [




                  Obx(() => ToggleSwitch(
                    initialLabelIndex: controller.selectedIndex.value,
                    activeBgColor: const [Colors.black12],
                    inactiveBgColor: Colors.white,
                    minWidth: Get.width * .29,
                    cornerRadius: 10,
                    borderWidth: 1,
                    borderColor: const [Colors.black12],
                    activeFgColor: Colors.black,
                    labels: ['Female'.tr,'Male'.tr,'undefined'.tr],
                    onToggle: (index) {
                      if(controller.selectedIndex.value != index){
                        controller.selectedIndex.value = index!;
                      }else{}
                    },
                  )),
                  const SizedBox(height: 10),

                  Form(
                    key: controller.formState,
                    child: Obx(() => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [


                              /// First Name
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xff512E70).withOpacity(0.0),
                                      offset: const Offset(0.0, 0.5), //(x,y)
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                height: 50,
                                child: TextFormField(
                                  onTap: (){
                                    controller.firstNameError.value = false;
                                  },
                                  enabled: false,
                                  controller: controller.firstNameController,
                                  textAlignVertical: TextAlignVertical.center,
                                  cursorColor: const Color(0xFF26242e),
                                  style:  TextStyle(fontWeight: FontWeight.normal,fontSize: 15,letterSpacing: 0,color: Colors.black12.withOpacity(0.2)),
                                  validator: (value){
                                    if(value!.isEmpty){
                                      controller.menuItems0 = [ItemModel('Error First Name !', Icons.verified_user_outlined)];
                                      controller.firstNameError.value = true;
                                      return "";
                                    }else{
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintStyle: const TextStyle(fontSize: 12,),
                                      errorStyle: const TextStyle(height: 0.001,color: Colors.transparent),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      suffixIcon: const Icon(Icons.phone_enabled, color: Colors.transparent,),
                                      prefixIcon: controller.firstNameError.value ? CustomPopupMenu(
                                          menuBuilder: () => ClipRRect(
                                            borderRadius: BorderRadius.circular(5),
                                            child: Container(
                                              color: const Color(0xFF4C4C4C),
                                              child: IntrinsicWidth(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: controller.menuItems0.map((item) => GestureDetector(
                                                    behavior: HitTestBehavior.translucent,
                                                    onTap: () {
                                                      controller.controller0.hideMenu();
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Icon(item.icon, size: 15, color: Colors.white),
                                                          Expanded(
                                                            child: Container(
                                                              margin: const EdgeInsets.only(left: 10),
                                                              padding: const EdgeInsets.symmetric(vertical: 10),
                                                              child: Text(item.title, style: const TextStyle(color: Colors.white, fontSize: 12)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  ).toList(),
                                                ),
                                              ),
                                            ),
                                          ),
                                          pressType: PressType.singleClick,
                                          verticalMargin: -17,
                                          controller: controller.controller0,
                                          child: Container(
                                            padding: const EdgeInsets.all(3),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: const [
                                                SizedBox(
                                                    height: 12,
                                                    width: 12,
                                                    child: Image(image: AssetImage("assets/icons/error.gif"),)),
                                              ],
                                            ),
                                          )) : null,
                                      hintText: 'First Name',
                                      fillColor: const Color(0xffffffff),
                                      filled: true
                                  ),
                                ),
                              ),


                              const SizedBox(height: 10),

                              /// Last Name
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xff512E70).withOpacity(0.0),
                                      offset: const Offset(0.0, 0.5), //(x,y)
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                height: 50,
                                child: TextFormField(
                                  onTap: (){
                                    controller.lastNameError.value = false;
                                  },
                                  enabled: false,
                                  controller: controller.lastNameController,
                                  textAlignVertical: TextAlignVertical.center,
                                  cursorColor: const Color(0xFF26242e),
                                  style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,letterSpacing: 0,color: Colors.black12.withOpacity(0.2)),
                                  validator: (value){
                                    if(value!.isEmpty){
                                      controller.menuItems1 = [
                                        ItemModel('Error Last Name !', Icons.verified_user_outlined),
                                      ];
                                      controller.lastNameError.value = true;
                                      return "";
                                    }else{
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintStyle: const TextStyle(fontSize: 12,),
                                      errorStyle: const TextStyle(height: 0.001,color: Colors.transparent),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      suffixIcon: const Icon(Icons.phone_enabled, color: Colors.transparent,),
                                      prefixIcon: controller.lastNameError.value ? CustomPopupMenu(
                                          menuBuilder: () => ClipRRect(
                                            borderRadius: BorderRadius.circular(5),
                                            child: Container(
                                              color: const Color(0xFF4C4C4C),
                                              child: IntrinsicWidth(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: controller.menuItems1.map((item) => GestureDetector(
                                                    behavior: HitTestBehavior.translucent,
                                                    onTap: () {
                                                      controller.controller1.hideMenu();
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Icon(item.icon, size: 15, color: Colors.white),
                                                          Expanded(
                                                            child: Container(
                                                              margin: const EdgeInsets.only(left: 10),
                                                              padding: const EdgeInsets.symmetric(vertical: 10),
                                                              child: Text(item.title, style: const TextStyle(color: Colors.white, fontSize: 12)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  ).toList(),
                                                ),
                                              ),
                                            ),
                                          ),
                                          pressType: PressType.singleClick,
                                          verticalMargin: -17,
                                          controller: controller.controller1,
                                          child: Container(
                                            padding: const EdgeInsets.all(0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: const [
                                                SizedBox(
                                                    height: 12,
                                                    width: 12,
                                                    child: Image(image: AssetImage("assets/icons/error.gif"))),
                                              ],
                                            ),
                                          )) : null,
                                      hintText: 'Last Name',
                                      fillColor: const Color(0xffffffff),
                                      filled: true
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                  ),






                  const SizedBox(height: 10),

                  /// Email
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff512E70).withOpacity(0.0),
                            offset: const Offset(0.0, 0.5), //(x,y)
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      height: 50,
                      child: TextFormField(
                        controller: controller.emailAddressController,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: const Color(0xFF26242e),
                        style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 15,letterSpacing: 0,color: Color(0xff363636)),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            counterText: "",
                            hintStyle: const TextStyle(fontSize: 12,),
                            errorStyle: const TextStyle(height: 0.001,color: Colors.transparent),
                            suffixIcon: const Icon(Icons.phone_enabled, color: Colors.transparent,),
                            hintText: 'Email Address',
                            fillColor: const Color(0xffffffff),
                            filled: true
                        ),
                      ),
                    ),
                  ),








                  /// Birthday
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff512E70).withOpacity(0.0),
                            offset: const Offset(0.0, 0.5), //(x,y)
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      height: 50,
                      child: GestureDetector(
                        onTap: (){
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime(1950, 1, 1),
                            maxTime: DateTime(2004, 1, 1),
                            currentTime: DateTime.now(),
                            locale: LocaleType.tr,
                            onConfirm: (date) {
                              final i.DateFormat formatter = i.DateFormat('yyyy-MM-dd');
                              final String formatted = formatter.format(date);
                              controller.birthdayController.text = formatted;
                            },
                          );
                        },
                        child: TextFormField(
                          controller: controller.birthdayController,
                          textAlignVertical: TextAlignVertical.center,
                          enabled: false,
                          cursorColor: const Color(0xFF26242e),
                          style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 15,letterSpacing: 0,color: Color(0xff363636)),
                          decoration: InputDecoration(
                              hintStyle: const TextStyle(fontSize: 12,),
                              errorStyle: const TextStyle(height: 0.001,color: Colors.transparent),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              suffixIcon: const Icon(Icons.phone_enabled, color: Colors.transparent,),
                              hintText: 'Birth Day',
                              fillColor: const Color(0xffffffff),
                              filled: true
                          ),
                        ),
                      ),
                    ),
                  ),







                  const SizedBox(height: 10),

                  /// Phone
                  Obx(() => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xff512E70).withOpacity(0.0),
                                offset: const Offset(0.0, 0.5), //(x,y)
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          height: 50,
                          child: TextFormField(
                            onTap: (){
                              controller.phoneError.value = false;
                            },
                            enabled: false,
                            controller: controller.phoneNumberController,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.number,
                            cursorColor: const Color(0xFF26242e),
                            maxLength: 10,
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,letterSpacing: 0,color: Colors.black12.withOpacity(0.2)),
                            onChanged: (x){
                              x.startsWith("0") ? controller.phoneNumberController.clear() : null;
                            },
                            validator: (value){
                              if(value!.isEmpty || value.length < 10){
                                controller.menuItems2 = [ItemModel('Error Phone Number !', Icons.verified_user_outlined)];
                                controller.phoneError.value = true;
                                return "";
                              }else{
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                counterText: "",
                                hintStyle: const TextStyle(fontSize: 12,),
                                errorStyle: const TextStyle(height: 0.001,color: Colors.transparent),
                                suffixIcon: const Icon(Icons.phone_enabled, color: Colors.transparent,),
                                prefixIcon: controller.phoneError.value ? CustomPopupMenu(
                                    menuBuilder: () => ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Container(
                                        color: const Color(0xFF4C4C4C),
                                        child: IntrinsicWidth(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: controller.menuItems2.map((item) => GestureDetector(
                                              behavior: HitTestBehavior.translucent,
                                              onTap: () {
                                                controller.controller2.hideMenu();
                                              },
                                              child: Container(
                                                height: 40,
                                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(item.icon, size: 15, color: Colors.white),
                                                    Expanded(
                                                      child: Container(
                                                        margin: const EdgeInsets.only(left: 10),
                                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                                        child: Text(item.title, style: const TextStyle(color: Colors.white, fontSize: 12)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            ).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    pressType: PressType.singleClick,
                                    verticalMargin: -17,
                                    controller: controller.controller2,
                                    child: Container(
                                      padding: const EdgeInsets.all(3),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          SizedBox(
                                              height: 17,
                                              width: 17,
                                              child: Image(image: AssetImage("assets/icons/error.gif"),)),
                                        ],
                                      ),
                                    )) : Icon(Icons.phone, color: Colors.black12.withOpacity(0.2),size: 20,),
                                hintText: 'Phone Number',
                                fillColor: const Color(0xffffffff),
                                filled: true
                            ),
                          ),
                        ),

                        // Positioned(
                        //   right: 10,
                        //   child: Container(
                        //     child: controller.flagMyIso.value != '' ? Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         Text('${controller.dialCodeMyIso}',textDirection: TextDirection.rtl,style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 12,letterSpacing: 0,color: Color(0xff363636)),strutStyle: const StrutStyle(forceStrutHeight: true,height: 1,)),
                        //         const SizedBox(width: 5),
                        //         Image(
                        //           height: 15,
                        //           image: AssetImage(controller.flagMyIso.value),
                        //         ),
                        //       ],
                        //     ) :
                        //     Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: const [
                        //         Text('90+',textDirection: TextDirection.rtl,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 12,letterSpacing: 0,color: Color(0xff363636)),strutStyle: StrutStyle(forceStrutHeight: true,height: 1,)),
                        //         SizedBox(width: 5),
                        //         Image(
                        //           height: 15,
                        //           image: AssetImage("assets/flags/tr.png"),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  )),












                  const SizedBox(height: 40),

                  SizedBox(
                    width: 250,
                    height: 50,
                    child: MaterialButton(
                      elevation: 0,
                      onPressed: (){
                        controller.updateApi();
                      },
                      color: Colors.white,
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text('Update', style: TextStyle(color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),




                  const SizedBox(height: 50),
                  SizedBox(
                    width: 150,
                    height: 35,
                    child: MaterialButton(
                      elevation: 0,
                      onPressed: (){
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.info,
                            text: 'Do you want to logout ?',
                            confirmBtnText: 'Yes',
                            cancelBtnText: 'No',
                            confirmBtnColor: Colors.redAccent,
                            showCancelBtn: true,
                            onConfirmBtnTap: (){
                              LocalStorage().setValue("login",null);
                              Get.toNamed("/Login");
                            }
                        );
                      },
                      color: Colors.white,
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text('Log Out', style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),




                  const SizedBox(height: 10),
                  SizedBox(
                    width: 150,
                    height: 35,
                    child: MaterialButton(
                      elevation: 0,
                      onPressed: (){
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.warning,
                            text: 'Do you want to delete your account ?',
                            confirmBtnText: 'Yes',
                            cancelBtnText: 'No',
                            confirmBtnColor: Colors.redAccent,
                            showCancelBtn: true,
                            onConfirmBtnTap: (){
                              controller.deleteUser(context);
                            }
                        );
                      },
                      color: Colors.white,
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text('Delete My Account', style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),




                ],
              ),
            )
          ],
        ),onLoading: Container())
    );
  }

}