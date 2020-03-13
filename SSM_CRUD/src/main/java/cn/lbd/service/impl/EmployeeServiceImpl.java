package cn.lbd.service.impl;

import cn.lbd.dao.EmployeeMapper;
import cn.lbd.domain.Employee;
import cn.lbd.domain.EmployeeExample;
import cn.lbd.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("employeeService")
public class EmployeeServiceImpl implements EmployeeService {
    @Autowired
    private EmployeeMapper employeeMapper;
    @Override
    public int insert(Employee employee) {
        employeeMapper.insertSelective(employee);
        return 0;
    }

    @Override
    public List<Employee> selectByExampleWithDept(EmployeeExample example) {
        List<Employee> employees = employeeMapper.selectByExampleWithDept(example);
        return employees;
    }

    @Override
    public Employee selectByPrimaryKeyWithDept(Integer empId) {
        Employee employee = employeeMapper.selectByPrimaryKeyWithDept(empId);
        return employee;
    }

    @Override
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    //true:用户名可用  false:用户名重复
    @Override
    public Boolean checkUser(String empName) {
        EmployeeExample employeeExample=new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(employeeExample);
        if(count==0){
            return true;
        }else {
            return false;
        }
    }

    @Override
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    @Override
    public void deleteEmp(Integer empId) {
        employeeMapper.deleteByPrimaryKey(empId);
    }

    @Override
    public void deleteBatch(List<Integer> del_ids) {
        EmployeeExample employeeExample=new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpIdIn(del_ids);
        //delete from xxx where emp_id in(1,2,3)
        employeeMapper.deleteByExample(employeeExample);
    }
}
