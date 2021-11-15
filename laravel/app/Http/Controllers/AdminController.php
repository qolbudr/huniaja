<?php

namespace App\Http\Controllers;

use App\Http\Controllers;
use Session;
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

    public function collectionFacility()
    {
        $facilityList = DB::table('facility_list')->get();
        $facilities = array(
            [
                'name' => 'Sarapan',
                'icon' => 'fa fa-cutlery',
                'mobileIcon' => '0xe3a0'
            ],
            [
                'name' => 'WIFI',
                'icon' => 'fa fa-wifi',
                'mobileIcon' => '58406'
            ],
            [
                'name' => 'AC',
                'icon' => 'fa fa-wind',
                'mobileIcon' => '60969',
            ],
            [
                'name' => 'Kasur',
                'icon' => 'fa fa-bed',
                'mobileIcon' => '0xe0d7'
            ],
            [
                'name' => 'WC',
                'icon' => 'fa fa-bath',
                'mobileIcon' => '0xe0cf'
            ],
            [
                'name' => 'PDAM',
                'icon' => 'fa fa-tint',
                'mobileIcon' => '0xe6d1'
            ],
            [
                'name' => 'TV',
                'icon' => 'fa fa-tv',
                'mobileIcon' => '0xe687'
            ],
            [
                'name' => 'Listrik',
                'icon' => 'fa fa-lightbulb-o',
                'mobileIcon' => '0xe379'
            ],
            [
                'name' => 'Parkir',
                'icon' => 'fa fa-parking-circle',
                'mobileIcon' => '0xe39d'
            ]
        );
        // return ['facilites' => $facilities];
        return view("admin.facility", ["facilities" => json_encode($facilities), "facilityCollection" => $facilityList]);
    }

    public function updateUser(Request $request, $id)
    {
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

    public function deleteUser($id)
    {
        DB::table('users')->where('id', $id)->delete();
        return redirect()->back();
    }
    public function getUserByadmin($userid)
    {
        $user = DB::table('users')->where('id', $userid)->first();
        return $user;
    }
    public function getOwner($ownerid)
    {
        $owner = DB::table('users')->where('id', $ownerid)->where('role', 1)->first();
        return $owner;
    }
    public function updateOwner(Request $request, $ownerid)
    {
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
    public function deleteOwner($ownerid)
    {
        DB::table('users')->where('role', 1)->where('id', $ownerid)->delete();
        return redirect()->back();
    }

    public function createFacility(Request $request)
    {
        $data = [
            "name" => $request->name,
            "webIcon" => $request->icon,
            "mobileIcon" => $request->mobileIcon
        ];
        DB::table('facility_list')->insert($data);
        return redirect()->back();
    }

    public function deleteFacility($id)
    {
        DB::table('facility_list')->where('id', $id)->delete();
        return redirect()->back();
    }

    public function getFacility($id)
    {
        return DB::table('facility_list')->where('id', $id)->first();
    }

    public function updateFacility(Request $req, $id)
    {
        DB::table('facility_list')->where('id', $id)->update([
            'name' => $req->name,
            'webIcon' => $req->icon,
            'mobileIcon' => $req->mobileIcon
        ]);
        return redirect()->back();
    }

    public function collectionProperty()
    {
        $properties = DB::table('property')
            ->join('users', 'property.ownerId', '=', 'users.id')
            ->select(
                'property.id',
                'property.ownerId',
                'users.name as owner',
                'property.name',
                'property.address',
                'property.price_day',
                'property.price_month',
                'property.price_year'
            )
            ->get();
        // return $properties;
        return view('admin.property', ['properties' => $properties]);
    }

    public function deleteProperty($id)
    {
        DB::table('property')->where('id', $id)->delete();
        return redirect()->back();
    }

    public function withdraw()
    {
        $withdrawDetail = DB::table('withdraw')
        ->join('users', 'withdraw.ownerId', '=', 'users.id')
        ->select(
            'withdraw.id as id',
            'users.name as owner',
            'withdraw.amount',
            'withdraw.status',
            'withdraw.created'
        )
        ->get();
        return view('admin.withdraw', ['withdraw' => $withdrawDetail]);
    }

    public function withdrawInformation($withdrawId)
    {
        $withdrawInformation = DB::table('withdraw')
        ->where('withdraw.id', $withdrawId)
        ->join('users', 'withdraw.ownerId', '=', 'users.id')
        ->select(
            'withdraw.amount',
            'withdraw.description',
            'users.name',
            'users.email',
            'users.address',
            'users.phone',
        )
        ->first();
        $withdraw = [
            'amount' => $withdrawInformation->amount,
            'description' => $withdrawInformation->description
        ];
        $user = [
            'name' => $withdrawInformation->name,
            'email' => $withdrawInformation->email,
            'address' => $withdrawInformation->address,
            'phone' => $withdrawInformation->phone
        ];
        return response()->json([
            'withdraw' => $withdraw,
            'user' => $user
        ]);
    }

    public function withdrawConfirmation(Request $req, $withdrawId)
    {
        $withdraw = DB::table('withdraw')
        ->where('id', $withdrawId)->first();
        $amount = $withdraw->amount;
        $ownerId = $withdraw->ownerId; 
        if($req->status == "accepted"){
            DB::table('withdraw')
            ->where('id', $withdrawId)
            ->update([
                'status' => 1,
                'status_change' => date('Y-m-d')
            ]);
            Session::flash('success', 'Penarikan Diterima');
        }else if($req->status == "deny"){
            DB::table('withdraw')
            ->where('id', $withdrawId)
            ->update([
                'status' => 2,
                'status_change' => date('Y-m-d')
            ]);
            $user = DB::table('users')
            ->where('id', $ownerId)->first();
            $userBalance = $user->balance;
            DB::table('users')
            ->where('id', $ownerId)
            ->update([
                'balance' => $userBalance + $amount
            ]);
            Session::flash('success', 'Berhasil Menolak Penarikan');
        }
        return redirect()->back();
    }
}
