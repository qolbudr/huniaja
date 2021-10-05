<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Illuminate\Support\Facades\Auth;
use Validator;
use Hash;
use Session;
use App\Models\User;

class AuthController extends Controller
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
            return redirect()->back()->withErrors($validator)->withInput($request->all);
        }
  
        $data = [
            'email'     => $request->input('email'),
            'password'  => $request->input('password'),
        ];
  
        Auth::attempt($data);
  
        if (Auth::check() && Auth::user()->role == 0) {
            return redirect()->route('/');
        } else {
            Auth::logout();
            Session::flash('error', 'Email atau password salah');
            return redirect()->back();
        }
    }

    public function ownerLogin(Request $request)
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
            return redirect()->back()->withErrors($validator)->withInput($request->all);
        }
  
        $data = [
            'email'     => $request->input('email'),
            'password'  => $request->input('password'),
        ];
  
        Auth::attempt($data);
  
        if (Auth::check() && Auth::user()->role == 1) {
            return redirect()->route('ownerDashboard');
        } else {
            Auth::logout();
            Session::flash('error', 'Email atau password salah');
            return redirect()->back();
        }
    }

    public function register(Request $request)
    {
        $rules = [
            'name'                  => 'required|min:6|max:35',
            'email'                 => 'required|email|unique:users,email',
            'password'              => 'required|min:6|confirmed',
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
        ];
  
        $validator = Validator::make($request->all(), $rules, $messages);
  
        if($validator->fails()){
            if($request->role == 1) {
                return redirect()->back()->withErrors($validator)->withInput($request->all);
            } else {
                return redirect()->route('register')->withErrors($validator)->withInput($request->all);
            }
        }
  
        $user = new User;
        $user->name = ucwords(strtolower($request->name));
        $user->email = strtolower($request->email);
        $user->password = Hash::make($request->password);
        $user->email_verified_at = \Carbon\Carbon::now();
        $user->role = $request->role;
        $user->phone = $request->phone;
        $user->face = $request->face;
        $simpan = $user->save();

  
        if($simpan){
            Session::flash('success', 'Register berhasil! Silahkan login untuk mengakses data');
            if($request->role == 1) {
                return redirect()->route('ownerLogin');
            } else {
                return redirect()->route('login');
            }
        } else {
            Session::flash('errors', ['' => 'Register gagal! Silahkan ulangi beberapa saat lagi']);
            if($request->role == 1) {
                return redirect()->route('ownerRegister');
            } else {
                return redirect()->route('register');
            }
        }
    }

    public function logout() {
        $role = Auth::user()->role;
        Auth::logout();

        if($role == 0) {
            return redirect()->route('/');
        } else if($role == 1) {
            return redirect()->route('ownerLogin');
        } else {
            return redirect()->route('/admin/login');
        }
    }
}
