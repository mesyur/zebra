import 'dart:convert';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_incall_manager/flutter_incall_manager.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:zebra/help/hive/localStorage.dart';
import 'package:zebra/help/location_service.dart';
import '../../help/DAVINC/core/davinci_capture.dart';
import '../../help/chatStream.dart';
import '../../help/custom_info_window.dart';
import '../../help/loadingClass.dart';
import '../MarkerWidget.dart';
import '../Repository/CallApi.dart';
import '../Repository/CallNotificationApi.dart';
import '../Repository/MainApi.dart';
import '../model/CallSystemModel.dart';
import '../model/CategoryModel.dart';
import '../model/CategoryRulesModel.dart';
import '../model/CategoryRulesModel.dart';
import '../model/CategoryRulesModel.dart';
import '../model/Global.dart';
import '../model/ItemModel.dart';
import '../model/SubCategory2Model.dart';
import '../model/SubCategoryModel.dart';
import '../view/Chat/ChatPage.dart';
import '../view/WIDGETS/mapPin.dart';
import 'ChatMainController.dart';
import 'InitialController.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:zebra/help/globals.dart' as globals;
import 'package:zebra/help/GetStorage.dart';

class MyState<T1,T2,T3>{
  T1? item1;
  T2? item2;
  T3? item3;
  MyState({this.item1,this.item2,this.item3});
}

abstract class MainPageBaseController<T1,T2,T3> extends GetxController with StateMixin<MyState<T1,T2,T3>> ,LoadingDialog,WidgetsBindingObserver{}


//class MainPageController extends MainPageBaseController<CategoryModel,SubCategoryModel,FiltersSubCategoryModel>{
class MainPageController extends MainPageBaseController<CategoryModel,SubCategoryModel,SubCategory2Model>{
  InitialController initialController = Get.find();
  LocationService locationService = LocationService();
  final GlobalKey<ScaffoldState> key = GlobalKey();
  late CameraPosition cameraPosition;
  late GoogleMapController googleMapController;
  StreamSocket streamSocket = StreamSocket();
  MapPickerController mapPickerController = MapPickerController();
  RxMap<int, Marker> markers = <int, Marker>{}.obs;
  late LatLng myCurrentLocation = const LatLng(38.9637,35.2433);
  late LatLng myCurrentLocationForGoToMyLocation;
  BitmapDescriptor pinLocationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor pinLocationIcon1 = BitmapDescriptor.defaultMarker;
  RxDouble mapPaddingBottom = 0.0.obs;


  RxList categoryRules = [].obs;

  RxInt selectedIndex = 0.obs;
  RxInt selectedSubCategoryIndex = 999999999.obs;
  RxInt selectedSubCategory2Index = 999999999.obs;
  RxInt selectedSubCategory3Index = 999999999.obs;

  RxList callId = [].obs;

  RxInt selectedIndexId = 0.obs;
  RxInt selectedSubCategoryIndexId = 0.obs;
  RxInt selectedSubCategory2IndexId = 0.obs;
  RxInt selectedSubCategory3IndexId = 0.obs;

  final animationDuration = const Duration(milliseconds: 150);
  //RxInt myFilterListCount = 1.obs;
  ScrollController scrollController = ScrollController();
  ScrollController scrollController2 = ScrollController();
  ScrollController scrollController3 = ScrollController();
  RxString mainCategoryName = ''.obs;
  RxInt mainCategoryId = 0.obs;
  RxString subCategoryName = ''.obs;
  RxList mainFiltersWidget = [].obs;
  RxList mainFiltersWidget2 = [].obs;
  var customBarrierColor =  Colors.black54;
  CustomInfoWindowController customInfoWindowController = CustomInfoWindowController();
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  RxBool appIsOpen = false.obs;
  RxMap theMarkerUserData = {}.obs;
  List imageLs = [];



  // routeToCallPage(userId){
  //
  //   //CallSystemModel().showCallkitIncoming(const Uuid().v4());
  //   // Get.toNamed('/CallPage',arguments: [{"socketChannel": "channel1"}])?.then((value){
  //   //   IncallManager().startRingtone(RingtoneUriType.BUNDLE, 'ios_category', 1);
  //   // });
  // }


  /// Puan
  RxBool isEnabled = false.obs;
  late List<ItemModel> menuItems;
  final CustomPopupMenuController customPopupMenuController = CustomPopupMenuController();



  /// Sex
  RxBool isEnabledSex = false.obs;
  RxBool allSex = true.obs;
  late List<ItemModel> sexMenuItems;
  final CustomPopupMenuController sexController = CustomPopupMenuController();



  /// Language
  RxBool isEnabledLanguage = false.obs;
  RxBool allLanguage = true.obs;
  late List<ItemModel> languageMenuItems;
  final CustomPopupMenuController languageController = CustomPopupMenuController();



  /// Yetkili
  RxBool isEnabledYetkili = false.obs;
  RxBool allYetkili = true.obs;
  late List<ItemModel> yetkiliMenuItems;
  final CustomPopupMenuController yetkiliController = CustomPopupMenuController();



  /// Sirket
  RxBool isEnabledSirket = false.obs;
  RxBool allSirket = true.obs;
  late List<ItemModel> sirketMenuItems;
  final CustomPopupMenuController sirketController = CustomPopupMenuController();



