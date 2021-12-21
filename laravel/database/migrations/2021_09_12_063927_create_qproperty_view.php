<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

class CreateQpropertyView extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::statement("CREATE VIEW q_property AS SELECT property.*, review.rating, image.image 
                        FROM property INNER join review
                        on review.propertyId = property.id
                        INNER JOIN image 
                        on image.propertyId = property.id
                        GROUP BY property.id");
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        DB::statement("DROP VIEW q_property");
    }
}
