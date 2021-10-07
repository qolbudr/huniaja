<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Hash;
use Illuminate\Support\Facades\DB;


class AdminSeed extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        $admin = [
            'name' => 'Kurama Admin',
            'email' => 'kuramaxnaruto@gmail.com',
            'password' => Hash::make('123123'),
            'role' => 2
        ];
        DB::table('users')->insert($admin);
    }
}
