<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddOwnerToQpropertyView extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('qproperty_view', function (Blueprint $table) {
            DB::statement("DROP VIEW q_property");
            DB::statement("CREATE VIEW q_property AS SELECT property.*, review.rating, image.image, phone, email, users.name as ownerName
                        FROM property INNER join review
                        on review.propertyId = property.id
                        INNER JOIN image 
                        on image.propertyId = property.id
                        INNER JOIN users 
                        on users.id = property.ownerId
                        GROUP BY property.id");
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('qproperty_view', function (Blueprint $table) {
            DB::statement("DROP VIEW q_property");
        });
    }
}
