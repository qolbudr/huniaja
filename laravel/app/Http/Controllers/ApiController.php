<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Validator;
use Hash;
use Session;
use App\Models\User;
use Illuminate\Support\Facades\DB;

class ApiController extends Controller
{
    public function login(Request $request)
    {
        $rules = [
            'email'                 => 'required|email',
            'password'              => 'required|string'
        ];
  
        $messages = [
            'email.required'        => 'Email wajib diisi',
            'email.email'           => 'Email tidak valid',
            'password.required'     => 'Password wajib diisi',
            'password.string'       => 'Password harus berupa string'
        ];
  
        $validator = Validator::make($request->all(), $rules, $messages);
  
        if($validator->fails()){
            $data = $validator->messages()->toArray();
            $output = "";

            foreach($data as $k => $v) {
                $output = str_replace(['[', ']'], ['', ''], $v[0]);
                break;
            } 
            return response()->json(['message' => $output], 500);
        }

        $data = [
            'email' => $request->email,
            'password' => $request->password
        ];
 
        if (auth()->attempt($data)) {
            $token = auth()->user()->createToken('LaravelAuthApp')->accessToken;
            return response()->json(['token' => $token, 'user' => auth()->user()], 200);
        } else {
            return response()->json(['message' => 'Login gagal email/password salah'], 401);
        }
    }

    public function getUserData($id) {
        $user = DB::table('users')->where('id', $id)->first();
        return response()->json(['user' => $user], 200);
    }

    public function validateRegisterForm(Request $request) {
        $rules = [
            'name'                  => 'required|min:6|max:35',
            'email'                 => 'required|email|unique:users,email',
            'password'              => 'required|min:6|confirmed',
            'role'                  => 'required',
        ];
  
        $messages = [
            'name.required'         => 'Nama Lengkap wajib diisi',
            'name.min'              => 'Nama lengkap minimal 6 karakter',
            'name.max'              => 'Nama lengkap maksimal 35 karakter',
            'email.required'        => 'Email wajib diisi',
            'email.email'           => 'Email tidak valid',
            'email.unique'          => 'Email sudah terdaftar',
            'password.min'          => 'Password minimal 6 karakter',
            'password.required'     => 'Password wajib diisi',
            'password.confirmed'    => 'Password tidak sama dengan konfirmasi password',
            'role.required'         => 'Pilih role anda',
        ];

        $validator = Validator::make($request->all(), $rules, $messages);

        if($validator->fails()){
            $data = $validator->messages()->toArray();
            $output = "";

            foreach($data as $k => $v) {
                $output = str_replace(['[', ']'], ['', ''], $v[0]);
                break;
            } 
            return response()->json(['message' => $output], 500);
        } else {
            return response()->json(['message' => 'Validasi sukses'], 200);
        }
    }

    public function register(Request $request) {
        $user = new User;
        $user->name = ucwords(strtolower($request->name));
        $user->email = strtolower($request->email);
        $user->password = Hash::make($request->password);
        $user->email_verified_at = \Carbon\Carbon::now();
        $user->role = $request->role;
        $user->face = $request->face;
        $simpan = $user->save();

  
        if($simpan){
            return response()->json(['message' => 'Registrasi berhasil silahkan login'], 200);
        } else {
            return response()->json(['message' => 'Registrasi gagal silahkan ulangi lagi'], 500);
        }
    }

    public function getProperty(Request $request) {
        $house = DB::table('q_property')->get();
        return response()->json(['message' => 'Fetching data berhasil', 'property' => $house], 200);
    }

    public function filterSearch($place, $type) {
        $query = DB::table('q_property')->where('address', 'like', '%'.$place.'%');

        if($type != 'undefined') {
            $query->where('type', $type);
        }

        if($_GET['filter'] = 'newest') {
            $query->orderBy('date_created', 'desc');
        } else if ($_GET['filter'] = 'cheapest') {
            $query->orderBy('price', 'asc');
        } else if ($_GET['facility'] = 'facility') {
            $query->orderBy('count_facility', 'desc');
        } else {
            $query->orderBy('avg_rating', 'desc');
        }

        $result = $query->get();
        return response()->json(['message' => 'Fetching data berhasil', 'property' => $result], 200);
    }

