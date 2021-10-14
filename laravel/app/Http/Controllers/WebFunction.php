<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Session;
use Illuminate\Support\Facades\URL;
use Illuminate\Support\Facades\DB;

class WebFunction extends Controller
{
  public function addFavorite($propertyId)
  {
    DB::table('favorite')->insert([
      "propertyId" => $propertyId,
      "userId" => Auth::user()->id
    ]);

    Session::flash('success', 'Properti telah ditambahkan ke favorit');
    return redirect()->back();
  }

  public function removeFavorite($propertyId)
  {
    DB::table('favorite')->where([
      "propertyId" => $propertyId,
      "userId" => Auth::user()->id
    ])->delete();

    Session::flash('success', 'Properti telah dihapus dari favorit');
    return redirect()->back();
  }

  public function filterSearch($place, $type)
  {
    $query = DB::table('q_property')->where('address', 'like', '%' . $place . '%');

    if ($type != 'undefined') {
      $query->where('type', $type);
    }

    if ($_GET['filter'] = 'newest') {
      $query->orderBy('date_created', 'desc');
    } else if ($_GET['filter'] = 'cheapest') {
      $query->orderBy('price', 'asc');
    } else if ($_GET['facility'] = 'facility') {
      $query->orderBy('count_facility', 'desc');
    } else {
      $query->orderBy('avg_rating', 'desc');
    }

    $result = $query->get()->toArray();

    $html = '';

    foreach ($result as $data) {
      $html .= '
                <div class="card-hotel">
                    <a class="click-target" href="' . URL::to('detail/' . $data->id . '/' . str_replace(' ', '-', strtolower($data->name))) . '"></a>
                    <div class="place-img w-100">
                      <img src="' . asset('assets/images/' . str_replace(' ', '-', $data->id . '-' . strtolower($data->name) . '/' . $data->image)) . '">
                    </div>
                    <div class="content py-3">
                      <div class="place-description d-flex justify-content-between align-items-start mb-1">
                        <div class="place-info">
                          <div class="place-name">
                            <h6 class="font-weight-bold mb-2">' . $data->name . '</h6>
                          </div>
                          <div class="rating d-flex text-primary">';
      for ($i = 1; $i <= 5; $i++) {
        if ($i <= $data->avg_rating) {
          $html .= '<i class="fa fa-star"></i>';
        } else {
          $html .= '<i class="fa fa-star-o"></i>';
        }
      }

      $html .= '</div>
                        </div>
                        <div class="place-price text-right">
                          <h5 class="mb-1">' . number_format($data->price_month, 0, ',', '.') . '</h5>
                          <p class="no-margin">per bulan</p>
                        </div>
                      </div>
                      <div class="place-location">
                        <h6 class="no-margin"><i class="fa fa-map-marker mr-2"></i>' . $data->address . '</h6>
                      </div>
                    </div>
                </div>
            ';
    }

    print_r($html);
  }

  public function addReview(Request $request)
  {
    $userId = Auth::user()->id;

    DB::table('review')->upsert([
      "date" => date('Y-m-d'),
      "userId" => $userId,
      "propertyId" => $request->propertyId,
      "rating" => $request->rating,
      "review" => $request->review,
    ], ['userId', 'propertyId'], ['date', 'rating', 'review']);

    Session::flash('success', 'Review telah ditambahkan');
    return redirect()->back();
  }

  public function payDay(Request $request)
  {
    $users = DB::table('users')->where('id', Auth::user()->id)->first();

    if ($users->balance < $request->price) {
      Session::flash('error', 'Saldo anda tidak cukup');
      return redirect()->back();
    }

    $balance_left = $users->balance - $request->price;

    $bookingId = DB::table('booking')->insertGetId([
      'userId' => Auth::user()->id,
      'propertyId' => $request->propertyId,
      'date' => date('Y-m-d'),
      'status' => 0
    ]);

    DB::table('bill')->insert([
      'userId' => Auth::user()->id,
      'propertyId' => $request->propertyId,
      'date' => date('Y-m-d', strtotime('+' . $request->duration . ' day')),
      'price' => $request->price,
      'status' => 1,
      'bookingId' => $bookingId
    ]);

    DB::table('users')->where('id', Auth::user()->id)->update([
      "balance" => $balance_left
    ]);

    Session::flash('data', 'sewa');
    Session::flash('success', 'Booking berhasil mohon menunggu persetujuan pemilik properti');
    return redirect(URL::to('account'));
  }

  public function payMonth(Request $request)
  {
    $users = DB::table('users')->where('id', Auth::user()->id)->first();
    $duration = $request->duration;

    if ($users->balance < $request->price) {
      Session::flash('error', 'Saldo anda tidak cukup');
      return redirect()->back();
    }

    $balance_left = $users->balance - $request->price;

    $bookingId = DB::table('booking')->insertGetId([
      'userId' => Auth::user()->id,
      'propertyId' => $request->propertyId,
      'date' => date('Y-m-d'),
      'status' => 0
    ]);

    for ($i = 0; $i < $duration; $i++) {
      $date = date('Y-m-d', strtotime('+' . $i . ' month'));
      $insert = [
        'userId' => Auth::user()->id,
        'propertyId' => $request->propertyId,
        'date' => $date,
        'price' => $request->price,
        'bookingId' => $bookingId
      ];

      if ($i == 0) {
        $insert['status'] = 1;
      } else {
        $insert['status'] = 0;
      }

      DB::table('bill')->insert($insert);
    }

    DB::table('users')->where('id', Auth::user()->id)->update([
      "balance" => $balance_left
    ]);

    Session::flash('data', 'sewa');
    Session::flash('success', 'Booking berhasil mohon menunggu persetujuan pemilik properti');
    return redirect(URL::to('account'));
  }

