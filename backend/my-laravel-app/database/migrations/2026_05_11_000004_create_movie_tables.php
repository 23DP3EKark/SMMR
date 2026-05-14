<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (! Schema::hasTable('movies')) {
            Schema::create('movies', function (Blueprint $table) {
                $table->engine = 'InnoDB';
                $table->increments('id');
                $table->string('title', 100);
                $table->string('studio', 100)->nullable();
                $table->year('release_year')->nullable();
                $table->string('cover_image_url')->nullable();
                $table->timestamp('created_at')->useCurrent();
            });
        }

        if (! Schema::hasTable('movie_categories')) {
            Schema::create('movie_categories', function (Blueprint $table) {
                $table->engine = 'InnoDB';
                $table->increments('id');
                $table->string('name', 50);
            });
        }

        if (! Schema::hasTable('movie_category_map')) {
            Schema::create('movie_category_map', function (Blueprint $table) {
                $table->engine = 'InnoDB';
                $table->unsignedInteger('movie_id');
                $table->unsignedInteger('category_id');
                $table->primary(['movie_id', 'category_id']);

                $table->foreign('movie_id')->references('id')->on('movies')->cascadeOnDelete();
                $table->foreign('category_id')->references('id')->on('movie_categories')->cascadeOnDelete();
            });
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('movie_category_map');
        Schema::dropIfExists('movie_categories');
        Schema::dropIfExists('movies');
    }
};
