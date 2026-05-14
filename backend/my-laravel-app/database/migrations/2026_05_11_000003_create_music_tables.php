<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (! Schema::hasTable('songs')) {
            Schema::create('songs', function (Blueprint $table) {
                $table->engine = 'InnoDB';
                $table->increments('id');
                $table->string('title', 100);
                $table->string('artist', 100);
                $table->year('release_year')->nullable();
                $table->string('cover_image_url')->nullable();
                $table->string('preview_url')->nullable();
                $table->timestamp('created_at')->useCurrent();
            });
        }

        if (! Schema::hasTable('music_categories')) {
            Schema::create('music_categories', function (Blueprint $table) {
                $table->engine = 'InnoDB';
                $table->increments('id');
                $table->string('name', 50);
            });
        }

        if (! Schema::hasTable('song_categories')) {
            Schema::create('song_categories', function (Blueprint $table) {
                $table->engine = 'InnoDB';
                $table->unsignedInteger('song_id');
                $table->unsignedInteger('category_id');
                $table->primary(['song_id', 'category_id']);

                $table->foreign('song_id')->references('id')->on('songs')->cascadeOnDelete();
                $table->foreign('category_id')->references('id')->on('music_categories')->cascadeOnDelete();
            });
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('song_categories');
        Schema::dropIfExists('music_categories');
        Schema::dropIfExists('songs');
    }
};
