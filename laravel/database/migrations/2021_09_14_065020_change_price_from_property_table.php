<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class ChangePriceFromPropertyTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('property', function (Blueprint $table) {
            $table->dropColumn('price');
            $table->integer('price_day');
            $table->integer('price_month');
            $table->integer('price_year');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('property', function (Blueprint $table) {
            $table->integer('price');
            $table->dropColumn('price_day');
            $table->dropColumn('price_month');
            $table->dropColumn('price_year');
        });
    }
}
