<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ApiController;
use App\Http\Controllers\AdminController;
use App\Http\Controllers\WebFunction;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

/*MOBILE ROUTE*/
Route::post('/login', [ApiController::class, 'login']);
Route::post('/register/validate', [ApiController::class, 'validateRegisterForm']);
Route::post('/register', [ApiController::class, 'register']);
Route::get('/property/facility', [WebFunction::class, 'getFacility']);
Route::get('/owner/property/{propertyId}/details', [ApiController::class, 'getPropertyDetails']);


Route::group(['middleware' => 'auth:api'], function() {
    Route::get('/user/get/{id}', [ApiController::class, 'getUserData']);
    
    Route::post('/user/update', [ApiController::class, 'updateUserAccount']);
    Route::post('/user/changePassword', [ApiController::class, 'changePassword']);
    
    Route::get('/property/get', [ApiController::class, 'getProperty']);
    Route::get('/property/filter/{place}/{type}', [ApiController::class, 'filterSearch']);
    Route::get('/property/favorite/{userId}', [ApiController::class, 'getFavorite']);
    Route::get('/property/getPhoto/{propertyId}', [ApiController::class, 'getPropertyPhoto']);
    Route::get('/property/getFacility/{propertyId}', [ApiController::class, 'getFacility']);
    Route::get('/property/getReview/{propertyId}', [ApiController::class, 'getReview']);
    Route::post('/property/image/upload', [WebFunction::class, 'uploadImageMultiple']);
    Route::post('/property/image/{imageId}/delete', [WebFunction::class, 'deleteImage']);
    
    Route::post('/property/pay/day', [ApiController::class, 'payDay']);
    Route::post('/property/pay/month', [ApiController::class, 'payMonth']);
    Route::post('/property/pay/year', [ApiController::class, 'payYear']);

    Route::get('/bill/get/{id}', [ApiController::class, 'getBill']);
    Route::get('/review/get/{id}/{propertyId}', [ApiController::class, 'getReviewId']);
    Route::post('/review/add', [ApiController::class, 'addReview']);

    Route::post('/saldo/topup', [ApiController::class, 'topupBalance']);
    Route::post('/booking/get', [ApiController::class, 'getBookingData']);
    Route::post('/owner/property/get', [ApiController::class, 'getOwnerProperty']);
    Route::post('/owner/property/insert', [ApiController::class, 'insertProperty']);
    Route::post('/owner/property/{propertyId}/update', [ApiController::class, 'updateProperty']);
    
    Route::post('/owner/property/{propertyId}/updateFacility', [ApiController::class, 'updateFacility']);
    Route::post('/owner/booking/get', [ApiController::class, 'getOwnerBook']);
});