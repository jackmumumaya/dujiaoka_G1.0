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

<script>
(function() {
    // Unique ID for the hint element to prevent duplicates
    var hintId = 'gemini-nav-hint-' + Math.random().toString(36).substr(2, 9);
    
    function initHint() {
        var btn = document.getElementById('myButton');
        if (!btn) return;

        var hint = document.getElementById(hintId);
        if (!hint) {
            hint = document.createElement('div');
            hint.id = hintId;
            hint.setAttribute('role', 'tooltip');
            // Updated style: Black color, sleek long arrow
            hint.innerHTML = `
                <div style="display: flex; align-items: center; justify-content: flex-end;">
                  <span style="color: #000000; font-weight: bold; font-size: 14px; margin-right: 8px; white-space: nowrap; letter-spacing: 1px;">点击展开</span>
                  <svg width="40" height="20" viewBox="0 0 40 20" fill="none" style="filter: drop-shadow(0 1px 1px rgba(255,255,255,0.8));">
                    <!-- Long sleek arrow -->
                    <path d="M0 10H38M38 10L30 3M38 10L30 17" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                  </svg>
                </div>
            `;
            hint.style.position = 'fixed'; 
            hint.style.zIndex = '2147483647';
            hint.style.cursor = 'pointer';
            hint.style.pointerEvents = 'auto';
            hint.style.display = 'none';
            
            hint.addEventListener('click', function(e) {
                e.stopPropagation();
                e.preventDefault();
                btn.click();
            });
            
            document.body.appendChild(hint);
            
            // Subtle horizontal pulse
            if (!document.getElementById('gemini-hint-style')) {
                var s = document.createElement('style');
                s.id = 'gemini-hint-style';
                s.innerHTML = `@keyframes geminiPulse { 0% { transform: translateX(0); } 50% { transform: translateX(5px); } 100% { transform: translateX(0); } }`;
                document.head.appendChild(s);
            }
            hint.children[0].style.animation = 'geminiPulse 1.5s infinite ease-in-out';
        }

        var rect = btn.getBoundingClientRect();
        var isVisible = rect.width > 0 && rect.height > 0 && window.getComputedStyle(btn).display !== 'none';
        var isExpanded = btn.getAttribute('aria-expanded') === 'true' || !btn.classList.contains('collapsed');

        // Logic: Show if button is visible AND not expanded
        if (isVisible && !isExpanded) {
            hint.style.display = 'block';
            hint.style.top = (rect.top + rect.height / 2 - 10) + 'px'; // Center
            hint.style.left = (rect.left - 120) + 'px'; // Position to left (more space for long arrow)
        } else {
            hint.style.display = 'none';
        }
    }

    initHint();
    setInterval(initHint, 200);
    window.addEventListener('resize', initHint);
    window.addEventListener('scroll', initHint);
})();
</script>