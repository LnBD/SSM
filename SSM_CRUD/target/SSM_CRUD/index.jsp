<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.3.1.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<!-- 员工编辑模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>


            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                            <span class="help-block">

                            </span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_update_input" placeholder="xxxx@.qq.com">
                            <span class="help-block">

                            </span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="男" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">所属部门</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门id即可 -->
                            <select class="form-control" name="dId" id="dept_update_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工新增模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工注册</h4>
            </div>


            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="员工姓名">
                            <span class="help-block">

                            </span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_add_input" placeholder="xxxx@.qq.com">
                            <span class="help-block">

                            </span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="男" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">所属部门</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门id即可 -->
                            <select class="form-control" name="dId" id="dept_add_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>


<!-- 搭建分页显示页面 -->
<div class="container">
    <!--标题-->
    <div class="row">
        <div class="col-md-12">
            <h2>人事管理系统</h2>
        </div>
    </div>
    <!--操作-->
    <div class="row">
        <div class="col-md-4 col-md-offset-10">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <!--表格-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th> </th>
                    <th>#</th>
                    <th>员工姓名</th>
                    <th>性别</th>
                    <th>邮箱</th>
                    <th>部门</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
    <!--分页-->
    <div class="row">
        <!--分页文字信息-->
        <div class="col-md-6" id="page_info_area"></div>
        <!--分页条-->
        <div class="col-md-6" id="page_nav_area"></div>
    </div>
