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

        if ($validator->fails()) {
            $data = $validator->messages()->toArray();
            $output = "";

            foreach ($data as $k => $v) {
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

    public function getUserData($id)
    {
        $user = DB::table('users')->where('id', $id)->first();
        return response()->json(['user' => $user], 200);
    }

    public function validateRegisterForm(Request $request)
    {
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

        if ($validator->fails()) {
            $data = $validator->messages()->toArray();
            $output = "";

            foreach ($data as $k => $v) {
                $output = str_replace(['[', ']'], ['', ''], $v[0]);
                break;
            }
            return response()->json(['message' => $output], 500);
        } else {
            return response()->json(['message' => 'Validasi sukses'], 200);
        }
    }

    public function register(Request $request)
    {
        $user = new User;
        $user->name = ucwords(strtolower($request->name));
        $user->email = strtolower($request->email);
        $user->password = Hash::make($request->password);
        $user->email_verified_at = \Carbon\Carbon::now();
        $user->role = $request->role;
        $user->face = $request->face;
        $simpan = $user->save();


        if ($simpan) {
            return response()->json(['message' => 'Registrasi berhasil silahkan login'], 200);
        } else {
            return response()->json(['message' => 'Registrasi gagal silahkan ulangi lagi'], 500);
        }
    }

    public function getProperty(Request $request)
    {
        $house = DB::table('q_property')->get();
        return response()->json(['message' => 'Fetching data berhasil', 'property' => $house], 200);
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

        $result = $query->get();
        return response()->json(['message' => 'Fetching data berhasil', 'property' => $result], 200);
    }

    public function getFavorite($userId)
    {
        $result = DB::table('favorite')->select('q_property.*')->join('q_property', 'favorite.propertyId', '=', 'q_property.id')->where('favorite.userId', $userId)->get();
        return response()->json(['message' => 'Fetching data berhasil', 'property' => $result], 200);
    }

    public function getPropertyPhoto($propertyId)
    {
        $result = DB::table('image')->where('propertyId', $propertyId)->get();
        return response()->json(['message' => 'Fetching data berhasil', 'property' => $result], 200);
    }

    public function getFacility($propertyId)
    {
        $result = DB::table('q_facility')->where('propertyId', $propertyId)->get();
        return response()->json(['message' => 'Fetching data berhasil', 'facility' => $result], 200);
    }

    public function getReview($propertyId)
    {
        $result = DB::table('q_review')->where('propertyId', $propertyId)->get();
        return response()->json(['message' => 'Fetching data berhasil', 'review' => $result], 200);
    }

    public function payDay(Request $request)
    {
        $user = DB::table('users')->where('id', $request->userId)->first();
        $property = DB::table('property')->where('id', $request->propertyId)->first();
        $duration = $request->duration;


        if ($user->balance < $property->price_day * $duration) {
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
            'date' => date('Y-m-d', strtotime('+' . $duration . ' day')),
            'price' => $property->price_day * $duration,
            'status' => 1,
            'bookingId' => $bookingId
        ]);

        DB::table('users')->where('id', $user->id)->update([
            "balance" => $balance_left
        ]);

        return response()->json(['message' => "Booking berhasil menunggu persetujuan pemilik"], 200);
    }

    public function payMonth(Request $request)
    {
        $users = DB::table('users')->where('id', $request->userId)->first();
        $property = DB::table('property')->where('id', $request->propertyId)->first();
        $duration = (int) $request->duration;
        $price = (int) $request->price;

        if ($users->balance < $price) {
            return response()->json(['message' => "Saldo anda tidak cukup untuk memesan property"], 500);
        }

        $balance_left = $users->balance - $price;

        $bookingId = DB::table('booking')->insertGetId([
            'userId' => $users->id,
            'propertyId' => $request->propertyId,
            'date' => date('Y-m-d'),
            'status' => 0
        ]);

        for ($i = 0; $i < $duration; $i++) {
            $date = date('Y-m-d', strtotime('+' . $i . ' month'));
            $insert = [
                'userId' => $users->id,
                'propertyId' => $request->propertyId,
                'date' => $date,
                'price' => $price,
                'bookingId' => $bookingId
            ];

            if ($i == 0) {
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

    public function payYear(Request $request)
    {
        $users = DB::table('users')->where('id', Auth::user()->id)->first();
        $property = DB::table('property')->where('id', $request->propertyId)->first();
        $duration = $request->duration == "penuh" ? 1 : (int) $request->duration;
        $year = (int) $request->year;
        $price =  (int) $request->price;

        if ($users->balance < $price) {
            return response()->json(['message' => "Saldo anda tidak cukup untuk memesan property"], 500);
        }

        $balance_left = $users->balance - $price;

        $bookingId = DB::table('booking')->insertGetId([
            'userId' => $users->id,
            'propertyId' => $request->propertyId,
            'date' => date('Y-m-d'),
            'status' => 0
        ]);

        for ($i = 0; $i < 12 * $year; $i++) {
            $date = date('Y-m-d', strtotime('+' . $i . ' month'));

            if ($i % $duration == 0) {
                $insert = [
                    'userId' => $users->id,
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

        DB::table('users')->where('id', $users->id)->update([
            "balance" => $balance_left
        ]);

        return response()->json(['message' => "Booking berhasil menunggu persetujuan pemilik"], 200);
    }

    public function updateUserAccount(Request $request)
    {
        $userId = $request->userId;

        $rules = [
            'name'                  => 'required|min:6|max:15',
            'email'                 => 'required|email|unique:users,email,' . $userId,
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

        if ($validator->fails()) {
            $data = $validator->messages()->toArray();
            $output = "";

            foreach ($data as $k => $v) {
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

    public function getBooking(Request $req)
    {
        $userId = $req->userId;
        $data = DB::table('q_booking')->where('userId', $userId)->first();
        return response()->json(['message' => "Fetching data berhasil", "booking" => $data], 200);
    }

    public function getBill($userId)
    {
        $data = DB::table('q_bill')->where('userId', $userId)->get();
        // dd($data);
        return response()->json(['message' => "Fetching data berhasil", "bill" => $data], 200);
    }

    public function topupBalance(Request $req)
    {
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

    public function getBookingData(Request $req)
    {
        $data = DB::table('q_booking')
            ->where('userId', $req->userId)
            ->where('status', '!=', 2)->first();
        return response()->json(['message' => "Fetching data berhasil", "booking" => $data], 200);
    }

    public function getReviewId($userId, $propertyId)
    {
        $data = DB::table('review')
            ->where('userId', $userId)
            ->where('propertyId', $propertyId)->first();
        return response()->json($data, 200);
    }

    public function addReview(Request $req)
    {
        $userId = $req->userId;

        DB::table('review')->upsert([
            "date" => date('Y-m-d'),
            "userId" => $userId,
            "propertyId" => $req->propertyId,
            "rating" => $req->rating,
            "review" => $req->review,
        ], ['userId', 'propertyId'], ['date', 'rating', 'review']);

        return response()->json(['message' => "Review has been added"], 200);
    }

    public function changePassword(Request $req)
    {
        $userId = $req->userId;
        $users = DB::table('users')->where('id', $userId)->first();

        $rules = [
            'current_password'      => 'required',
            'password'              => 'required|min:6|confirmed',
        ];

        $messages = [
            'current_password.required' => 'Password saat ini harus diisi',
            'password.min'          => 'Password minimal 6 karakter',
            'password.required'     => 'Password wajib diisi',
            'password.confirmed'    => 'Password tidak sama dengan konfirmasi password',
        ];

        $validator = Validator::make($req->all(), $rules, $messages);

        if ($validator->fails()) {
            $data = $validator->messages()->toArray();
            $output = "";

            foreach ($data as $k => $v) {
                $output = str_replace(['[', ']'], ['', ''], $v[0]);
                break;
            }
            return response()->json(['message' => $output], 500);
        }

        if (!Hash::check($req->current_password, $users->password)) {
            return response()->json(['message' => "Password lama salah"], 500);
        }

        DB::table('users')->where('id', $userId)->update(
            [
                "password" => Hash::make($req->password)
            ]
        );

        return response()->json(['message' => "Password telah diubah silahkan login"], 200);
    }

    public function getOwnerProperty(Request $req)
    {
        $userId = $req->userId;
        $property = DB::table('q_property')->where('ownerId', $userId)->get();
        return response()->json(['message' => "Fetching data berhasil", "property" => $property], 200);
    }

    public function getOwnerBook(Request $req)
    {
        $ownerId = $req->userId;
        $data = [
            "booking" => DB::table('q_booking')->where('status', 0)->where('ownerId', $ownerId)->get()
        ];
        return response()->json(['message' => "Fetching data berhasil", "booking" => $data], 200);
    }

    public function insertProperty(Request $req)
    {
        $rules = [
            'name'                  => 'required',
            'description'           => 'required',
            'address'               => 'required',
            'price_day'             => 'required|integer',
            'price_month'           => 'required|integer',
            'price_year'            => 'required|integer',
            'type'                  => 'required',
        ];

        $messages = [
            'name.required'          => 'Nama property wajib diisi',
            'description.required'   => 'Deskripsi wajib diisi',
            'address.required'       => 'Alamat wajib diisi',
            'price_day.confirmed'    => 'Harga harian wajib diisi',
            'price_day.integer'      => 'Harga harian berupa angka',
            'price_month.confirmed'  => 'Harga bulanan wajib diisi',
            'price_month.integer'    => 'Harga bulanan berupa angka',
            'price_year.confirmed'   => 'Harga tahunan wajib diisi',
            'price_year.integer'     => 'Harga tahunan berupa angka',
            'type.required'          => 'Tipe harus diisi',
        ];

        $validator = Validator::make($req->all(), $rules, $messages);

        if ($validator->fails()) {
            $data = $validator->messages()->toArray();
            $output = "";

            foreach ($data as $k => $v) {
                $output = str_replace(['[', ']'], ['', ''], $v[0]);
                break;
            }
            return response()->json(['message' => $output], 500);
        }

        $id = DB::table('property')->insertGetId([
            "vrooms" => $req->vrooms,
            "ownerId" => $req->userId,
            "avaliable" => 1,
            "date_created" => date('Y-m-d'),
            "name" => $req->name,
            "description" => $req->description,
            "latitude" => $req->latitude,
            "longitude" => $req->longitude,
            "address" => $req->address,
            "type" => $req->type,
            "price_day" => $req->price_day,
            "price_month" => $req->price_month,
            "price_year" => $req->price_year,
        ]);

        return response()->json(['message' => "Data berhasil ditambahkan", "id" => $id], 200);
    }

    public function updateProperty(Request $req, $propertyId)
    {
        $rules = [
            'name'                  => 'required',
            'description'           => 'required',
            'address'               => 'required',
            'price_day'             => 'required|integer',
            'price_month'           => 'required|integer',
            'price_year'            => 'required|integer',
            'type'                  => 'required',
        ];

        $messages = [
            'name.required'          => 'Nama property wajib diisi',
            'description.required'   => 'Deskripsi wajib diisi',
            'address.required'       => 'Alamat wajib diisi',
            'price_day.confirmed'    => 'Harga harian wajib diisi',
            'price_day.integer'      => 'Harga harian berupa angka',
            'price_month.confirmed'  => 'Harga bulanan wajib diisi',
            'price_month.integer'    => 'Harga bulanan berupa angka',
            'price_year.confirmed'   => 'Harga tahunan wajib diisi',
            'price_year.integer'     => 'Harga tahunan berupa angka',
            'type.required'          => 'Tipe harus diisi',
        ];

        $validator = Validator::make($req->all(), $rules, $messages);

        if ($validator->fails()) {
            $data = $validator->messages()->toArray();
            $output = "";

            foreach ($data as $k => $v) {
                $output = str_replace(['[', ']'], ['', ''], $v[0]);
                break;
            }
            return response()->json(['message' => $output], 500);
        }

        DB::table('property')->where('id', $propertyId)
        ->update([
            "vrooms" => $req->vrooms,
            "ownerId" => $req->userId,
            "avaliable" => 1,
            "date_created" => date('Y-m-d'),
            "name" => $req->name,
            "description" => $req->description,
            "latitude" => $req->latitude,
            "longitude" => $req->longitude,
            "address" => $req->address,
            "type" => $req->type,
            "price_day" => $req->price_day,
            "price_month" => $req->price_month,
            "price_year" => $req->price_year,
        ]);

        return response()->json(['message' => "Data berhasil diupdate"], 200);
    }

    public function deleteImage($imageId)
  {
    DB::table('image')->where('id', $imageId)->delete();
    return response()->json([
      'message' => 'success'
    ]);
  }

    public function updateFacility(Request $req, $propertyId)
    {
        $isPropertyHaveFacility = DB::table('facility')
            ->where('propertyId', $propertyId)
            ->where('facilityId', $req->facilityId)
            ->first();
        $message = '';

        if ($isPropertyHaveFacility) {
            DB::table('facility')
                ->where('propertyId', $propertyId)
                ->where('facilityId', $req->facilityId)
                ->delete();
            $message = 'Trigger Deleted';
        } else {
            DB::table('facility')->insert([
                'propertyId' => $propertyId,
                'facilityId' => $req->facilityId
            ]);
            $message = 'Trigger Created';
        }

        return response()->json(
            ['message' => $message],
            200
        );
    }
  
  public function getPropertyDetails($propertyId)
    {
        $facilityProperty = DB::table('facility')
        ->where('propertyId', $propertyId)
        ->get();

        $facilityList = DB::table('facility_list')
        ->get();

        $property = DB::table('property')
        ->where('id', $propertyId)
        ->first();

        $images = DB::table('image')
        ->where('propertyId', $propertyId)
        ->get();

        $imagePath = str_replace(' ', '-', $property->id . '-' . strtolower($property->name));        
        $data = [
            'facility' => $facilityProperty,
            'facilityList' => $facilityList,
            'property' => $property,
            'image' => [
                'path' => $imagePath,
                'images' => $images
            ]
        ];

        return response()->json($data);
    }
  
   public function getIncome(Request $req) {
        $ownerId = $req->userId;

        $income = DB::table('bill')
            ->join('property', 'property.id', '=', 'bill.propertyId')
            ->join('q_bill', 'q_bill.id', '=', 'bill.id')
            ->join('booking', 'booking.id', '=', 'bill.bookingId')
            ->where('ownerId', $ownerId)
            ->where('bill.status', 1)
            ->where('booking.status', 1)
            ->orderBy('bill.date')->get();

        return response()->json($income, 200);
    }

    public function requestWithdraw(Request $req) {
        $balance = DB::table('users')->where('id', $req->userId)->first()->balance;
        DB::table('withdraw')->insert([
            'ownerId' => $req->userId,
            'amount' => $req->amount,
            'description' => $req->description,
            'created' => date("Y-m-d")
        ]);
        
        DB::table('users')->where('id', $req->userId)->update([
            'balance' => ($balance - $req->amount)
        ]);

        return response()->json(['message' => "Successfully create withdrawal request"], 200);
    }

    public function getBillByProperty($propertyId) {
        $bill = DB::table('q_bill')->where('propertyId', $propertyId)->get();
        return response()->json($bill, 200);
    }  

    public function addFavorite(Request $req)
    {
        DB::table('favorite')->insert([
          "propertyId" => $req->propertyId,
          "userId" => $req->userId
        ]);

        return response()->json(['message' => "Successfully added to favorite"], 200);
    }

    public function removeFavorite(Request $req)
    {
        DB::table('favorite')->where("propertyId", $req->propertyId)->where("userId", $req->userId)->delete();
        return response()->json(['message' => "Successfully removed from favorite"], 200);
    }
}
