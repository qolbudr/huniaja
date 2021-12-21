<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class WebController extends Controller
{
    public function index() {
        $house = DB::table('q_property')->get();
        $data['house'] = $house;
        return view('home', $data);
    }

    public function search() {
        $query = [
            [
                "place" => "Malang",
                "latitude" => "-7.96662",
                "longitude" => "112.633",
            ],
            [
                "place" => "Semarang",
                "latitude" => "-7.00515",
                "longitude" => "110.438",
            ],
            [
                "place" => "Surabaya",
                "latitude" => "-7.25747",
                "longitude" => "112.752",
            ],
            [
                "place" =>"Yogyakarta",
                "latitude" => "-7.79558",
                "longitude" => "110.369",
            ],
            [
                "place" => "Jakarta",
                "latitude" => "-6.20876",
                "longitude" => "106.846"
            ]
        ];

        shuffle($query);
        
        if(isset($_GET['q'])) {
            $data['place'] = $_GET['q'];
            $data['latitude'] = $_GET['latitude'];
            $data['longitude'] = $_GET['longitude'];
        } else {
            $data = $query[0];
        }

        $data['property'] = DB::table('q_property')->where('address', 'like', '%'.$data['place'].'%')->get();
        return view('search', $data);
    }

    public function login() {
        if (Auth::check()) {
            return redirect()->route('/');
        }
        return view('login');
    }

    public function register() {
        if (Auth::check()) {
            return redirect()->route('/');
        }
        return view('register');
    }

    public function detail($id, $name) {
        $data['detail'] = DB::table('q_property')->where('id', $id)->first();
        $data['facility'] = DB::table('q_facility')->where('propertyId', $id)->get();
        $data['image'] = DB::table('image')->where('propertyId', $id)->get();
        $data['review'] = DB::table('q_review')->where('propertyId', $id)->get();
        $data['isFavorite'] = DB::table('favorite')->where(["userId" => Auth::user()->id, "propertyId" => $id])->count();

        return view('detail', $data);
    }

    public function account() {
        $userId = Auth::user()->id;
        $data['user'] = DB::table('users')->where('id', $userId)->first();
        $data['property'] = DB::table('favorite')->join('q_property', 'favorite.propertyId', '=', 'q_property.id')->where('favorite.userId', $userId)->get();
        $data['booking'] = DB::table('q_booking')->where('userId', $userId)->orderBy('id', 'DESC')->first();
        $data['review'] = DB::table('q_review')->where('userId', $userId)->orderBy('id', 'DESC')->first();
        $data['bill'] = DB::table('q_bill')->join('booking', 'booking.id', '=', 'q_bill.bookingId')->where('q_bill.userId', $userId)->where('booking.status', 1)->get();
        return view('account', $data);
    }

    public function face(Request $request) {
        $data['request'] = $request;
        return view('face', $data);
    }
}