</div>
<script type="text/javascript">
    //全局变量，总页数和当前页码
    var totalpage,currentPage;
    //加载时执行，默认跳转到第一页
    $(function () {
       to_page(1);
    });

    //跳转逻辑
    function to_page(pn) {
        $.get("${APP_PATH}/employee/findAll",{"pn":pn},function (result) {
            //1.解析并显示员工数据
            build_emps_table(result);
            //2.解析并显示分页信息
            build_page_info(result);
            //3.解析并显示分页条信息
            build_page_nav(result);
        },"json");
    }
    //单个删除
    $(document).on("click",".delete_btn",function () {
       var empName=$(this).parents("tr").find("td:eq(3)").text();
       var empId=$(this).attr("del_empId");
       if(confirm("确认删除【"+empName+"】吗？")){
           $.ajax({
               url:"${APP_PATH}/employee/findAll/"+empId,
               type:"DELETE",
               success:function (data) {
                   alert(data.msg);
                   to_page(currentPage);
               }
           });
       }
    });
    //全选|全不选,每个复选按钮的被选中属性与全选的一致
    $("#check_all").click(function () {
        $(".check_item").prop("checked",$(this).prop("checked"));
    });
    //所有check_item被选上，check_all也被选上
    $(document).on("click",".check_item",function () {
        //判断当前选择中的元素是否为当前所有check_item个数，是即全选，全选按钮打勾，否则不打勾
        var flag=$(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });
    //批量删除
    $("#emp_delete_all_btn").click(function () {
        var empName="";
        var empIds="";
        $(".check_item:checked").each(function () {
           empName+=$(this).parents("tr").find("td:eq(3)").text()+",";
           empIds+=$(this).parents("tr").find("td:eq(2)").text()+"-";
        });
        empName=empName.substring(0,empName.length-1);
        empIds=empIds.substring(0,empIds.length-1);
        if(confirm("确认删除【"+empName+"】吗？")){
            $.ajax({
               url:"${APP_PATH}/employee/findAll/"+empIds,
               type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });

    //绑定编辑按钮点击事件，此处若使用click会导致按钮在创建前被绑定，从而绑定不上，改为用on即将时机改变为创建时绑定
    $(document).on("click",".edit_btn",function () {
        //展示部门信息
       getDepts("#dept_update_select");
       //回显需要修改信息的员工原来的信息
        getEmp($(this).attr("edit_empId"));
        //将编辑按钮上的empId传递给更新按钮
        $("#emp_update_btn").attr("edit_empId",$(this).attr("edit_empId"));
        //弹出修改模态框
        $("#empUpdateModal").modal({
            //点击背景不退出
            backdrop:"static"
        });
    });

    //绑定更新事件
    $("#emp_update_btn").click(function () {
        //邮箱校验
        var email=$("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            show_validate_msg("#email_update_input","error","邮箱格式不正确");
            return false;
        }else {
            show_validate_msg("#email_update_input","success","");
        }
        //异步请求提交修改信息
       $.ajax({
          url:"${APP_PATH}/employee/findAll/"+$(this).attr("edit_empId"),
          type:"PUT",
          data:$("#empUpdateModal form").serialize(),
           success:function (result) {
              if(result.code==200){
                  //关闭修改模态框
                  $("#empUpdateModal").modal('hide');
                  //跳到当前修改页面
                  to_page(currentPage);
              }
          }
       });
    });
    //点击更新按钮时将原来数据回显到对应位置
    function getEmp(id) {
        $.get("${APP_PATH}/employee/findAll/"+id,function (result) {
            var empData=result.extend.emp;
            $("#empName_update_static").text(empData.empName);
            $("#email_update_input").val(empData.email);
            $("#empUpdateModal input[name=gender]").val([empData.gender]);
            $("#empUpdateModal select").val([empData.dId]);
        },"json");
    }
    //清空表单样式及内容
    function reset_form(ele){
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find(".help-block").text("");
    }
    //绑定“新增”的事件：点击新增按钮，弹出注册模态框
    $("#emp_add_modal_btn").click(function () {
        //每次进入模态框前，先清空先前表单样式及内容
        reset_form("#empAddModal form");
        //查出所有部门名称填充到下拉列表框中
        getDepts("#dept_add_select");
        //调用方法，触发弹出
        $("#empAddModal").modal({
            //点击背景不退出
            backdrop:"static"
        });
    });

    //查出所有部门名称填充到下拉列表框中
    function getDepts(ele) {
        $(ele).empty();
        $.get("${APP_PATH}/department/findAll","",function (data) {
            $.each(data.extend.depts,function (index,item) {
                // <option value=1>开发部</option>
                var option=$("<option></option>").append(item.deptName).attr("value",item.deptId);
                option.appendTo(ele);
            });
        },"json");
    }

    //用户名重复校验
    $("#empName_add_input").change(function () {
        var empName=this.value;
        $.get("${APP_PATH}/employee/checkempName",{"empName":empName},function (data) {
            if(data.code==200){
                //用户名不重复,成功
                show_validate_msg("#empName_add_input","success","用户名可用");
                $("#emp_save_btn").attr("ajax_va","success");
            }else if(data.code==500){
                //用户名重复，失败
                show_validate_msg("#empName_add_input","error",data.extend.va_msg);
                $("#emp_save_btn").attr("ajax_va","error");
            }
        },"json");
    });

    //绑定新增模态框中“保存”的事件：点击保存按钮，提交数据到后台
    $("#emp_save_btn").click(function () {
        //用户名，邮箱格式校验，校验不通过，则不执行下面的步骤
        if(!validate_add_form()){
            return false;
        }
        //用户名重复校验，校验不通过，则不执行下面的步骤（发送异步请求）
        if($(this).attr("ajax_va")=="error"){
            return false
        }
       $.post("${APP_PATH}/employee/findAll",$("#empAddModal form").serialize(),function (data) {
           if(data.code==200){
               $("#empAddModal").modal('hide');
           }else {
               if(undefined!=data.extend.errorMessageInfo.email){
                   //邮箱字段有错误提示信息，说明邮箱校验不通过
                   show_validate_msg("#email_add_input","error",data.extend.errorMessageInfo.email);
               }
               if(undefined!=data.extend.errorMessageInfo.empName){
                   //员工姓名字段有错误提示信息，说明员工姓名校验不通过
                   show_validate_msg("#empName_add_input","error",data.extend.errorMessageInfo.empName);
               }
           }
       },"json");
    });

    //表单数据校验
    function validate_add_form() {
        //检验用户名,用正则表达式
        var empName=$("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(!regName.test(empName)){
            //alert("用户名格式不正确");
            /*$("#empName_add_input").parent().addClass("has-error");
            $("#empName_add_input").next("span").text("用户名格式不正确");*/
            show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者6-16位英文和数字的组合");
            return false;
        }else {
            show_validate_msg("#empName_add_input","success","");
            /*$("#empName_add_input").parent().addClass("has-success");
            $("#empName_add_input").next("span").text("");*/
        }
        //检验邮箱
        var email=$("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            show_validate_msg("#email_add_input","error","邮箱格式不正确");
            //alert("邮箱格式不正确");
            /*$("#email_add_input").parent().addClass("has-error");
            $("#email_add_input").next("span").text("邮箱格式不正确");*/
            return false;
        }else {
            show_validate_msg("#email_add_input","success","");
            /*$("#email_add_input").parent().addClass("has-success");
            $("#email_add_input").next("span").text("");*/
        }
        return true;
    }

    //显示校验结果的提示信息。ele:校验的对象id(#XXX)  status:用于标志校验结果的状态码(success  error)  msg:错误时的提示信息
    function show_validate_msg(ele,status,msg) {
        //由于是异步机制，每次回显检验信息前需要清楚上一次样式及其文本的内容
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if(status=="success"){
            //校验没有问题
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }
        else if(status=="error"){
            //校验有问题
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //解析并显示员工数据
    function build_emps_table(result) {
        $("#emps_table tbody").empty();
        var lists=result.extend.pageInfo.list;
        $.each(lists,function (index, item) {
            var checkBoxTd=$("<td><input type='checkbox' class='check_item'/><td>")
            var empId=$("<td></td>").append(item.empId);
            var empName=$("<td></td>").append(item.empName);
            var gender=$("<td></td>").append(item.gender);
            var email=$("<td></td>").append(item.email);
            var deptName=$("<td></td>").append(item.department.deptName);
            var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
            editBtn.attr("edit_empId",item.empId);
            var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            delBtn.attr("del_empId",item.empId);
            var Btn=$("<td></td>").append(editBtn).append(" ").append(delBtn);
            var tr=$("<tr></tr>").append(checkBoxTd).append(empId).append(empName).append(gender).append(email).append(deptName).append(Btn);
            tr.appendTo($("#emps_table tbody"));
        });
    }

    //解析并显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前 "+result.extend.pageInfo.pageNum+" 页，共 "+result.extend.pageInfo.pages+" 页，有 "+result.extend.pageInfo.total+" 条记录");
        totalpage=result.extend.pageInfo.total;
        currentPage=result.extend.pageInfo.pageNum;
    }

    //解析并显示分页条及其信息
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var navEle=$("<nav></nav>");
        var ul=$("<ul></ul>").addClass("pagination");

        var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extend.pageInfo.hasPreviousPage==false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled")
        }else {
            firstPageLi.click(function () {
               to_page(1);
            });
            prePageLi.click(function () {
               to_page(result.extend.pageInfo.pageNum-1);
            });
        }
        ul.append(firstPageLi).append(prePageLi);
        var lastPageLi=$("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
        var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
        if(result.extend.pageInfo.hasNextPage==false){
            lastPageLi.addClass("disabled");
            nextPageLi.addClass("disabled");
        }else {
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum+1);
            });
        }
        $.each(result.extend.pageInfo.navigatepageNums,function (index, item) {
            var numPageLi= $("<li></li>").append($("<a></a>").append(item));
            if(item==result.extend.pageInfo.pageNum){
                numPageLi.addClass("active");
            }
            numPageLi.click(function () {
                to_page(item);
            });
            ul.append(numPageLi);
        });
        ul.append(nextPageLi).append(lastPageLi);
        navEle.append(ul).appendTo("#page_nav_area");
    }

</script>
</body>
</html>

