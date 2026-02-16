<div class="top-header" style="position: relative;">
  <!-- Mobile Hint Overlay - Moved outside to prevent overflow clipping -->
  <!-- Onclick trigger ensures the button toggles when this text is clicked -->
  <div class="mobile-hint-overlay d-lg-none" onclick="document.getElementById('myButton').click()"
    style="position: absolute; right: 80px; top: 50%; transform: translateY(-50%); z-index: 10000; cursor: pointer; display: flex; align-items: center; justify-content: flex-end;">
    <span
      style="color: #dc3545; font-weight: bold; font-size: 14px; margin-right: 5px; white-space: nowrap;">点击展开</span>
    <svg width="40" height="40" viewBox="0 0 24 24" fill="none" class="hint-arrow-anim">
      <defs>
        <marker id="arrowhead" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto">
          <polygon points="0 0, 10 3.5, 0 7" fill="#dc3545" />
        </marker>
      </defs>
      <!-- Curve styling to point to the button -->
      <path d="M5 20 Q 15 20, 20 10" stroke="#dc3545" stroke-width="2" fill="none" marker-end="url(#arrowhead)" />
    </svg>
  </div>
  <style>
    @keyframes arrow-pulse {

      0%,
      100% {
        transform: scale(1);
      }

      50% {
        transform: scale(1.1) translateX(3px);
      }
    }

    .hint-arrow-anim {
      animation: arrow-pulse 1.5s infinite;
    }

    /* Hide hint when menu is expanded (aria-expanded=true) */
    /* Note: We need JS or sibling selector. Since this div is far from button, we use a simple script to hide it if needed, 
       but for simplicity we let it stay or relying on user clicking it which toggles menu */
    /* Better: Use CSS has selector if supported, but risky. 
       Let's keep it visible always on mobile as a "Menu" label equivalent. */
  </style>

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
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" id="myButton"
              data-bs-target="#navbarColor" aria-controls="navbarColor" aria-expanded="false"
              aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
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