  public function payYear(Request $request)
  {
    $users = DB::table('users')->where('id', Auth::user()->id)->first();
    $duration = $request->duration;
    $year = $request->year;
    $price =  $request->price;

    if ($users->balance < $price) {
      Session::flash('error', 'Saldo anda tidak cukup');
      return redirect()->back();
    }

    $balance_left = $users->balance - $price;

    $bookingId = DB::table('booking')->insertGetId([
      'userId' => Auth::user()->id,
      'propertyId' => $request->propertyId,
      'date' => date('Y-m-d'),
      'status' => 0
    ]);

    for ($i = 0; $i < 12 * $year; $i++) {
      $date = date('Y-m-d', strtotime('+' . $i . ' month'));

      if ($i % $duration == 0) {
        $insert = [
          'userId' => Auth::user()->id,
          'propertyId' => $request->propertyId,
          'date' => $date,
          'price' => $request->price,
          'bookingId' => $bookingId
        ];

        if ($i == 0) {
          $insert['status'] = 1;
        } else {
          $insert['status'] = 0;
        }

        DB::table('bill')->insert($insert);
      }
    }

    DB::table('users')->where('id', Auth::user()->id)->update([
      "balance" => $balance_left
    ]);

    Session::flash('data', 'sewa');
    Session::flash('success', 'Booking berhasil mohon menunggu persetujuan pemilik properti');
    return redirect(URL::to('account'));
  }

  public function payBill($billId)
  {
    $bill = DB::table('bill')->where('id', $billId)->where('userId', Auth::user()->id)->first();
    $users = DB::table('users')->where('id', Auth::user()->id)->first();

    if ($users->balance < $bill->price) {
      Session::flash('data', 'tagihan');
      Session::flash('error', 'Saldo anda tidak cukup');
      return redirect()->back();
    }

    $balance_left = $users->balance - $bill->price;

    DB::table('users')->where('id', Auth::user()->id)->update([
      "balance" => $balance_left
    ]);

    DB::table('bill')->where('id', $billId)->update(['status' => 1]);

    Session::flash('data', 'tagihan');
    Session::flash('success', 'Pembayaran tagihan berhasil');
    return redirect(URL::to('account'));
  }

  public function topupBalance(Request $request)
  {
    \Midtrans\Config::$serverKey = 'SB-Mid-server-zF2jvA9m2dmnatNsgA7VQgqX';
    \Midtrans\Config::$isProduction = false;
    \Midtrans\Config::$isSanitized = true;
    \Midtrans\Config::$is3ds = true;

    $data = [
      "transaction_details" => [
        "order_id" => time(),
        "gross_amount" => $request->balance
      ],

      "item_details" => [
        [
          "id" => time(),
          "price" => $request->balance,
          "quantity" => 1,
          "name" => "Topup Saldo"
        ]
      ],

      "customer_details" => [
        "first_name" => Auth::user()->name,
        "email" => Auth::user()->email,
        "phone" => Auth::user()->phone
      ]
    ];

    $snapToken = \Midtrans\Snap::getSnapToken($data);
    print_r($snapToken);
  }

  public function addBalance($balance)
  {
    $users = DB::table('users')->where('id', Auth::user()->id)->first();
    DB::table('users')->where('id', Auth::user()->id)->update([
      'balance' => $users->balance + $balance,
    ]);
  }

  public function getUserInfo($id)
  {
    $user = DB::table('users')->where('id', $id)->first();
    return response()->json($user);
  }

  public function uploadImageMultiple(Request $req)
  {
    $id = $req->propertyId;
    $file = $req->file('images');

    $property = DB::table('property')->where('id', $id)->first();
    $path  = str_replace(' ', '-', $property->id . '-' . strtolower($property->name) . '/');
    $tujuan_upload = 'public/assets/images/' . $path;
    $rand = rand(9999, 99999);
    $file->move($tujuan_upload, $rand . '.' . $file->getClientOriginalExtension());
    DB::table('image')->where('id', $property->id)->insert([
      'propertyId' => $property->id,
      'image' => $rand . '.' . $file->getClientOriginalExtension()
    ]);

    $getCurrentImage = DB::table('image')
      ->where('image',  $rand . '.' . $file->getClientOriginalExtension())
      ->where('propertyId', $id)
      ->first();
    $resImage = $rand . '.' . $file->getClientOriginalExtension();
    $folderName = str_replace(' ', '-', $property->id . '-' . strtolower($property->name));
    $idImage = $getCurrentImage->id;
    return response()->json(['imageName' => $resImage, 'path' => $folderName, 'id' => $idImage]);
  }

  public function deleteImage($imageId){
    DB::table('image')->where('id', $imageId)->delete();
    return response()->json([
      'message' => 'success'
    ]);
  }

  public function getImages($propertyId){
    $property = DB::table('property')->where('id', $propertyId)->first();
    $folderName = str_replace(' ', '-', $property->id . '-' . strtolower($property->name));
    $image = DB::table('image')->where('propertyId', $propertyId)->get();
    return response()->json([
      'path' => $folderName,
      'images' => $image
    ]);
  }
}
