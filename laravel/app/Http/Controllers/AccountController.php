<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Session;

class AccountController extends Controller
{
    public function updateUserAccount(Request $request) {
        $userId = Auth::user()->id;
        $data = [
            "name" => $request->name,
            "email" => $request->email,
            "dob" => $request->dob,
            "phone" => $request->phone,
            "address" => $request->address
        ];

        DB::table('users')->where('id', $userId)->update($data);
        Session::flash('success', 'Data telah berhasil disimpan');
        return redirect()->back();
    }
}
