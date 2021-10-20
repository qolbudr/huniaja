import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:manpro/config/app.dart';
import 'package:manpro/model/ImageProperty.dart';
import 'package:manpro/model/auth_login.dart';
import 'package:manpro/model/facility.dart';
import 'package:manpro/model/facilityProperty.dart';
import 'package:manpro/model/image_picker.dart';
import 'package:manpro/model/list_property.dart';
import 'package:manpro/model/location_item.dart';
import 'package:manpro/model/hotel_photo.dart';
import 'package:manpro/model/owner_booking.dart';
import 'package:manpro/model/propertyDetails.dart';
import 'package:manpro/model/propertyOwner.dart';
import 'package:manpro/model/review.dart';
import 'package:manpro/model/user.dart';
import 'package:manpro/model/booking.dart';
import 'package:manpro/model/income.dart';

class ApiService  {
  static final _apiURL = apiURL;

  Future<AuthLogin> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(_apiURL + '/api/login'),
      body: {
        'email': email,
        'password': password
      }
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    if(response.statusCode == 200) {
      return AuthLogin.fromJson(data);
    } else {
      return throw data['message'];
    }
  }

  Future<User> getUserData(String id, String token) async {
    final response = await http.get(
      Uri.parse(_apiURL + '/api/user/get/'+ id),
      headers: {
        'Authorization': 'Bearer ' + token,
      }
    );

    Map<String, dynamic> data = jsonDecode(response.body);
    if(response.statusCode == 200) {
      return User.fromJson(data['user']);
    } else {
      return throw data['message'];
    }
  }

  Future<String> validateRegisterForm(
    String name,
    String email, 
    String password, 
    String password_confirmation,
    String role
  ) async {
    final response = await http.post(
      Uri.parse(_apiURL + '/api/register/validate'),
      body: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password_confirmation,
        'role': role
      }
    );
    Map<String, dynamic> data = jsonDecode(response.body);

    if(response.statusCode == 200) {
      return data['message'];
    } else {
      return throw data['message'];
    }
  }

  Future<String> registerUser(
    String name,
    String email, 
    String password, 
    String role,
    String face
  ) async {
    final response = await http.post(
      Uri.parse(_apiURL + '/api/register'),
      body: {
        'name': name,
        'email': email,
        'password': password,
        'role': role,
        'face': face
      }
    );
    Map<String, dynamic> data = jsonDecode(response.body);

    if(response.statusCode == 200) {
      return data['message'];
    } else {
      return throw data['message'];
    }
  }

  Future<ListProperty> getListProperty(String token) async {
    final response = await http.get(
      Uri.parse(_apiURL + '/api/property/get'),
      headers: {
        'Authorization': 'Bearer ' + token,
      }
    );

    Map<String, dynamic> data = jsonDecode(response.body);
    if(response.statusCode == 200) {
      return ListProperty.fromJson(data);
    } else {
      return throw 'Failed to fetch list Property';
    }
  }

  Future<LocationItem> getLocationItem(String location) async {
    final response = await http.get(
      Uri.parse('https://mamikos.com/garuda/suggest?q=' + location)
    );
    Map<String, dynamic> data = jsonDecode(response.body);

    if(response.statusCode == 200) {
      return LocationItem.fromJson(data);
    } else {
      return throw 'Failed to fetch Location Item';
    }
  }

  Future<ListProperty> getSearchFilter(String token, String place, String type, String filter) async {
    final response = await http.get(
      Uri.parse(_apiURL + "/api/property/filter/$place/$type?filter=$filter"),
      headers: {
        'Authorization': 'Bearer ' + token,
      }
    );
    Map<String, dynamic> data = jsonDecode(response.body);

    if(response.statusCode == 200) {
      return ListProperty.fromJson(data);
    } else {
      return throw 'Failed to fetch list Property';
    }
  }

  Future<ListProperty> getFavorite(String token, int userId) async {
    final response = await http.get(
      Uri.parse(_apiURL + "/api/property/favorite/$userId"),
      headers: {
        'Authorization': 'Bearer ' + token,
      }
    );
    Map<String, dynamic> data = jsonDecode(response.body);

    if(response.statusCode == 200) {
      return ListProperty.fromJson(data);
    } else {
      return throw 'Failed to fetch list Property';
    }
  }

  Future<PropertyPhoto> getPhoto(String token, int propertyId) async {
    final response = await http.get(
      Uri.parse(_apiURL + "/api/property/getPhoto/$propertyId"),
      headers: {
        'Authorization': 'Bearer ' + token,
      }
    );
    Map<String, dynamic> data = jsonDecode(response.body);

    if(response.statusCode == 200) {
      return PropertyPhoto.fromJson(data);
    } else {
      return throw 'Failed to fetch list Photo';
    }
  }

  Future getPropertyFacility(String token, int propertyId) async {
    final response = await http.get(
      Uri.parse(_apiURL + "/api/property/getFacility/$propertyId"),
      headers: {
        'Authorization': 'Bearer ' + token,
      }
    );
    Map<String, dynamic> data = jsonDecode(response.body);

    if(response.statusCode == 200) {
      return data;
    } else {
      return throw 'Failed to fetch list Facility';
    }
  }

  Future<ReviewClass> getReview(String token, int propertyId) async {
    final response = await http.get(
      Uri.parse(_apiURL + "/api/property/getReview/$propertyId"),
      headers: {
        'Authorization': 'Bearer ' + token,
      }
    );
    Map<String, dynamic> data = jsonDecode(response.body);

    if(response.statusCode == 200) {
      return ReviewClass.fromJson(data);
    } else {
      return throw 'Failed to fetch list Review';
    }
  }

  Future<dynamic> payDay(String token, String userId, String propertyId, String duration) async {
    final response = await http.post(
      Uri.parse(_apiURL + "/api/property/pay/day"),
      headers: {
        'Authorization': 'Bearer ' + token,
      },
      body: {
        "duration": duration,
        "userId": userId,
        "propertyId": propertyId
      }
    );
    Map<String, dynamic> data = jsonDecode(response.body);

    if(response.statusCode == 200) {
      return data['message'];
    } else {
      return throw data['message'];
    }
  }

  Future<dynamic> payMonth(String token, String userId, String propertyId, dynamic duration, dynamic price) async {
    final response = await http.post(
      Uri.parse(_apiURL + "/api/property/pay/month"),
      headers: {
        'Authorization': 'Bearer ' + token,
      },
      body: {
        "duration": duration,
        "userId": userId,
        "propertyId": propertyId,
        "price": price
      }
    );
    Map<String, dynamic> data = jsonDecode(response.body);

    if(response.statusCode == 200) {
      return data['message'];
    } else {
      return throw data['message'];
    }
  }

  Future<dynamic> payYear(String token, String year, String userId, String propertyId, dynamic duration, dynamic price) async {
    final response = await http.post(
      Uri.parse(_apiURL + "/api/property/pay/year"),
      headers: {
        'Authorization': 'Bearer ' + token,
      },
      body: {
        "duration": duration,
        "userId": userId,
        "propertyId": propertyId,
        "price": price,
        "year": year
      }
    );
    Map<String, dynamic> data = jsonDecode(response.body);

    if(response.statusCode == 200) {
      return data['message'];
    } else {
      return throw data['message'];
    }
  }

  Future<User> updateUser(token, userId, name, email, dob, address, phone) async {
    final response = await http.post(
      Uri.parse(_apiURL + "/api/user/update"),
      headers: {
        'Authorization': 'Bearer ' + token,
      },
      body: {
        "userId": userId,
        "name": name,
        "email": email,
        "dob": dob,
        "address": address,
        "phone": phone,
      }
    );

    Map<String, dynamic> data = jsonDecode(response.body);

    if(response.statusCode == 200) {
      return User.fromJson(data['user']);
    } else {
      return throw data['message'];
    }
  }

  Future<dynamic> getBill(token, userId) async {

    final response = await http.get(
      Uri.parse(_apiURL + "/api/bill/get/"+ userId),
      headers: {
        'Authorization': 'Bearer ' + token,
      },
    );

    Map<String, dynamic> data = jsonDecode(response.body);
    if(response.statusCode == 200) {
      return data['bill'];
    } else {
      return throw data['message'];
    }
  }

  Future<String> getPayURL(token, userId, price) async {
    final response = await http.post(
      Uri.parse(_apiURL + "/api/saldo/topup"),
      headers: {
        'Authorization': 'Bearer ' + token,
      },
      body: {
        'userId': userId.toString(),
        'price': price
      }
    );

    print(response.body);

    String data = response.body;
    if(response.statusCode == 200) {
      return data;
    } else {
      return throw "failed";
    }
  }

  Future<BookingData> getBookingData(token, userId) async {
    final response = await http.post(
      Uri.parse(_apiURL + "/api/booking/get"),
      headers: {
        'Authorization': 'Bearer ' + token,
      },
      body: {
        'userId': userId.toString(),
      }
    );

    if(response.statusCode == 200) {
      BookingData booking = bookingDataFromJson(response.body);
      return booking;
    } else {
      return throw "Failed to fetch booking data";
    }
  }

  Future getReviewId(token, userId, propertyId) async {
    final response = await http.get(
      Uri.parse(_apiURL + "/api/review/get/$userId/$propertyId"),
      headers: {
        'Authorization': 'Bearer ' + token,
      },
    );

    if(response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      return throw "Failed to fetch booking data";
    }
  }

  Future addReview(token, userId, propertyId, review, rating) async {
    final response = await http.post(
      Uri.parse(_apiURL + "/api/review/add"),
      headers: {
        'Authorization': 'Bearer ' + token,
      },
      body: {
        "userId": userId.toString(),
        "review": review,
        "rating": rating,
        "propertyId": propertyId.toString(),
      },
    );

    // print(response.body);

    if(response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      return throw "Failed to add a review";
    }
  }

  Future changePassword(token, userId, current_password, password, password_confirmation) async {
    final response = await http.post(
      Uri.parse(_apiURL + "/api/user/changePassword"),
      headers: {
        'Authorization': 'Bearer ' + token,
      },
      body: {
        "userId": userId.toString(),
        "password": password,
        "current_password": current_password,
        "password_confirmation": password_confirmation,
      },
    );

    // print(response.body);

    Map<String, dynamic> data = jsonDecode(response.body);

    if(response.statusCode == 200) {
      return data['message'];
    } else {
      return throw data['message'];
    }
  }

  Future<ListProperty> getOwnerProperty(token, userId) async {
    final response = await http.post(
      Uri.parse(_apiURL + "/api/owner/property/get"),
      headers: {
        'Authorization': 'Bearer ' + token,
      },
      body: {
        "userId": userId.toString(),
      },
    );


    Map<String, dynamic> data = jsonDecode(response.body);
    if(response.statusCode == 200) {
      return ListProperty.fromJson(data);
    } else {
      return throw data['message'];
    }
  }

  Future<OwnerListBook> getOwnerBooking(token, userId) async {
    final response = await http.post(
      Uri.parse(_apiURL + "/api/owner/booking/get"),
      headers: {
        'Authorization': 'Bearer ' + token,
      },
      body: {
        "userId": userId.toString(),
      },
    );

    Map<String, dynamic> data = jsonDecode(response.body);

    if(response.statusCode == 200) {
      return OwnerListBook.fromJson(data);
    } else {
      return throw data['message'];
    }
  }

  Future<List<Facility>> getFacility(token, userId) async {
    final res = await http.get(
      Uri.parse("${_apiURL}/api/property/facility"),
      headers: {
        'Authorization': "Bearer ${token}"
      }
    );
    print(res.body);
    List<dynamic> data = jsonDecode(res.body);
     if(res.statusCode == 200) {
      return (data as List).map((e) => Facility.fromJson(e)).toList();
    } else {
      return throw jsonDecode(res.body)['message'];
    }
  }

  Future<ImagePickerApp> uploadImage(File file, token, propertyId, userId) async {
    print("hit");
    var request = http.MultipartRequest("POST", Uri.parse("${_apiURL}/api/property/image/upload"));
    final img = await http.MultipartFile.fromPath("images", file.path);
    request.headers['Authorization'] = "Bearer ${token}";
    request.fields['userId'] = userId.toString();
    request.fields['propertyId'] = propertyId.toString();
    request.files.add(img);
    final res = await request.send();
    final resData = await res.stream.toBytes();
    final resBody = String.fromCharCodes(resData);
    print(resBody);
    if(res.statusCode == 200){
      Map<String, dynamic> jsonbody = jsonDecode(resBody);
      return ImagePickerApp.fromJson(jsonbody);
    }else{
      return throw jsonDecode(resBody)['message'];
    }
  }

  Future<void> deleteImage(imageId, token) async {
    print("hit");
    final res = await http.post(Uri.parse("${_apiURL}/api/property/image/${imageId}/delete"), headers: {
      'Authorization': "Bearer ${token}"
    });
    print(res.body);
  }

  Future<Map<String, dynamic>> triggerFacility(facilityid, propertyId,token, userId)async{
    final res = await http.post(Uri.parse("${_apiURL}/api/owner/property/${propertyId}/updateFacility"), headers: {
      'Authorization': "Bearer ${token}"
    },
    body: {
      "facilityId": facilityid  
    });

    if(res.statusCode == 200){
      return jsonDecode(res.body);
    }else{
      return throw jsonDecode(res.body)['message'];
    }
  }

  Future insertProperty({token, userId, name, description, address, latitude, longitude, vrooms, priceMonth, priceDay, priceYear, type}) async {
    final response = await http.post(
      Uri.parse(_apiURL + "/api/owner/property/insert"),
      headers: {
        'Authorization': 'Bearer ' + token,
      },
      body: {
        "userId": userId.toString(),
        'name': name,       
        'description': description, 
        'address': address,
        'latitude': latitude,
        'longitude': longitude,  
        'price_day': priceDay, 
        'price_month': priceMonth,
        'price_year': priceYear,
        'vrooms': vrooms,
        'type': type,
      },
    );

    Map<String, dynamic> data = jsonDecode(response.body);

    if(response.statusCode == 200) {
      return data;
    } else {
      return throw data['message'];
    }
  }

  
    Future<PropertyDetails> getPropertyDetails(String token, int propertyId) async {
    final res = await http.get(Uri.parse("$_apiURL/api/owner/property/$propertyId/details"));
    Map<String, dynamic> body = jsonDecode(res.body);

    if(res.statusCode == 200){
    List<ImageProperty> images = (body['image']['images'] as List).map((e) => ImageProperty.fromJson(e)).toList();
      
    PropertyOwner property = PropertyOwner.fromJson(body['property']);
    List<FacilityProperty> facility = (body['facility'] as List).map((e) => FacilityProperty.fromJson(e)).toList();
    List<Facility> facilityList = (body['facilityList'] as List).map((e) => Facility.fromJson(e)).toList();
    Images img = Images(path: body['image']['path'], imageProperty: images);
    PropertyDetails _property = PropertyDetails(propertyOwner: property,facility: facility, facilityList: facilityList, img: img);
    return _property;
    }else{
      return throw body['message'];
    }
  }

    Future updateProperty({token, userId, propertyId, name, description, address, latitude, longitude, vrooms, priceMonth, priceDay, priceYear, type}) async {
    final response = await http.post(
      Uri.parse(_apiURL + "/api/owner/property/$propertyId/update"),
      headers: {
        'Authorization': 'Bearer ' + token,
      },
      body: {
        "userId": userId.toString(),
        'name': name,       
        'description': description, 
        'address': address,
        'latitude': latitude,
        'longitude': longitude,  
        'price_day': priceDay, 
        'price_month': priceMonth,
        'price_year': priceYear,
        'vrooms': vrooms,
        'type': type,
      },
    );

    Map<String, dynamic> data = jsonDecode(response.body);

    if(response.statusCode == 200) {
      return data;
    } else {
      return throw data['message'];
    }
  }
  
  Future<List<Income>> getIncome(token, userId) async {
    final response = await http.post(
      Uri.parse(_apiURL + "/api/owner/income/get"),
      headers: {
        'Authorization': 'Bearer ' + token,
      },
      body: {
        "userId": userId.toString(),
      },
    );

    if(response.statusCode == 200) {
      return incomeFromJson(response.body);
    } else {
      return throw 'Failed to fetch income';
    }
  } 
  
  Future requestWithdraw(token, userId, amount, description) async {
    final response = await http.post(
      Uri.parse(_apiURL + "/api/owner/withdraw/insert"),
      headers: {
        'Authorization': 'Bearer ' + token,
      },
      body: {
        "userId": userId.toString(),
         "amount": amount,
        "description": description
      },
    );

    if(response.statusCode != 200) {
      return throw 'Failed to withdraw';
    }
  }
}