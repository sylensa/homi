

import 'package:homi/repository/Repository.dart';
import 'package:homi/services/get_user.dart';

class UserAccountController{


  var repository = Repository() ;

  // saveData
  saveUserData(ResponseData responseData) async{
    return await repository.insertData("user_account", responseData.userResponseDataMap());
  }

  // fetchData
  fetchUserData() async{
    return await repository.fetchData("user_account");
  }

  // updateData
  updateUserData(ResponseData responseData) async{
    return await repository.updateData("user_account", responseData.userResponseDataMap());
  }

  // delete products by brand
  deleteUserData()async{
    return await repository.dropTable("user_account");
  }

  dropUserData()async{
    return await repository.dropTable("user_account");
  }



}