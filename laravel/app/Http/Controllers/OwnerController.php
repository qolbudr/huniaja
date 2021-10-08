<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Session;

class OwnerController extends Controller
{
    function compact_curr($n, $presisi = 1)
    {
        if ($n < 900) {
            $format_angka = number_format($n, $presisi);
            $simbol = '';
        } else if ($n < 900000) {
            $format_angka = number_format($n / 1000, $presisi);
            $simbol = 'rb';
        } else if ($n < 900000000) {
            $format_angka = number_format($n / 1000000, $presisi);
            $simbol = 'jt';
        } else if ($n < 900000000000) {
            $format_angka = number_format($n / 1000000000, $presisi);
            $simbol = 'M';
        } else {
            $format_angka = number_format($n / 1000000000000, $presisi);
            $simbol = 'T';
        }

        if ($presisi > 0) {
            $pisah = '.' . str_repeat('0', $presisi);
            $format_angka = str_replace($pisah, '', $format_angka);
        }

        return $format_angka . $simbol;
    }

    public function login()
    {
        return view('owner/login');
    }

    public function register()
    {
        return view('owner/register');
    }

    public function dashboard()
    {
        $ownerId = Auth::user()->id;

        $data = [
            "propertyCount" => DB::table('property')->where('ownerId', $ownerId)->count(),
            "incomeCount" => $this->compact_curr(
                DB::table('bill')->selectRaw('bill.*, property.ownerId')
                    ->join('property', 'bill.propertyId', '=', 'property.id')
                    ->join('booking', 'booking.id', '=', 'bill.bookingId')
                    ->where('ownerId', $ownerId)
                    ->where('booking.status', 1)
                    ->where('bill.status', 1)->sum('bill.price')
            ),
            "booking" => DB::table('booking')
                ->join('property', 'property.id', '=', 'booking.propertyId')
                ->where('ownerId', $ownerId)->get()

        ];

        return view('owner/dashboard', $data);
    }

    public function chat()
    {
        return view('owner/chat');
    }

    public function income()
    {
        $ownerId = Auth::user()->id;
        $data = [
            "income" =>  DB::table('bill')
                ->join('property', 'property.id', '=', 'bill.propertyId')
                ->join('q_bill', 'q_bill.id', '=', 'bill.id')
                ->join('booking', 'booking.id', '=', 'bill.bookingId')
                ->where('ownerId', $ownerId)
                ->where('bill.status', 1)
                ->where('booking.status', 1)
                ->orderBy('bill.date')->get()
        ];
        return view('owner/income', $data);
    }

    public function withdraw()
    {
        $ownerId = Auth::user()->id;
        return view('owner/income', $data);
    }

    public function booking()
    {
        $ownerId = Auth::user()->id;
        $data = [
            "booking" => DB::table('booking')
                ->join('property', 'property.id', '=', 'booking.propertyId')
                ->where('ownerId', $ownerId)->get()
        ];

        return view('owner/booking', $data);
    }

    public function property()
    {
        $ownerId = Auth::user()->id;
        $data = [
            "property" => DB::table('property')->where('ownerId', $ownerId)->get()
        ];
        $facilities = DB::table('facility_list')->get();
        return view('owner/property', ['data' => $data, 'facilities' => $facilities]);
    }

    public function bill()
    {
        $ownerId = Auth::user()->id;
        $property = DB::table('q_property')->where('ownerId', $ownerId)->get();
        $bill = DB::table('q_bill')->where('propertyId', $property[0]->id)->get();

        $data = compact('property', 'bill');

        return view('owner/bill', $data);
    }

    public function insertProperty(Request $req)
    {
        DB::table('property')->insert([
            "vrooms" => $req->vrooms,
            "ownerId" => Auth::user()->id,
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

        Session::flash('success', 'Properti telah ditambahkan');
        return redirect()->back();
    }

    public function getFacilitiesProperty($propertyId)
    {
        $facilitiesProperty = DB::table('facility')
            ->where('propertyId', $propertyId)
            ->join('facility_list', 'facility.facilityId', '=', 'facility_list.id')
            ->join('property', 'facility.propertyId', '=', 'property.id')
            ->select(
                'property.name as name',
                'facility_list.name as facility',
                'facility_list.webIcon as webIcon',
                'facility_list.id as facilityId'
            )
            ->get();
        $facilities = DB::table('facility_list')->get();
        return ['facilitiesProperty' => $facilitiesProperty, 'facilities' => $facilities];
    }

    public function getProperty($propertyId)
    {
        $property = DB::table('property')
            ->where('id', $propertyId)->first();
        if ($property->ownerId != Auth::user()->id) {
            return response()->json(
                ['message' => 'Forbidden Difference Owner'],
                403
            );
        }
        return $property;
    }

    public function updateProperty(Request $req, $propertyId)
    {
        $data = [
            "vrooms" => $req->vrooms,
            "ownerId" => Auth::user()->id,
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
        ];
        DB::table('property')->where('id', $propertyId)->update($data);
        Session::flash('success', 'Properti telah diperbarui');
        return redirect()->back();
    }

    public function deleteProperty($propertyId)
    {
        $isExist = DB::table('property')->where('id', $propertyId)->first();
        if ($isExist) {
            DB::table('property')->where('id', $propertyId)->delete();
            Session::flash('success', 'Properti telah dihapus');
            return redirect()->back();
        }
        return redirect()->back();
    }

    public function triggerFacilityProperty(Request $req, $propertyId)
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
}
