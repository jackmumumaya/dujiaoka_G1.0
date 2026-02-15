<?php

namespace App\Admin\Controllers;

use App\User;
use Dcat\Admin\Form;
use Dcat\Admin\Grid;
use Dcat\Admin\Show;
use Dcat\Admin\Http\Controllers\AdminController;

class FrontUserController extends AdminController
{
    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        return Grid::make(new User(), function (Grid $grid) {
            $grid->column('id')->sortable();
            $grid->column('name');
            $grid->column('email');
            $grid->column('email_verified_at');
            $grid->column('created_at');
            $grid->column('updated_at')->sortable();

            $grid->filter(function (Grid\Filter $filter) {
                $filter->equal('id');
                $filter->like('name');
                $filter->like('email');
            });
        });
    }

    /**
     * Make a show builder.
     *
     * @param mixed $id
     *
     * @return Show
     */
    protected function detail($id)
    {
        return Show::make($id, new User(), function (Show $show) {
            $show->field('id');
            $show->field('name');
            $show->field('email');
            $show->field('email_verified_at');
            $show->field('created_at');
            $show->field('updated_at');
        });
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        return Form::make(new User(), function (Form $form) {
            $form->display('id');
            $form->text('name')->required();
            $form->email('email')->required();
            $form->datetime('email_verified_at');
            $form->password('password')
                ->minLength(5)
                ->maxLength(20)
                ->customFormat(function ($v) {
                    if ($v == '') {
                        return '';
                    }
                    return $v;
                })
                ->saving(function ($v) {
                    if ($v == '' || $v == $this->password) {
                        return $v;
                    }
                    return bcrypt($v);
                });

            $form->display('created_at');
            $form->display('updated_at');
        });
    }
}
