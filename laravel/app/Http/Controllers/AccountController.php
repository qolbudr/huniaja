<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Session;
use Validator;
use Hash;

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

    public function changePassword(Request $req)
    {
        $userId = Auth::user()->id;
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
            return redirect()->back()->withErrors($validator)->withInput($request->all);
        }

        if (!Hash::check($req->current_password, $users->password)) {
            Session::flash('error', 'Password lama salah');
            return redirect()->back();
        }

        DB::table('users')->where('id', $userId)->update(
            [
                "password" => Hash::make($req->password)
            ]
        );

        Session::flash('success', 'Password telah berhasil diubah');
        return redirect()->back();
    }

    public function deleteAccount() {
        $userId = Auth::user()->id;
        DB::table('users')->where('id', $id)->delete();
        Auth::logout();
        Session::flash('success', 'Akun telah berhasil dihapus');
        return redirect()->to('/login');
    }
}
