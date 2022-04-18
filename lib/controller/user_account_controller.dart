

import 'package:homi/repository/Repository.dart';
import 'package:homi/services/get_screens.dart';
import 'package:homi/services/get_user.dart';

class UserAccountController{


  var repository = Repository() ;

  // saveData
  saveUserData(ResponseData responseData) async{
    return await repository.insertData("user_account", responseData.userResponseDataMap());
  }

  // saveData
  saveUserScreensData(ResponseScreens responseScreens) async{
    return await repository.insertData("user_screen", responseScreens.userScreensResponseDataMap());
  }

  // fetchData
  fetchUserData(String table) async{
    return await repository.fetchData(table);
  }

  // updateData
  updateUserData(ResponseData responseData) async{
    return await repository.updateData("user_account", responseData.userResponseDataMap());
  }

  // delete products by brand
  deleteUserData()async{
    return await repository.dropTable("user_account");
  }

  dropUserData(String table)async{
    return await repository.dropTable(table);
  }



}