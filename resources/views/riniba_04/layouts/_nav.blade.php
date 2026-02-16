<div class="top-header">
  <div class="container header-block">
    <div class="header-left">
      <div class="header-right clearfix">
        <nav class="navbar navbar-expand-lg navbar-light">
          <div class="container-fluid" style="position: relative;">
            <a href="/" class="topnav-logo" style="float: none">
              <img class="img-logo" src="https://i.postimg.cc/8crWdxXw/Gemini-Generated-Image-9fh69fh69fh69fh6.png"
                alt="{{ dujiaoka_config_get('text_logo') }}"
                style="height: 100px; width: auto; vertical-align: middle;">
            </a>
            <button class="navbar-toggler collapsed" type="button" data-bs-toggle="collapse" id="myButton"
              data-bs-target="#navbarColor" aria-controls="navbarColor" aria-expanded="false"
              aria-label="Toggle navigation" style="position: relative; overflow: visible;">
              <span class="navbar-toggler-icon"></span>

              <!-- Mobile Hint: Only visible when collapsed -->
              <div class="mobile-hint-arrow"
                style="position: absolute; top: 100%; right: 5px; flex-direction: column; align-items: flex-end; width: 120px; pointer-events: none;">
                <svg class="hint-anim-target" width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="#dc3545"
                  stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                  style="filter: drop-shadow(0 0 2px rgba(255,255,255,0.8));">
                  <line x1="6" y1="18" x2="18" y2="6"></line>
                  <polyline points="8 6 18 6 18 16"></polyline>
                </svg>
                <span
                  style="color: #dc3545; font-weight: bold; font-size: 13px; margin-top: -10px; text-shadow: 0 0 3px #fff;">点击展开</span>
              </div>

              <style>
                /* Default hidden */
                .mobile-hint-arrow {
                  display: none;
                }

                /* Show ONLY when collapsed (Bootstrap adds 'collapsed' class or aria-expanded='false') */
                .navbar-toggler.collapsed .mobile-hint-arrow,
                .navbar-toggler[aria-expanded="false"] .mobile-hint-arrow {
                  display: flex;
                }

                @keyframes poke-top-right {

                  0%,
                  100% {
                    transform: translate(0, 0);
                  }

                  50% {
                    transform: translate(-5px, 5px);
                  }
                }

                .hint-anim-target {
                  animation: poke-top-right 1.5s infinite ease-in-out;
                }
              </style>
            </button>
            <div class="collapse navbar-collapse" id="navbarColor">
              <ul class="navbar-nav me-auto centered-nav">
                <a class="btn btn-top-nav" href="/">首页</a><a class="btn btn-top-nav" href="/order-search">订单查询</a><a
                  class="btn btn-top-nav" href="https://t.me/Gemini_51xueAi" target="_blank">在线客服</a><a
                  class="btn btn-top-nav" href="https://t.me/ai51xue" target="_blank"><i class="uil uil-cart"></i>
                  加入社区</a>
                @guest
                  <a class="btn btn-top-nav" href="{{ route('login') }}">登录</a>
                  <a class="btn btn-top-nav" href="{{ route('register') }}">注册</a>
                @else
                  <span class="btn btn-top-nav" style="cursor: default;">{{ Auth::user()->name }}</span>
                  <form method="POST" action="{{ route('logout') }}" style="display: inline;">
                    @csrf
                    <button type="submit" class="btn btn-top-nav" style="border: none; cursor: pointer;">退出</button>
                  </form>
                @endguest
              </ul>
              @if (request()->is('/'))
                <div class="search-box-placeholder">
                  <div class="search-box">
                    <input type="text" class="search-form" id="search" placeholder="输入关键词搜索..." /><span
                      class="uil-search"></span>
                  </div>
                </div>
              @endif
            </div>
          </div>
        </nav>
      </div>
    </div>
  </div>
</div>