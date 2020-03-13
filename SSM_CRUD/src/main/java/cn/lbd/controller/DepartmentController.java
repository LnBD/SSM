package cn.lbd.controller;

import cn.lbd.domain.Department;
import cn.lbd.domain.Msg;
import cn.lbd.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/department")
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("/findAll")
    public @ResponseBody Msg findAll(){
        List<Department> departments = departmentService.findAll();
        return Msg.success().add("depts",departments);
    }
}
