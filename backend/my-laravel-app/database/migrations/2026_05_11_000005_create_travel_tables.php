<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (! Schema::hasTable('destinations')) {
            Schema::create('destinations', function (Blueprint $table) {
                $table->engine = 'InnoDB';
                $table->increments('id');
                $table->string('name', 100);
                $table->text('description')->nullable();
                $table->decimal('weekly_cost_estimate', 10, 2)->nullable();
                $table->timestamp('created_at')->useCurrent();
            });
        }

        if (! Schema::hasTable('attractions')) {
            Schema::create('attractions', function (Blueprint $table) {
                $table->engine = 'InnoDB';
                $table->increments('id');
                $table->unsignedInteger('destination_id');
                $table->string('name', 100);
                $table->text('description')->nullable();

                $table->foreign('destination_id')->references('id')->on('destinations')->cascadeOnDelete();
            });
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('attractions');
        Schema::dropIfExists('destinations');
    }
};
