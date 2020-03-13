package cn.lbd.service.impl;

import cn.lbd.dao.DepartmentMapper;
import cn.lbd.domain.Department;
import cn.lbd.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("departmentService")
public class DepartmentServiceImpl implements DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;
    @Override
    public List<Department> findAll() {
        List<Department> departments = departmentMapper.selectByExample(null);
        return departments;
    }

}