  getCategoryAndSubCategory({id}){
    showDialogBox();
    change(null,status: RxStatus.loading());
    MainApi().getCategoryApi().then((categoryValue){
      mainCategoryName.value = categoryValue.data[0].name;
      mainCategoryId.value = categoryValue.data[0].id;
      MainApi().getSubCategoryApi(id: categoryValue.data[0].id).then((subCategoryValue){
        //categoryValue, subCategoryValue,FiltersSubCategoryModel
        change(MyState(item1: categoryValue,item2: subCategoryValue,item3: null), status: RxStatus.success());
        filterMainFilter([1]);
        hideDialog();
      },onError: (e){
        hideDialog();
        change(null,status: RxStatus.error());
      });
    },onError: (e){
      hideDialog();
      change(null,status: RxStatus.error());
    });
  }



  getRules({categoryId}){
    showDialogBox();
    MainApi().getCategoryRules(categoryId: categoryId).then((categoryRulesData){
      categoryRules.value = categoryRulesData.data;
      hideDialog();
    },onError: (e){
      hideDialog();
    });
  }



  getCategoryAndSubCategory2({id}){
    showDialogBox();
    MainApi().getSubCategoryApi(id: id).then((subCategoryValue){
      //change(Tuple2(state!.item1, subCategoryValue), status: RxStatus.success());
      change(MyState(item1: state!.item1,item2: subCategoryValue,item3: null), status: RxStatus.success());
      scrollController.jumpTo(0);
      hideDialog();
    },onError: (e){
      hideDialog();
      change(null,status: RxStatus.error());
    });
  }



  getSubCategory2({id}){
    showDialogBox();
    MainApi().getSubCategory2Api(id: id).then((subCategory2Value){
      change(MyState(item1: state!.item1,item2: state!.item2,item3: subCategory2Value), status: RxStatus.success());
      filterCategory(id);
      hideDialog();
    },onError: (e){
      hideDialog();
      change(null,status: RxStatus.error());
    });
  }












  CameraPosition initialLocation = const CameraPosition(
    target: LatLng(38.9637,35.2433),
    zoom: 14.0,
  );

