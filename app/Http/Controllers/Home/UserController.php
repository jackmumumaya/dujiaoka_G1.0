<?php

namespace App\Http\Controllers\Home;

use App\Http\Controllers\BaseController;
use App\Models\Order;
use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class UserController extends BaseController
{


    /**
     * 用户登录页面
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function login()
    {
        if (Auth::check()) {
            return redirect('/user');
        }
        return view('common.frontend.auth.login', ['page_title' => '用户登录']);
    }

    /**
     * 执行登录
     * @param Request $request
     * @return \Illuminate\Http\RedirectResponse|\Illuminate\Routing\Redirector
     */
    public function doLogin(Request $request)
    {
        $credentials = $request->only('email', 'password');
        if (Auth::attempt($credentials)) {
            return redirect('/user');
        }
        return back()->withErrors(['email' => '邮箱或密码错误']);
    }

    /**
     * 用户注册页面
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function register()
    {
        if (Auth::check()) {
            return redirect('/user');
        }
        return view('common.frontend.auth.register', ['page_title' => '用户注册']);
    }

    /**
     * 执行注册
     * @param Request $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function doRegister(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users'],
            'password' => ['required', 'string', 'min:8', 'confirmed'],
        ]);

        if ($validator->fails()) {
            return back()->withErrors($validator)->withInput();
        }

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        Auth::login($user);

        return redirect('/user');
    }

    /**
     * 退出登录
     * @return \Illuminate\Http\RedirectResponse|\Illuminate\Routing\Redirector
     */
    public function logout()
    {
        Auth::logout();
        return redirect('/');
    }

    /**
     * 用户中心（订单历史）
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function index()
    {
        $user = Auth::user();
        if (!$user) {
            return redirect('/login');
        }

        // 通过邮箱查找历史订单，注意 Pay ID 关联
        $orders = Order::where('email', $user->email)
            ->orderBy('id', 'desc')
            ->paginate(10);

        return view('common.frontend.user.index', [
            'orders' => $orders,
            'page_title' => '我的订单'
        ]);
    }

}
