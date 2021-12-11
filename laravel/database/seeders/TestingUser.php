<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Hash;
use Illuminate\Support\Facades\DB;


class TestingUser extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        $admin1 = [
            'name' => 'adminrahma',
            'email' => 'adminrahma@mail.com',
            'password' => Hash::make('123123'),
            'role' => 2
        ];

        $user1 = [
            'name' => 'Rahma Irawan',
            'email' => 'rahmairawan@mail.com',
            'password' => Hash::make('123123'),
            'phone' => "08123123428",
            'address' => "Jl. Surabaya No.1",
            'email_verified_at' => date('Y-m-d H:i:s'),
            'role' => 0
        ];

        $owner1 = [
            'name' => 'sri handayani',
            'email' => 'srihandayani@mail.com',
            'password' => Hash::make('123123'),
            'phone' => "08123123428",
            'address' => "Jl. Jakarta No.2",
            'email_verified_at' => date('Y-m-d H:i:s'),
            'role' => 1
        ];

        DB::table('users')->insert($admin1);
        DB::table('users')->insert($user1);
        DB::table('users')->insert($owner1);


        $admin2 = [
            'name' => 'Eko',
            'email' => 'eko@mail.com',
            'password' => Hash::make('123123'),
            'role' => 2
        ];

        $user2 = [
            'name' => 'Imam',
            'email' => 'imam@mail.com',
            'password' => Hash::make('123123'),
            'phone' => "08123123428",
            'address' => "Jl. Surabaya No.1",
            'email_verified_at' => date('Y-m-d H:i:s'),
            'role' => 0
        ];

        $owner2 = [
            'name' => 'bambang',
            'email' => 'bambang@mail.com',
            'password' => Hash::make('123123'),
            'phone' => "08123123428",
            'address' => "Jl. Jakarta No.2",
            'email_verified_at' => date('Y-m-d H:i:s'),
            'role' => 1
        ];

        DB::table('users')->insert($admin2);
        DB::table('users')->insert($user2);
        DB::table('users')->insert($owner2);

        $admin3 = [
            'name' => 'Hasan',
            'email' => 'hasan@mail.com',
            'password' => Hash::make('123123'),
            'role' => 2
        ];

        $user3 = [
            'name' => 'ibnu',
            'email' => 'ibnu@mail.com',
            'password' => Hash::make('123123'),
            'phone' => "08123123428",
            'address' => "Jl. Surabaya No.1",
            'email_verified_at' => date('Y-m-d H:i:s'),
            'role' => 0
        ];

        $owner3 = [
            'name' => 'tahar',
            'email' => 'tahar@mail.com',
            'password' => Hash::make('123123'),
            'phone' => "08123123428",
            'address' => "Jl. Jakarta No.2",
            'email_verified_at' => date('Y-m-d H:i:s'),
            'role' => 1
        ];

        DB::table('users')->insert($admin3);
        DB::table('users')->insert($user3);
        DB::table('users')->insert($owner3);


    }
}