  onCreate(GoogleMapController onCreateController)async{
    googleMapController = onCreateController;
    showDialogBox();
    await locationService.getLocation().then((value){
      myCurrentLocation = LatLng(double.parse(value!.latitude!.toString()), double.parse(value.longitude!.toString()));
      myCurrentLocationForGoToMyLocation = LatLng(double.parse(value.latitude!.toString()), double.parse(value.longitude!.toString()));
      mapPaddingBottom.value = Get.height / 2 - 100;
      hideDialog();
      appIsOpen.value = true;
      checkAndNavigationCallingPage();
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            bearing: 0,
            target: LatLng(double.parse(value.latitude!.toString()), double.parse(value.longitude!.toString())),
            zoom: 14.0
        ),
      ));
    });
  }


  goToMyLocation(){
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          bearing: 0,
          target: LatLng(myCurrentLocationForGoToMyLocation.latitude , myCurrentLocationForGoToMyLocation.longitude),
          zoom: 14.0
      ),
    ));
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }



  filterCategory(id){
    MainApi().filterCategoryApi(id: id).then((value){
      filterMainFilter(value.data);
    },onError: (e){

    });
  }


  filterMainFilter(List filterList){
   // mainFiltersWidget2 = mainFiltersWidget;
    List filters = [];
    for (var element in filterList) {
      filters.add(mainFiltersWidget[element-1]);
    }
    mainFiltersWidget2.value = filters;
  }


  showImage(String imageUrl){
    Get.dialog(
      barrierDismissible: true,
      useSafeArea: true,
      Dialog(
        backgroundColor: Colors.transparent,
        child: StatefulBuilder(
            builder: (BuildContext _, StateSetter setState) {
              return Center(
                child: Container(
                  // width: Get.width / 2,
                  // height: Get.width / 2,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image(image: NetworkImage(imageUrl))
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }


  socketData({data})async{
    // List kk = [];
    // for(var i = 0 ; i < data["data"]["userData"].length ; i++){
    //   kk.add(data["data"]["userData"][i]["slug"]);
    // }
    // print(kk);
    theMarkerUserData[data["data"]["taxiUserId"]] = data["data"];
    var cc = MarkerWidget(dataImage: [for(var i = 0 ; i < data["data"]["userData"].length ; i++)"assets/categoryIcons/${data["data"]["userData"][i]["slug"]}.png"]);
    final Uint8List markerIcon = await DavinciCapture.offStage(cc,returnImageUint8List: true,saveToDevice: false);
    double distanceInMeters = Geolocator.distanceBetween(myCurrentLocation.latitude, myCurrentLocation.longitude, data["data"]["latitude"], data["data"]["longitude"]);
      if(distanceInMeters / 1000 < 20){
      markers[data["data"]["taxiUserId"]] = Marker(
        markerId: MarkerId(data["data"]["taxiUserId"].toString()),
        position: LatLng(data["data"]["latitude"],data["data"]["longitude"]),
        rotation: double.parse(data["data"]["heading"].toString()),
        draggable: false,
        flat: false,
        anchor: const Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(markerIcon,size: const Size(100, 100)),
        onTap: (){
          imageLs.clear();
          for(var i = 0 ; i < theMarkerUserData[data["data"]["taxiUserId"]]['userData'].length ; i++){
            for(var ii = 0  ; ii < theMarkerUserData[data["data"]["taxiUserId"]]['userData'][i]['images'].length ; ii ++){
              imageLs.add(theMarkerUserData[data["data"]["taxiUserId"]]['userData'][i]['images'][ii]);
            }
          }
          print(imageLs);
          print(theMarkerUserData[data["data"]["taxiUserId"]]['name']);
          print(theMarkerUserData[data["data"]["taxiUserId"]]['categoryId']);
          print(theMarkerUserData[data["data"]["taxiUserId"]]['taxiUserName']);
          print(theMarkerUserData[data["data"]["taxiUserId"]]['taxiUserId']);
          print('**--**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-');
          print(theMarkerUserData[data["data"]["taxiUserId"]]['userData']);
          print(theMarkerUserData[data["data"]["taxiUserId"]]['userData'][0]['categoryId']);
          print('**--**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-');
            // infoWindow: InfoWindow(title: "onLine Worker", snippet: data["data"]["taxiUserName"]),
          Get.bottomSheet(
            StatefulBuilder(
              builder: (context, setState) {
                return Container(
                    height: Get.height *8,
                    width: Get.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      /// Header
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Get.back();
                                  },
                                  child: const Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Icon(Icons.lens,color: Colors.black,size: 36),
                                      Icon(Icons.lens,color: Colors.white,size: 35),
                                      Icon(Icons.clear,size: 15,),
                                    ],
                                  ),
                                ),
                                const Card(
                                  color: Colors.black54,
                                  elevation: 1,
                                  child: SizedBox(height: 5,width: 45),
                                ),
                                const Icon(Icons.clear,size: 30,color: Colors.transparent,),
                              ],
                            ),
                          ),

                          const SizedBox(height: 15),

                          /// Body
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${theMarkerUserData[data["data"]["taxiUserId"]]['name'].toString().split(" ")[0].replaceRange(1,theMarkerUserData[data["data"]["taxiUserId"]]['name'].toString().split(" ")[0].toString().length,"****")} ${theMarkerUserData[data["data"]["taxiUserId"]]['name'].toString().split(" ")[1].replaceRange(1,theMarkerUserData[data["data"]["taxiUserId"]]['name'].toString().split(" ")[1].toString().length,"****")} - ${theMarkerUserData[data["data"]["taxiUserId"]]['taxiUserName']}",textAlign: TextAlign.center,style: const TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w500)),
                              //
                                SizedBox(
                                  width: 75,
                                  height: 35,
                                  child: MaterialButton(
                                    elevation: 0,
                                    onPressed: (){
                                      Get.toNamed('/ChatPage',arguments: theMarkerUserData[data["data"]["taxiUserId"]]['taxiUserId']);
                                    },
                                    color: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.black12),
                                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.only(top: 0),
                                      child: Text('Chat', style: TextStyle(color: Colors.black87, fontSize: 12, fontWeight: FontWeight.bold),),
                                    ),
                                  ),
                                ),
                               // const Text("1.17 Km Uzağında",textAlign: TextAlign.center,style: TextStyle(color: Colors.orangeAccent, fontSize: 12.0, fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text('${theMarkerUserData[data["data"]["taxiUserId"]]['userData'][0]['description']}',textAlign: TextAlign.left,style: const TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w500)),
                          ),
                          const SizedBox(height: 20),

                          SizedBox(
                            height: 50,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children: List.generate(imageLs.length, (index) => GestureDetector(
                                onTap: (){
                                  showImage(imageLs[index]);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: Image(image: NetworkImage(imageLs[index])),
                                ),
                              )),
                            ),
                          ),



                          SizedBox(
                            //height: Get.height * .25,
                            child: ListView(
                              shrinkWrap: true,
                              children: List.generate(theMarkerUserData[data["data"]["taxiUserId"]]['userData'][0]['scores'].length, (index) =>
                                  ListTile(
                                    trailing: Column(
                                      children: [
                                        Text('${theMarkerUserData[data["data"]["taxiUserId"]]['userData'][0]['scores'][index]['score']}',textAlign: TextAlign.left,style: const TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w500)),
                                        const Icon(Icons.star,color: Colors.yellowAccent,)
                                      ],
                                    ),
                                    title: Text('${theMarkerUserData[data["data"]["taxiUserId"]]['userData'][0]['scores'][index]['name']}',textAlign: TextAlign.left,style: const TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w500)),
                                    subtitle: Text('${theMarkerUserData[data["data"]["taxiUserId"]]['userData'][0]['scores'][index]['comment']}',textAlign: TextAlign.left,style: const TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w500)),
                                  )
                              ),
                            ),
                          ),





                        ],
                      ),


                      Column(
                        children: [
                          SizedBox(
                            width: 300,
                            height: 50,
                            child: MaterialButton(
                              elevation: 0,
                              onPressed: ()async{
                                callApi(userId: data["data"]["userData"][0]['userId'],name: data["data"]["name"],categoryId: theMarkerUserData[data["data"]["taxiUserId"]]['userData'][0]['categoryId']);
                              },
                              color: Colors.black,
                              shape: const RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.black12),
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(top: 0),
                                child: Text('📞   Bu Profili Ara', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),

                    ],
                  ),
                );
              },
            ),
          );
        },
      );
          }else{
       print("---------------------------------------------------------------REMOVE");
      markers[data["data"]["taxiUserId"]] = Marker(
        markerId: MarkerId(data["data"]["taxiUserId"].toString()),
        position: LatLng(data["data"]["latitude"],data["data"]["longitude"]),
        rotation: double.parse(data["data"]["heading"].toString()),
        draggable: false,
        flat: false,
        visible: false,
        anchor: const Offset(0.5, 0.5),
        icon: data["data"]["taxiTypeId"] != 1 ? pinLocationIcon1 : pinLocationIcon,
        infoWindow: InfoWindow(title: "onLine Worker", snippet: data["data"]["taxiUserName"]),
      );
    }
    update();

  }









  /// PUAN
  addToFilterList(){


    mainFiltersWidget.add(Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12.withOpacity(0.04)),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(7),
          bottomRight: Radius.circular(7),
          topLeft: Radius.circular(7),
          topRight: Radius.circular(7),
        ),
        color: const Color(0xffF5F5F5),
      ),
      child: Row(
        children: [
          CustomPopupMenu(
            barrierColor: customBarrierColor,
            menuBuilder: () => ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                color: const Color(0xFF4C4C4C),
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: menuItems.map((item) => GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        customPopupMenuController.hideMenu();
                      },
                      child: Container(
                        // height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: <Widget>[
                            Icon(item.icon, size: 15, color: Colors.white),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 5),
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(item.title, style: const TextStyle(color: Colors.white, fontSize: 10)),
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
            controller: customPopupMenuController,
            child: GestureDetector(
              onTap: (){
                customPopupMenuController.showMenu();
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: Icon(Icons.info_outline,size: 20,),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Obx(() => Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: (){
                    isEnabled.value = false;
                  },
                  child: Text("yakınlığa\ngöre",textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: !isEnabled.value ? FontWeight.bold : FontWeight.normal))),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: (){
                  isEnabled.value = !isEnabled.value;
                },
                child: AnimatedContainer(
                  height: 30,
                  width: 55,
                  duration: animationDuration,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black12,
                    border: Border.all(
                        color: Colors.white,
                        width: 1
                    ),
                  ),
                  child: AnimatedAlign(
                    duration: animationDuration,
                    alignment: isEnabled.value ? Alignment.centerRight : Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white,
                              width: 3
                          ),
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                  onTap: (){
                    isEnabled.value = true;
                  },
                  child: Text("puana\ngöre",textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: isEnabled.value ? FontWeight.bold : FontWeight.normal))),
            ],
          )),
        ],
      ),
    ));



    /// SEX
    mainFiltersWidget.add(Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12.withOpacity(0.04)),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(7),
          bottomRight: Radius.circular(7),
          topLeft: Radius.circular(7),
          topRight: Radius.circular(7),
        ),
        color: const Color(0xffF5F5F5),
      ),
      child: Obx(() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              CustomPopupMenu(
                barrierColor: customBarrierColor,
                menuBuilder: () => ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    color: const Color(0xFF4C4C4C),
                    child: IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: sexMenuItems.map((item) => GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            sexController.hideMenu();
                          },
                          child: Container(
                            // height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: <Widget>[
                                Icon(item.icon, size: 15, color: Colors.white),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Text(item.title, style: const TextStyle(color: Colors.white, fontSize: 10)),
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
                controller: sexController,
                child: GestureDetector(
                  onTap: (){
                    sexController.showMenu();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Icon(Icons.info_outline,size: 20,),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  allSex.value = true;
                  isEnabledSex.value = false;
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 5),
                    Text("Tümü",textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: allSex.value ? FontWeight.bold : FontWeight.normal)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 15),
          GestureDetector(
              onTap: (){
                isEnabledSex.value = false;
                allSex.value = false;
              },
              child: Text("Erkek",textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: allSex.value ? FontWeight.normal : !isEnabledSex.value ? FontWeight.bold : FontWeight.normal))),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: (){
              isEnabledSex.value = !isEnabledSex.value;
              allSex.value = false;
            },
            child: AnimatedContainer(
              height: 30,
              width: 55,
              duration: animationDuration,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black12,
                border: Border.all(
                    color: Colors.white,
                    width: 1
                ),
              ),
              child: AnimatedAlign(
                duration: animationDuration,
                alignment: allSex.value ? Alignment.center : isEnabledSex.value ? Alignment.centerRight : Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white,
                          width: 3
                      ),
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          GestureDetector(
              onTap: (){
                isEnabledSex.value = true;
                allSex.value = false;
              },
              child: Text("Kadın",textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: isEnabledSex.value ? FontWeight.bold : FontWeight.normal))),
        ],
      )),
    ));




    /// Language
    mainFiltersWidget.add(Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12.withOpacity(0.04)),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(7),
          bottomRight: Radius.circular(7),
          topLeft: Radius.circular(7),
          topRight: Radius.circular(7),
        ),
        color: const Color(0xffF5F5F5),
      ),
      child: Obx(() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              CustomPopupMenu(
                barrierColor: customBarrierColor,
                menuBuilder: () => ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    color: const Color(0xFF4C4C4C),
                    child: IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: languageMenuItems.map((item) => GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            languageController.hideMenu();
                          },
                          child: Container(
                            // height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: <Widget>[
                                Icon(item.icon, size: 15, color: Colors.white),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Text(item.title, style: const TextStyle(color: Colors.white, fontSize: 10)),
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
                controller: languageController,
                child: GestureDetector(
                  onTap: (){
                    languageController.showMenu();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Icon(Icons.info_outline,size: 20,),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  allLanguage.value = true;
                  isEnabledLanguage.value = false;
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 5),
                    Text("Tümü",textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: allLanguage.value ? FontWeight.bold : FontWeight.normal)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 15),
          GestureDetector(
              onTap: (){
                isEnabledLanguage.value = false;
                allLanguage.value = false;
              },
              child: Text("Türk",textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: allLanguage.value ? FontWeight.normal : !isEnabledLanguage.value ? FontWeight.bold : FontWeight.normal))),
          const SizedBox(width: 5),
          Obx(() => GestureDetector(
            onTap: (){
              isEnabledLanguage.value = !isEnabledLanguage.value;
              allLanguage.value = false;
            },
            child: AnimatedContainer(
              height: 30,
              width: 55,
              duration: animationDuration,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black12,
                border: Border.all(
                    color: Colors.white,
                    width: 1
                ),
              ),
              child: AnimatedAlign(
                duration: animationDuration,
                alignment: allLanguage.value ? Alignment.center : isEnabledLanguage.value ? Alignment.centerRight : Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white,
                          width: 3
                      ),
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          )
          ),
          const SizedBox(width: 5),
          GestureDetector(
              onTap: (){
                isEnabledLanguage.value = true;
                allLanguage.value = false;
              },
              child: Text("Yabancı",textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: isEnabledLanguage.value ? FontWeight.bold : FontWeight.normal))),
        ],
      )),
    ));








    /// Yetkili
    mainFiltersWidget.add(Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12.withOpacity(0.04)),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(7),
          bottomRight: Radius.circular(7),
          topLeft: Radius.circular(7),
          topRight: Radius.circular(7),
        ),
        color: const Color(0xffF5F5F5),
      ),
      child: Obx(() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              CustomPopupMenu(
                barrierColor: customBarrierColor,
                menuBuilder: () => ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    color: const Color(0xFF4C4C4C),
                    child: IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: yetkiliMenuItems.map((item) => GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            yetkiliController.hideMenu();
                          },
                          child: Container(
                            // height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: <Widget>[
                                Icon(item.icon, size: 15, color: Colors.white),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Text(item.title, style: const TextStyle(color: Colors.white, fontSize: 10)),
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
                controller: yetkiliController,
                child: GestureDetector(
                  onTap: (){
                    yetkiliController.showMenu();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Icon(Icons.info_outline,size: 20,),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  allYetkili.value = true;
                  isEnabledYetkili.value = false;
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 5),
                    Text("Tümü",textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: allYetkili.value ? FontWeight.bold : FontWeight.normal)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 15),
          GestureDetector(
              onTap: (){
                isEnabledYetkili.value = false;
                allYetkili.value = false;
              },
              child: Text("Yetkili\nservis",textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: allYetkili.value ? FontWeight.normal : !isEnabledYetkili.value ? FontWeight.bold : FontWeight.normal))),
          const SizedBox(width: 5),
          Obx(() => GestureDetector(
            onTap: (){
              isEnabledYetkili.value = !isEnabledYetkili.value;
              allYetkili.value = false;
            },
            child: AnimatedContainer(
              height: 30,
              width: 55,
              duration: animationDuration,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black12,
                border: Border.all(
                    color: Colors.white,
                    width: 1
                ),
              ),
              child: AnimatedAlign(
                duration: animationDuration,
                alignment: allYetkili.value ? Alignment.center : isEnabledYetkili.value ? Alignment.centerRight : Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white,
                          width: 3
                      ),
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          )
          ),
          const SizedBox(width: 5),
          GestureDetector(
              onTap: (){
                isEnabledYetkili.value = true;
                allYetkili.value = false;
              },
              child: Text("Özel\nservis",textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: isEnabledYetkili.value ? FontWeight.bold : FontWeight.normal))),
        ],
      )),
    ));





    /// Sirket
    mainFiltersWidget.add(Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12.withOpacity(0.04)),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(7),
          bottomRight: Radius.circular(7),
          topLeft: Radius.circular(7),
          topRight: Radius.circular(7),
        ),
        color: const Color(0xffF5F5F5),
      ),
      child: Obx(() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              CustomPopupMenu(
                barrierColor: customBarrierColor,
                menuBuilder: () => ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    color: const Color(0xFF4C4C4C),
                    child: IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: sirketMenuItems.map((item) => GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            sirketController.hideMenu();
                          },
                          child: Container(
                            // height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: <Widget>[
                                Icon(item.icon, size: 15, color: Colors.white),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Text(item.title, style: const TextStyle(color: Colors.white, fontSize: 10)),
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
                controller: sirketController,
                child: GestureDetector(
                  onTap: (){
                    sirketController.showMenu();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Icon(Icons.info_outline,size: 20,),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  allSirket.value = true;
                  isEnabledSirket.value = false;
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 5),
                    Text("Tümü",textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: allSirket.value ? FontWeight.bold : FontWeight.normal)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 15),
          GestureDetector(
              onTap: (){
                isEnabledSirket.value = false;
                allSirket.value = false;
              },
              child: Text("Şirket",textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: allSirket.value ? FontWeight.normal : !isEnabledSirket.value ? FontWeight.bold : FontWeight.normal))),
          const SizedBox(width: 5),
          Obx(() => GestureDetector(
            onTap: (){
              isEnabledSirket.value = !isEnabledSirket.value;
              allSirket.value = false;
            },
            child: AnimatedContainer(
              height: 30,
              width: 55,
              duration: animationDuration,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black12,
                border: Border.all(
                    color: Colors.white,
                    width: 1
                ),
              ),
              child: AnimatedAlign(
                duration: animationDuration,
                alignment: allSirket.value ? Alignment.center : isEnabledSirket.value ? Alignment.centerRight : Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white,
                          width: 3
                      ),
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          )
          ),
          const SizedBox(width: 5),
          GestureDetector(
              onTap: (){
                isEnabledSirket.value = true;
                allSirket.value = false;
              },
              child: Text("Bireysel",textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: isEnabledSirket.value ? FontWeight.bold : FontWeight.normal))),
        ],
      )),
    ));






  }




  @override
  void onInit() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xffffffff),
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    super.onInit();
    BitmapDescriptor.fromAssetImage(const ImageConfiguration(devicePixelRatio: 2.5),'assets/icons/pinTaxi.png').then((onValue) {
      pinLocationIcon = onValue;
    });
    BitmapDescriptor.fromAssetImage(const ImageConfiguration(devicePixelRatio: 2.5),'assets/icons/pinTaxi1.png').then((onValue) {
      pinLocationIcon1 = onValue;
    });
    // locationService.locationStream.listen((e){
    //   myCurrentLocationForGoToMyLocation = LatLng(e.latitude!,e.longitude!);
    //   initialController.socketConnected.value ?  initialController.socket.emit("marker",[{
    //     "taxiUserId": 25,
    //     "taxiUserName": "Murad Najm",
    //     "taxiTypeId": 1,
    //     "latitude": e.latitude,
    //     "longitude": e.longitude,
    //     "heading": e.heading,
    //     "busy": false
    //   }]
    //   ) : null;
    // });
    menuItems = [ItemModel('Yakınlığa göre:  Bu aramada konumunuza en yakın olan hizmet verenler aranır. Yakınızdaki hizmet verenleri bulma şansınız bu seçenekte daha yüksektir.\n'
        'Puana Göre: Bu filtre ile dilerseniz sadece yüksek puan almış hizmet verenler arasında arama yapabilirsiniz.', Icons.info_outline)];


    sexMenuItems = [ItemModel('Tümü: Bu seçenek daha hızlı yanıt almanızı sağlar.\n'
        'Erkek: Sadece erkek hizmet verenler aramaya dahil edilir.\n'
        'Kadın: Sadece kadın hizmet verenler aramaya dahil edilir.\n', Icons.info_outline)];

    languageMenuItems = [ItemModel('Tümü: Bu seçenek daha hızlı yanıt almanızı sağlar.\n'
        'Türk: Sadece Türk hizmet verenler aramaya dahil edilir.\n'
        'Yabancı: Sadece yabancı hizmet verenler aramaya dahil edilir.\n', Icons.info_outline)];

    yetkiliMenuItems = [ItemModel('Tümü: Bu seçenek daha hızlı yanıt almanızı sağlar.\n'
        'Yetkili Servis: Sadece markanın yetki verdiği servisler aranır.\n'
        'Özel Servis: Bu markalara özel olarak hizmet veren servisler aranır.\n', Icons.info_outline)];

    sirketMenuItems = [ItemModel('Tümü: Bu seçenek  daha hızlı yanıt almanızı sağlar.\n'
        'Şirket: Bu kategoride kurumsal firma olarak hizmet verenler.\n'
        'Bireysel: Bu kategoride özel olarak hizmet vermek isteyen kişiler.\n', Icons.info_outline)];

    addToFilterList();
  }


  getCallUserListApi(){

    int selectedSubCategoryId = selectedSubCategory3IndexId.value != 0 ? selectedSubCategory3IndexId.value : selectedSubCategory2IndexId.value != 0 ? selectedSubCategory2IndexId.value : selectedSubCategoryIndexId.value != 0 ? selectedSubCategoryIndexId.value : 0;

    Map callUserListMap = {
      "lat": myCurrentLocation.latitude,
      "lon": myCurrentLocation.longitude,
      "categoryId": selectedIndexId.value,
      "subCategoryId": selectedSubCategoryId,
      "searchType": isEnabled.value ? 1 : 0, // 0 yakınlığa göre / 1 puana göre
      "gender": allSex.value ? 2 : isEnabledSex.value ? 1 : 0, // 2 Tümü / 1 Kadın / 0 Erkek
      "language": allLanguage.value ? 2 : isEnabledLanguage.value ? 1 : 0,  // 2 Tümü / 1 Yabancı / 0 Türk
      "serviceType": allYetkili.value ? 2 : isEnabledYetkili.value ? 1 : 0,  // 2 Tümü / 1 Özel servis / 0 Yetkili servis
      "companyType": allSirket.value ? 2 : isEnabledSirket.value ? 1 : 0  // 2 Tümü / 1 Bireysel / 0 Şirket
    };

    callId.clear();
    showDialogBox();
    CallApi().getCallUserListApi(callUserListMap: callUserListMap).then((value){
      const String chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      final Random rnd = Random();
      String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
      for(var i = 0 ; i < value.data.length ; i++){
        CallApi().callUserApi(categoryId: mainCategoryId.value,calledUserId: value.data[i].userId).then((valuex){
        callId.add({value.data[i].userId : valuex.data.callId});
        String socketChannelRandom = getRandomString(15);
        CallNotificationApi().callUserById(
            userId: value.data[i].userId,
            catName: mainCategoryName.value,
            subCatName: subCategoryName.value,
            callerId: LocalStorage().getValue("id"),
            callerName: LocalStorage().getValue("firstName") + ' ' + LocalStorage().getValue("lastName"),
            socketChannel: socketChannelRandom
        );
        },onError: (e){});
      }



      /// TODO Delete --for test
      // List ids = [23,24];
      // for(var i = 0;i<ids.length;i++) {
      //   String socketChannelRandom = getRandomString(15);
      //   CallApi().callUserApi(categoryId: mainCategoryId.value,calledUserId: ids[i]).then((value){
      //     callId.add({ids[i]: value.data.callId});
      //     CallNotificationApi().callUserById(
      //         userId: ids[i],
      //         catName: mainCategoryName.value,
      //         subCatName: subCategoryName.value,
      //         callerId: LocalStorage().getValue("id"),
      //         callerName: LocalStorage().getValue("firstName") + ' ' + LocalStorage().getValue("lastName"),
      //         socketChannel: socketChannelRandom
      //     );
      //   },onError: (e){});
      // }
      hideDialog();
      globals.haveCall = true;
      Get.toNamed('/CallWaiting');
    },onError: (e){
      hideDialog();
    });
  }


  callApi({userId,name,categoryId}){
    //showDialogBox();
    const String chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final Random rnd = Random();
    String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
    String socketChannelRandom = getRandomString(15);
    CallApi().callUserApi(categoryId: categoryId,calledUserId: userId).then((value){
      callId.add({userId: value.data.callId});
    CallNotificationApi().callUserById(
        userId: userId,
        catName: mainCategoryName.value,
        subCatName: subCategoryName.value,
        callerId: LocalStorage().getValue("id"),
        callerName: LocalStorage().getValue("firstName") + ' ' + LocalStorage().getValue("lastName"),
        socketChannel: socketChannelRandom
    );
    },onError: (e){});
    globals.haveCall = true;
    Get.toNamed('/CallWaiting');
  }



  getCallUserListApi2(increaseAmount,minLimit){
    int selectedSubCategoryId = selectedSubCategory3IndexId.value != 0 ? selectedSubCategory3IndexId.value : selectedSubCategory2IndexId.value != 0 ? selectedSubCategory2IndexId.value : selectedSubCategoryIndexId.value != 0 ? selectedSubCategoryIndexId.value : 0;
    Map callUserListMap = {
      "lat": myCurrentLocation.latitude,
      "lon": myCurrentLocation.longitude,
      "categoryId": selectedIndexId.value,
      "subCategoryId": selectedSubCategoryId,
      "searchType": isEnabled.value ? 1 : 0, // 0 yakınlığa göre / 1 puana göre
      "gender": allSex.value ? 2 : isEnabledSex.value ? 1 : 0, // 2 Tümü / 1 Kadın / 0 Erkek
      "language": allLanguage.value ? 2 : isEnabledLanguage.value ? 1 : 0,  // 2 Tümü / 1 Yabancı / 0 Türk
      "serviceType": allYetkili.value ? 2 : isEnabledYetkili.value ? 1 : 0,  // 2 Tümü / 1 Özel servis / 0 Yetkili servis
      "companyType": allSirket.value ? 2 : isEnabledSirket.value ? 1 : 0  // 2 Tümü / 1 Bireysel / 0 Şirket
    };
    showDialogBox();
    CallApi().getCallUserListApi(callUserListMap: callUserListMap).then((value) {
      hideDialog();
      Get.toNamed('/Offer',arguments: [value.data,increaseAmount,minLimit]);
    },onError: (e){
      hideDialog();
    });
  }


  callApiForList({userId,name}){
    showDialogBox();
    const String chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final Random rnd = Random();
    String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
    String socketChannelRandom = getRandomString(15);
    CallNotificationApi().callUserById(userId: userId,callerId: LocalStorage().getValue("id"),callerName: LocalStorage().getValue("firstName") + ' ' + LocalStorage().getValue("lastName"),socketChannel: socketChannelRandom).then((value){
      hideDialog();
      globals.callOpen = true;
      Get.toNamed('/CallPage',arguments: [{"socketChannel": socketChannelRandom},{"id": ""},{"name": name}]);
    },onError: (e){
      hideDialog();
    });
  }



  callBack(){
    FlutterCallkitIncoming.onEvent.listen((event) async{
      switch (event!.event) {
        case Event.ACTION_CALL_INCOMING:
          break;
        case Event.ACTION_CALL_START:
          break;
        case Event.ACTION_CALL_ACCEPT:
          var calls = await FlutterCallkitIncoming.activeCalls();
          if (calls is List) {
            if (calls.isNotEmpty) {
              Get.toNamed('/CallPage',arguments: [{"socketChannel": "channel1"},{"id": calls[0]['id']}]);
              return calls[0];
            } else {
            }
          }
          break;
        case Event.ACTION_CALL_DECLINE:
          break;
        case Event.ACTION_CALL_ENDED:
          break;
        case Event.ACTION_CALL_TIMEOUT:
          break;
        case Event.ACTION_CALL_CALLBACK:
          break;
        case Event.ACTION_CALL_TOGGLE_HOLD:
          break;
        case Event.ACTION_CALL_TOGGLE_MUTE:
          break;
        case Event.ACTION_CALL_TOGGLE_DMTF:
          break;
        case Event.ACTION_CALL_TOGGLE_GROUP:
          break;
        case Event.ACTION_CALL_TOGGLE_AUDIO_SESSION:
          break;
        case Event.ACTION_DID_UPDATE_DEVICE_PUSH_TOKEN_VOIP:
          break;
      }
    });
  }



  ///*********************************************
  String? _currentUuid;
  getCurrentCall() async {
    //check current call from pushkit if possible
    var calls = await FlutterCallkitIncoming.activeCalls();
    if (calls is List) {
      if (calls.isNotEmpty) {
       // print('DATA------------: $calls');
        _currentUuid = calls[0]['id'];
        return calls[0];
      } else {
        _currentUuid = "";
        return null;
      }
    }
  }

  checkAndNavigationCallingPage() async {
    var currentCall = await getCurrentCall();
    if (currentCall != null) {
      // await Future.delayed(const Duration(seconds: 3));
      Get.toNamed('/CallPage',arguments: [{"socketChannel": "channel1"},{"id": _currentUuid}]);
    }
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      //Check call when open app from background
      checkAndNavigationCallingPage();
    }
  }
  ///*********************************************


  @override
  void onReady() {
    super.onReady();
    mapPaddingBottom.value = Get.height / 2 - 100;
    initialController.socket.on("marker", (data) {
      socketData(data: data);
    });

    initialController.socket.on("callAccepted",(data){
      if(globals.callOpen){
        initialController.socket.emit('inCall',[{
          'socketId': data["socketId"],
          'type': 'In Call'
        }]);
      }else if(!globals.haveCall){
        initialController.socket.emit('inCall',[{
          'socketId': data["socketId"],
          'type': 'No Have Call'
        }]);
      }else{
        Get.back();
        globals.callOpen = true;
        initialController.socket.emit('inCall',[{
          'socketId': data["socketId"],
          'type': 'You Are Connected'
        }]);
        Get.toNamed('/CallPage',arguments: [{"socketChannel": data["data"]['socketChannelRandom']},{"id": data["data"]['userId']},{"name": data["data"]['name']}]);
      }
    });





    try{
      goToMyLocation();
    }catch(e){}
    getCategoryAndSubCategory();
   // appIsOpen.value ? callBack() : null;
   // WidgetsBinding.instance.addObserver(this);
    /// TODO DELETE ON PRODUCTION
    print(LocalStorage().getValue("id"));
    print(LocalStorage().getValue("token"));


    initialController.socket.on("chat", (data)async{
      List listOfOtherUsersGlobalIdForChat = [];
      if(Global.otherUserGlobalIdForChat.value == int.tryParse(data['data']['msg']['author']['id'])){
      }else{
        if(box.read('userIds') == null){
          listOfOtherUsersGlobalIdForChat.add(int.tryParse(data['data']['msg']['author']['id']));
          await box.write('userIds',listOfOtherUsersGlobalIdForChat);
        }else{
          listOfOtherUsersGlobalIdForChat = box.read('userIds');
          listOfOtherUsersGlobalIdForChat.contains(int.tryParse(data['data']['msg']['author']['id'])) ? null : listOfOtherUsersGlobalIdForChat.add(int.tryParse(data['data']['msg']['author']['id']));
         // listOfOtherUsersGlobalIdForChat.contains(1) ? null : listOfOtherUsersGlobalIdForChat.add(1);
          await box.write('userIds',listOfOtherUsersGlobalIdForChat);
        }
      }
      // ChatMainController chatMainController = Get.find();
      // chatMainController.isClosed ? null : chatMainController.change(null,status: RxStatus.success());
      change(MyState(item1: state!.item1,item2: state!.item2,item3: state!.item3), status: RxStatus.success());
    });
  }


  @override
  void onClose() {
    customInfoWindowController.dispose();
    super.onClose();
  }


}