    public function getFavorite($userId) {
        $result = DB::table('favorite')->select('q_property.*')->join('q_property', 'favorite.propertyId', '=', 'q_property.id')->where('favorite.userId', $userId)->get();
        return response()->json(['message' => 'Fetching data berhasil', 'property' => $result], 200);
    }

    public function getPropertyPhoto($propertyId) {
        $result = DB::table('image')->where('propertyId', $propertyId)->get();
        return response()->json(['message' => 'Fetching data berhasil', 'property' => $result], 200);
    }

    public function getFacility($propertyId) {
        $result = DB::table('q_facility')->where('propertyId', $propertyId)->get();
        return response()->json(['message' => 'Fetching data berhasil', 'facility' => $result], 200);
    }

    public function getReview($propertyId) {
        $result = DB::table('q_review')->where('propertyId', $propertyId)->get();
        return response()->json(['message' => 'Fetching data berhasil', 'review' => $result], 200);
    }

    public function payDay(Request $request) {
        $user = DB::table('users')->where('id', $request->userId)->first();
        $property = DB::table('property')->where('id', $request->propertyId)->first();
        $duration = $request->duration;


        if($user->balance < $property->price_day * $duration) {
            return response()->json(['message' => "Saldo anda tidak cukup untuk memesan property"], 500);
        }

        $balance_left = $user->balance - $property->price_day * $duration;

        $bookingId = DB::table('booking')->insertGetId([
            'userId' => $user->id,
            'propertyId' => $request->propertyId,
            'date' => date('Y-m-d'),
            'status' => 0
        ]);

        DB::table('bill')->insert([
            'userId' => $user->id,
            'propertyId' => $request->propertyId,
            'date' => date('Y-m-d', strtotime('+'.$duration.' day')),
            'price' => $property->price_day * $duration,
            'status' => 1,
            'bookingId' => $bookingId
        ]);

        DB::table('users')->where('id', $user->id)->update([
            "balance" => $balance_left
        ]);

        return response()->json(['message' => "Booking berhasil menunggu persetujuan pemilik"], 200);
    }

    public function payMonth(Request $request) {
      $users = DB::table('users')->where('id', $request->userId)->first();
      $property = DB::table('property')->where('id', $request->propertyId)->first();
      $duration = (int) $request->duration;
      $price = (int) $request->price;

      if($users->balance < $price) {
        return response()->json(['message' => "Saldo anda tidak cukup untuk memesan property"], 500);
      }

      $balance_left = $users->balance - $price;

      $bookingId = DB::table('booking')->insertGetId([
        'userId' => $users->id,
        'propertyId' => $request->propertyId,
        'date' => date('Y-m-d'),
        'status' => 0
      ]);

      for($i = 0; $i < $duration; $i++) {
        $date = date('Y-m-d', strtotime('+'.$i.' month'));
        $insert = [
          'userId' => $users->id,
          'propertyId' => $request->propertyId,
          'date' => $date,
          'price' => $price,
          'bookingId' => $bookingId
        ];

        if($i == 0) {
          $insert['status'] = 1;
        } else {
          $insert['status'] = 0;
        }

        DB::table('bill')->insert($insert);
      }

      DB::table('users')->where('id', $users->id)->update([
        "balance" => $balance_left
      ]);

      return response()->json(['message' => "Booking berhasil menunggu persetujuan pemilik"], 200);
    } 

    public function payYear(Request $request) {
      $users = DB::table('users')->where('id', Auth::user()->id)->first();
      $property = DB::table('property')->where('id', $request->propertyId)->first();
      $duration = $request->duration == "penuh" ? 1 : (int) $request->duration;
      $year = (int) $request->year;
      $price =  (int) $request->price;

      if($users->balance < $price) {
        return response()->json(['message' => "Saldo anda tidak cukup untuk memesan property"], 500);
      }

      $balance_left = $users->balance - $price;

      $bookingId = DB::table('booking')->insertGetId([
        'userId' => $users->id,
        'propertyId' => $request->propertyId,
        'date' => date('Y-m-d'),
        'status' => 0
      ]);

      for($i = 0; $i < 12 * $year; $i++) {
        $date = date('Y-m-d', strtotime('+'.$i.' month'));

        if($i % $duration == 0) {
          $insert = [
            'userId' => $users->id,
            'propertyId' => $request->propertyId,
            'date' => $date,
            'price' => $request->price,
            'bookingId' => $bookingId
          ];

          if($i == 0) {
            $insert['status'] = 1;
          } else {
            $insert['status'] = 0;
          }

          DB::table('bill')->insert($insert);
        }
      }

      DB::table('users')->where('id', $users->id)->update([
        "balance" => $balance_left
      ]);

      return response()->json(['message' => "Booking berhasil menunggu persetujuan pemilik"], 200);
    }

