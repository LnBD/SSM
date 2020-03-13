package cn.lbd.service;

import cn.lbd.domain.Employee;
import cn.lbd.domain.EmployeeExample;

import java.util.List;

public interface EmployeeService {
    int insert(Employee employee);

    List<Employee> selectByExampleWithDept(EmployeeExample example);

    Employee selectByPrimaryKeyWithDept(Integer empId);

    void saveEmp(Employee employee);

    Boolean checkUser(String empName);

    void updateEmp(Employee employee);

    void deleteEmp(Integer empId);

    void deleteBatch(List<Integer> del_ids);
}
