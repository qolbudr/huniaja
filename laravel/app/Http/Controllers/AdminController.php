<?php

namespace App\Http\Controllers;

use App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class AdminController extends Controller
{
    public function login()
    {
        return view('admin.login');
    }

    public function dashboard()
    {
        $users = DB::table('users')->where("role", 0)->count();
        $property = DB::table('property')->count();
        return view('admin.dashboard', [
            'countUser' => $users,
            'countProperty' => $property
        ]);
    }

    public function manageUser()
    {
        $users = DB::table('users')->where("role", 0)->get();
        return view('admin.users', ['users' => $users]);
    }

    public function collectionOwner()
    {
        $owners = DB::table('users')->where("role", 1)->get();
        return view("admin.owner", ['owners' => $owners]);
    }

    public function collectionFacility(){
        $facilityList = DB::table('facility_list')->get();
        return view("admin.facility", ["facilities" => $facilityList]);
    }

    public function updateUser(Request $request, $id){
        $updateData = [
            "name" => $request->name,
            "email" => $request->email,
            "dob" => $request->dob,
            "phone" => $request->phone,
            "address" => $request->address
        ];

        DB::table('users')->where('id', $request->id)->update($updateData);
        return redirect('/admin/user');
    }

    public function deleteUser($id){
        DB::table('users')->where('id', $id)->delete();
        return redirect()->back();
    }
    public function getUserByadmin($userid){
        $user = DB::table('users')->where('id', $userid)->first();
        return $user;
    }
}
