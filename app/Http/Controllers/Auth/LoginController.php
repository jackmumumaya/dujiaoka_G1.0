<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\User; // 假设您的用户模型是 App\User

class LoginController extends BaseController
{
    /*
    |--------------------------------------------------------------------------
    | Login Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles authenticating users for the application and
    | redirecting them to your home screen. The controller uses a trait
    | to conveniently provide its functionality to your applications.
    |
    */

    // 您可以选择在这里使用 Laravel 的 AuthenticatesUsers trait，
    // 但为了避免引入复杂性并保持手动控制，我们将实现基本逻辑。

    /**
     * 显示登录表单。
     *
     * @return \Illuminate\View\View
     */
    public function showLoginForm()
    {
        return $this->render('static_pages/login', ['title' => '登录']);
    }

    /**
     * 处理用户登录请求。
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function login(Request $request)
    {
        $credentials = $request->validate([
            'email' => ['required', 'email'],
            'password' => ['required', 'string'],
        ]);

        if (Auth::attempt($credentials, $request->boolean('remember'))) {
            $request->session()->regenerate();
            return redirect()->intended('/')->with('success', '登录成功！');
        }

        return back()->withErrors([
            'email' => '提供的凭据与我们的记录不符。',
        ])->onlyInput('email');
    }

    /**
     * 处理用户登出请求。
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function logout(Request $request)
    {
        Auth::logout();

        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return redirect('/')->with('success', '已成功登出。');
    }
}