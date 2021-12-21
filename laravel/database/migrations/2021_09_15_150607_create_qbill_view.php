<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateQbillView extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::statement("CREATE VIEW q_bill AS SELECT bill.*, property.name as propertyName, users.name as userName
            FROM bill
            INNER join property on bill.propertyId = property.id 
            INNER join users on bill.userId =  users.id");
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        DB::statement("DROP VIEW q_bill");
    }
}
