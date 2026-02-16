<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Cache;

class UpdateNotice extends Command
{
    protected $signature = 'notice:update';
    protected $description = '更新店铺公告内容';

    public function handle()
    {
        $notice = <<<'HTML'
<div style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; line-height: 1.8; color: #333;">

<h3 style="color: #1a73e8; border-bottom: 2px solid #1a73e8; padding-bottom: 8px;">📢 店铺重要公告 &amp; 购前须知</h3>

<p>✅ <strong>下单小贴士：</strong> 建议您先<span style="color: #e74c3c; font-weight: bold;">【注册账号】</span>后再下单，以便随时方便地查询订单状态。</p>

<p>🛡️ <strong>售后与质保：</strong> 我们承诺提供 <span style="color: #27ae60; font-weight: bold;">24小时内</span> 售后服务保障，让您购物无忧。</p>

<h4 style="color: #2c3e50; margin-top: 15px;">💬 联系方式 &amp; 通知：</h4>
<ul style="list-style: none; padding-left: 10px;">
<li>👤 <strong>TG人工客服：</strong> <a href="https://t.me/Gemini_51xueAi" target="_blank" style="color: #1a73e8; text-decoration: none;">@Gemini_51xueAi</a> （点击用户名可直接联系）</li>
<li>📣 <strong>补货通知频道：</strong> <a href="https://t.me/ai51xue" target="_blank" style="color: #1a73e8; text-decoration: none;">https://t.me/ai51xue</a> （加入频道获取第一手资讯）</li>
</ul>

<h4 style="color: #c0392b; margin-top: 15px;">⚠️ 【重要】Gmail 使用安全警告：</h4>
<p style="background-color: #fdf2f2; border-left: 4px solid #e74c3c; padding: 12px; border-radius: 4px;">
登录新账号后，请短时间内<span style="color: #e74c3c; font-weight: bold;">切勿修改密码！</span><br>
请务必耐心等待账号及辅助号码稳定后，再自行开启或修改2FA（双重验证），以确保账号安全。
</p>

</div>
HTML;

        // 获取当前系统设置
        $settings = Cache::get('system-setting', []);

        // 更新公告
        $settings['notice'] = $notice;

        // 写回缓存
        Cache::put('system-setting', $settings);

        $this->info('✅ 店铺公告已更新成功！');
        $this->info('公告内容包含：');
        $this->info('  - 下单小贴士（注册账号提醒）');
        $this->info('  - 售后质保（24小时）');
        $this->info('  - TG客服：@Gemini_51xueAi');
        $this->info('  - 补货频道：https://t.me/ai51xue');
        $this->info('  - Gmail安全警告（勿改密码）');
    }
}
