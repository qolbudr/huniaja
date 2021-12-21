<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class LeftJoinQpropertyTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::statement("DROP VIEW q_property");
        DB::statement("CREATE VIEW q_property AS SELECT property.*, AVG(review.rating) as avg_rating, COUNT(facility.id) as count_facility, image.image, users.name as ownerName, email, phone
            FROM property
            LEFT join review ON review.propertyId = property.id
            INNER join facility on facility.propertyId = property.id 
            INNER join image on image.propertyId =  property.id 
            INNER join users on users.id =  property.ownerId
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
