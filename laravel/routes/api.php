<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ApiController;

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

Route::group(['middleware' => 'auth:api'], function() {
    Route::get('/user/get/{id}', [ApiController::class, 'getUserData']);
    Route::get('/property/get', [ApiController::class, 'getProperty']);
    Route::get('/property/filter/{place}/{type}', [ApiController::class, 'filterSearch']);
    Route::get('/property/favorite/{userId}', [ApiController::class, 'getFavorite']);
    Route::get('/property/getPhoto/{propertyId}', [ApiController::class, 'getPropertyPhoto']);
    Route::get('/property/getFacility/{propertyId}', [ApiController::class, 'getFacility']);
    Route::get('/property/getReview/{propertyId}', [ApiController::class, 'getReview']);
    Route::post('/property/pay/day', [ApiController::class, 'payDay']);
    Route::post('/property/pay/month', [ApiController::class, 'payMonth']);
    Route::post('/property/pay/year', [ApiController::class, 'payYear']);
});