<?php

namespace Database\Seeders;
use Illuminate\Database\Seeder;
use App\Models\User;

class PropertySeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $property = [
            "ownerId" => User::where('role', 1)->get()->random()->id,
            "name" => ucwords("kontrakan indah surabaya"),
            "description" => "Pages that you view in this window won't appear in the browser history and they won't leave other traces, like cookies, on the computer after you close all open Guest windows.Pages that you view in this window won't appear in the browser history and they won't leave other traces, like cookies, on the computer after you close all open Guest windows.",
            "address" => "Jl. Ketintang Madya",
            "price" => 500000,
            "latitude" => "-7.31517",
            "longitude" => "112.723",
            "type" => 2,
            "avaliable" => 1
        ];

        \DB::table('property')->insert($property);

        for($i = 1; $i <= 4; $i++) {
            $image = [
                "propertyId" => \DB::table('property')->get()->random()->id,
                "image" => $i.".jpg",
            ];

            \DB::table('image')->insert($image);
        }

        for($i = 1; $i <= 3; $i++) {
            $facility = [
                "propertyId" => \DB::table('property')->get()->random()->id,
                "facilityId" => $i,
            ];

            \DB::table('facility')->insert($facility);
        }


        $review = [
            "userId" => User::where('role', 0)->get()->random()->id,
            "propertyId" => \DB::table('property')->get()->random()->id,
            "review" => "Pages that you view in this window won't appear in the browser history and they won't leave other traces, like cookies, on the computer",
            "rating" => 4.5,
            "date" => date("Y-m-d"),
        ];

        \DB::table('review')->insert($review);
    }
}
