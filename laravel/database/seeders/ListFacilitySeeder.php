<?php

namespace Database\Seeders;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class listFacilitySeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $listFacility = [
            [
                "name" => "Kasur",
                "webIcon" => "fa fa-bed",
                "mobileIcon" => "57559",
            ],
            [
                "name" => "WC",
                "webIcon" => "fa fa-bath",
                "mobileIcon" => "57559",
            ],
            [
                "name" => "PDAM",
                "webIcon" => "fa fa-tint",
                "mobileIcon" => "59088",
            ],
            [
                "name" => "TV",
                "webIcon" => "fa fa-tv",
                "mobileIcon" => "57794",
            ],
            [
                "name" => "Listrik",
                "webIcon" => "fa fa-lightbulb-o",
                "mobileIcon" => "58236",
            ]
        ];

        \DB::table('facility_list')->insert($listFacility);
    }
}
