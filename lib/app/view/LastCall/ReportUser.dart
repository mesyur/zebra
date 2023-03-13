import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/ReportUserController.dart';
import '../../model/ItemModel.dart';


class ReportUser extends GetView<ReportUserController>{
  const ReportUser({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report User", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          controller.obx((state){
            return Column(
              children: List.generate(state!.data.length, (index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (){
                      controller.selectedIndex.value = index;
                      controller.selectedIndexId.value = state.data[index].complaintId;
                    },
                    child: Obx(() => Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            const Icon(Icons.lens_outlined,size: 30,),
                            Icon(Icons.lens,color: controller.selectedIndex.value == index ? Colors.lightGreen : Colors.transparent,size: 17,)
                          ],
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                            width: Get.width - 65,
                            child: Text(state.data[index].complaintReason))
                      ],
                    )),
                  ),
                );
              }),
            );
          }),
          const SizedBox(height: 20),
          Form(
            key: controller.formState,
            child: Obx(() => Column(
              children: [
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
                    height: 130,
                    child: TextFormField(
                      onTap: (){
                        controller.noteError.value = false;
                      },
                      maxLines: 4,
                      controller: controller.noteController,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.text,
                      cursorColor: const Color(0xFF26242e),
                      style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 15,letterSpacing: 0,color: Color(0xff363636)),
                      validator: (value){
                        if(value!.isEmpty){
                          controller.menuItems = [ItemModel('Boş mesaj göndermek mümkün değil.', Icons.verified_user_outlined)];
                          controller.noteError.value = true;
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
                          prefixIcon: controller.noteError.value ? CustomPopupMenu(
                              menuBuilder: () => ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  color: const Color(0xFF4C4C4C),
                                  child: IntrinsicWidth(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: controller.menuItems.map((item) => GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onTap: () {
                                          controller.customPopupMenuController.hideMenu();
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
                              controller: controller.customPopupMenuController,
                              child: Container(
                                padding: const EdgeInsets.only(top: 25),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    SizedBox(
                                        height: 17,
                                        width: 17,
                                        child: Image(image: AssetImage("assets/icons/error.gif"),)),
                                  ],
                                ),
                              )) : Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                  children: const [
                                    Icon(Icons.note, color: Colors.black54,size: 25,),
                                  ],
                                ),
                              ),
                          hintText: 'SBize kullanıcı\ngeri bildiriminizi bırakın',
                          fillColor: const Color(0xffffffff),
                          filled: true
                      ),
                    ),
                  ),
                ),
              ],
            )),
          ),

          const SizedBox(height: 10),
          Column(
            children: [
              SizedBox(
                width: Get.width - 50,
                height: 50,
                child: MaterialButton(
                  elevation: 0,
                  onPressed: (){
                    controller.reportUser();
                  },
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Text('Send', style: TextStyle(color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}