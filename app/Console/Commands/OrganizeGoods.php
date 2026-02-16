<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Goods;
use App\Models\GoodsGroup;
use App\Models\Carmis;
use Illuminate\Support\Facades\DB;

class OrganizeGoods extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'goods:organize';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Organize goods: merge duplicate categories and sort products by stock';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {
        $this->info('Starting organization...');

        // 1. Merge Duplicate Categories
        $this->mergeCategories();

        // 2. Sort Goods by Stock and Sales
        $this->sortGoods();

        $this->info('Organization completed successfully!');
        return 0;
    }

    protected function mergeCategories()
    {
        $this->info('Merging duplicate categories...');

        // Get all groups
        $groups = GoodsGroup::all();

        // Group by name (trimming whitespace)
        $grouped = $groups->groupBy(function ($item) {
            return trim($item->gp_name);
        });

        $mergedCount = 0;

        foreach ($grouped as $name => $duplicates) {
            if ($duplicates->count() > 1) {
                // Keep the one with the smallest ID (created first) as primary
                $primary = $duplicates->sortBy('id')->first();
                $this->line("Merging duplicates for category: {$name} (Primary ID: {$primary->id})");

                foreach ($duplicates as $dupe) {
                    if ($dupe->id == $primary->id)
                        continue;

                    // Move goods to primary category
                    $count = Goods::where('group_id', $dupe->id)->update(['group_id' => $primary->id]);

                    if ($count > 0) {
                        $this->line("  Moved {$count} goods from ID {$dupe->id} to {$primary->id}");
                    }

                    // Delete the duplicate category
                    $dupe->forceDelete();
                    $mergedCount++;
                }
            }
        }

        if ($mergedCount > 0) {
            $this->info("Merged {$mergedCount} duplicate categories.");
        } else {
            $this->info("No duplicate categories found.");
        }
    }

    protected function sortGoods()
    {
        $this->info('Sorting goods by stock and sales volume...');

        $goods = Goods::all();
        $count = 0;

        foreach ($goods as $product) {
            $stock = 0;

            // Calculate real stock
            if ($product->type == Goods::AUTOMATIC_DELIVERY) {
                $stock = Carmis::where('goods_id', $product->id)->where('status', Carmis::STATUS_UNSOLD)->count();
                // Optionally verify/update the in_stock column mostly for caching purposes
                // But we rely on ord for sorting
            } else {
                $stock = $product->in_stock;
            }

            // Calculations:
            // Just Sort by Stock Count (High stock first)
            $newOrd = $stock;

            // Update if changed
            if ($product->ord != $newOrd) {
                $product->ord = $newOrd;
                $product->save();
                $count++;
            }
        }

        $this->info("Updated sorting order for {$count} products.");
    }
}
