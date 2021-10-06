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
        $facilities = Array(
            [
                'name' => 'Sarapan',
                'icon' => 'fa fa-cutlery'
            ],
            [
                'name' => 'WIFI',
                'icon' => 'fa fa-wifi'
            ],
            [
                'name' => 'AC',
                'icon' => 'fa fa-wind'
            ],
            [
                'name' => 'Kasur',
                'icon' => 'fa fa-bed'
            ],
            [
                'name' => 'WC',
                'icon' => 'fa fa-bath'
            ],
            [
                'name' => 'PDAM',
                'icon' => 'fa fa-tint'
            ],
            [
                'name' => 'TV',
                'icon' => 'fa fa-tv'
            ],
            [
                'name' => 'Listrik',
                'icon' => 'fa fa-lightbulb-o'
            ],
            [
                'name' => 'Parkir',
                'icon' => 'fa fa-parking-circle'
            ]
        );
            // return ['facilites' => $facilities];
        return view("admin.facility", [  "facilities" => json_encode($facilities), "facilityCollection" => $facilityList]);
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
    public function getOwner($ownerid){
        $owner = DB::table('users')->where('id', $ownerid)->where('role', 1)->first();
        return $owner;
    }
    public function updateOwner(Request $request, $ownerid){
        $updateData = [
            "name" => $request->name,
            "email" => $request->email,
            "dob" => $request->dob,
            "phone" => $request->phone,
            "balance" => $request->balance,
            "address" => $request->address
        ];
        
        DB::table('users')->where('role', 1)->where('id', $ownerid)->update($updateData);
        return redirect()->back();
    }
    public function deleteOwner($ownerid){
        DB::table('users')->where('role', 1)->where('id', $ownerid)->delete();
        return redirect()->back();
    }

    public function createFacility(Request $request){
        $data = [
            "name" => $request->name,
            "webIcon" => $request->icon,
        ];
        DB::table('facility_list')->insert($data);
        return redirect()->back();
    }

    public function deleteFacility($id){
        DB::table('facility_list')->where('id', $id)->delete();
        return redirect()->back();
    }

    public function getFacility($id){
        return DB::table('facility_list')->where('id', $id)->first();
    }

    public function updateFacility(Request $req, $id){
        DB::table('facility_list')->where('id', $id)->update([
            'name' => $req->name,
            'webIcon' => $req->icon
        ]);
        return redirect()->back();
    }
}