    public function updateUserAccount(Request $request) {
        $userId = $request->userId;

        $rules = [
            'name'                  => 'required|min:6|max:15',
            'email'                 => 'required|email|unique:users,email,'.$userId,
            'dob'                   => 'required',
            'address'               => 'required',
            'phone'                 => 'required|numeric|min:12'
        ];
  
        $messages = [
            'name.required'         => 'Nama Lengkap wajib diisi',
            'name.min'              => 'Nama lengkap minimal 6 karakter',
            'name.max'              => 'Nama lengkap maksimal 15 karakter',
            'email.required'        => 'Email wajib diisi',
            'email.email'           => 'Email tidak valid',
            'email.unique'          => 'Email sudah terdaftar',
            'dob.required'          => 'Tanggal lahir harus diisi',
            'address.required'      => 'Alamat harus diisi',
            'phone.required'        => 'Telepon harus diisi',
            'phone.min'             => 'Telepon minimal 12 karakter',
            'phone.numeric'         => 'Telepon harus angka',
        ];

        $validator = Validator::make($request->all(), $rules, $messages);
  
        if($validator->fails()){
            $data = $validator->messages()->toArray();
            $output = "";

            foreach($data as $k => $v) {
                $output = str_replace(['[', ']'], ['', ''], $v[0]);
                break;
            } 
            return response()->json(['message' => $output], 500);
        }

        $data = [
            "name" => $request->name,
            "email" => $request->email,
            "dob" => $request->dob,
            "phone" => $request->phone,
            "address" => $request->address
        ];

        $data = DB::table('users')->where('id', $userId)->update($data);
        $users = DB::table('users')->where('id', $userId)->first();
        return response()->json(['message' => "User berhasil diupdate", "user" => $users], 200);
    }

    public function getBooking(Request $req) {
        $userId = $req->userId;
        $data = DB::table('q_booking')->where('userId', $userId)->first();
        return response()->json(['message' => "Fetching data berhasil", "booking" => $data], 200);
    }

    public function getBill($userId) {
        $data = DB::table('q_bill')->where('userId', $userId)->get();
        // dd($data);
        return response()->json(['message' => "Fetching data berhasil", "bill" => $data], 200);
    }

    public function topupBalance(Request $req) {
      \Midtrans\Config::$serverKey = 'SB-Mid-server-zF2jvA9m2dmnatNsgA7VQgqX';
      \Midtrans\Config::$isProduction = false;
      \Midtrans\Config::$isSanitized = true;
      \Midtrans\Config::$is3ds = true;

      $users = DB::table('users')->where('id', $req->userId)->first();

      $data = [
        "transaction_details" => [
          "order_id" => time(),
          "gross_amount" => 5
        ],

        "item_details" => [
          [
            "id" => time(),
            "price" => $req->price,
            "quantity" => 1,
            "name" => "Topup Saldo"
          ]
        ],

        "customer_details" => [
          "first_name" => $users->name,
          "email" => $users->email,
          "phone" => $users->phone
        ]
      ];

      $snapToken = \Midtrans\Snap::createTransaction($data)->redirect_url;
      return $snapToken;
    }

    // public function payBill(Request $req) {
    //     $userId = $req->userId;
    //     $bill = DB::table('bill')->where('id', $billId)->where('userId', Auth::user()->id)->first();

    //     if($users->balance < $bill->price) {
    //         Session::flash('data', 'tagihan');
    //         Session::flash('error', 'Saldo anda tidak cukup');
    //         return redirect()->back();
    //     }

    //     $balance_left = $users->balance - $bill->price;

    //     DB::table('users')->where('id', Auth::user()->id)->update([
    //         "balance" => $balance_left
    //     ]);

    //     DB::table('bill')->where('id', $billId)->update(['status' => 1]);

    //     Session::flash('data', 'tagihan');
    //     Session::flash('success', 'Pembayaran tagihan berhasil');
    //     return redirect(URL::to('account'));
    // }   
}
