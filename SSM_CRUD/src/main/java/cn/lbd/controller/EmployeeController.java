package cn.lbd.controller;

import cn.lbd.domain.Employee;
import cn.lbd.domain.Msg;
import cn.lbd.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/employee")
public class EmployeeController {
    @Autowired
    private EmployeeService employeeService;

    //批量单个二合一
    @RequestMapping(value = "/findAll/{empIds}",method = RequestMethod.DELETE)
    public @ResponseBody Msg deleteEmp(@PathVariable("empIds") String empIds){
        if(empIds.contains("-")){
            //批量
            //List用于存储Service层方法中Criteria拼装andEmpIdIn(）所需要的参数
            List<Integer> del_ids=new ArrayList<Integer>();
            String[] split = empIds.split("-");
            for (String s : split) {
                //将字符数组的每个元素转为int类型，加入到List集合
                del_ids.add(Integer.parseInt(s));
            }
            employeeService.deleteBatch(del_ids);
            return Msg.success();
        }else {
            //单个
            int empId = Integer.parseInt(empIds);
            employeeService.deleteEmp(empId);
            return Msg.success();
        }
    }

    @RequestMapping(value = "/findAll/{empId}",method = RequestMethod.PUT)
    public @ResponseBody Msg updateEmp(Employee employee, HttpServletRequest request){
        System.out.println(request.getParameter("gender"));
        System.out.println(employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    //根据Id查询员工信息
    @RequestMapping(value = "/findAll/{id}",method = RequestMethod.GET)
    public @ResponseBody Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.selectByPrimaryKeyWithDept(id);
        return Msg.success().add("emp",employee);
    }

    //校验用户名是否重复
    @RequestMapping("/checkempName")
    public @ResponseBody Msg checkempName(@RequestParam(value = "empName") String empName){
        //校验用户名格式
        String regName="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(!empName.matches(regName)){
            return Msg.fail().add("va_msg","用户名必须是6-16位数字和字母的组合或者2-5位中文");
        }

        //校验用户名
        Boolean checkUser = employeeService.checkUser(empName);
        if(checkUser){
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg","用户名重复");
        }
    }

    //注册方法
    @RequestMapping(value = "/findAll",method = RequestMethod.POST )
    public @ResponseBody Msg saveEmp(@Valid Employee employee, BindingResult result){
        Map<String,Object> map=new HashMap<String, Object>();
        if(result.hasErrors()){
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                String field = fieldError.getField();
                String defaultMessage = fieldError.getDefaultMessage();
                map.put(field,defaultMessage);
            }
            return Msg.fail().add("errorMessageInfo",map);
        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    @RequestMapping("/findAll")
    //返回Json格式的查询所有
    //将页面的当前页码参数绑定到Controller方法，没有传参默认值设为第一页
    public @ResponseBody Msg findAllWithJson(@RequestParam(value = "pn",defaultValue = "1") Integer pn){
        PageHelper.startPage(pn,5);
        List<Employee> employees = employeeService.selectByExampleWithDept(null);
        PageInfo<Employee> pageInfo = new PageInfo<Employee>(employees, 5);
        return Msg.success().add("pageInfo",pageInfo);
    }

    //@RequestMapping("findAll")
    //将页面的当前页码参数绑定到Controller方法，没有传参默认值设为第一页
    public String findAll(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model){
        PageHelper.startPage(pn,5);
        List<Employee> employees = employeeService.selectByExampleWithDept(null);
        PageInfo<Employee> pageInfo = new PageInfo<Employee>(employees, 5);
        model.addAttribute("pageInfo",pageInfo);
        return "list";
    }
}
