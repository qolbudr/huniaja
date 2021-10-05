<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class LeftJoinQbookingTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::statement("DROP VIEW q_booking");
        DB::statement("CREATE VIEW q_booking AS SELECT property.*, booking.userId, AVG(review.rating) as avg_rating, 
                       booking.date, status, image.image
                       FROM booking
                       INNER join property ON property.id = booking.propertyId
                       INNER join image on image.propertyId =  property.id 
                       LEFT join review ON review.propertyId = property.id
                       GROUP BY property.id");
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        DB::statement("DROP VIEW q_booking");
    }
}
