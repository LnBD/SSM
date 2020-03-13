package cn.lbd.test;

import cn.lbd.dao.EmployeeMapper;
import cn.lbd.domain.Employee;
import cn.lbd.domain.EmployeeExample;
import cn.lbd.service.EmployeeService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.swing.*;
import java.util.List;
import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:ApplicationContext.xml")
public class TestDao {
    @Autowired
    private EmployeeService employeeService;
    @Autowired
    private SqlSession sqlSession;
    private EmployeeExample example=new EmployeeExample();
    @Test
    public void test(){
        Employee employee = employeeService.selectByPrimaryKeyWithDept(5);
        System.out.println(employee);
    }
    @Test
    public void findAll(){
        List<Employee> employees = employeeService.selectByExampleWithDept(example);
        for (Employee employee : employees) {
            System.out.println(employee);
        }
    }
    @Test
    public void test1(){
        EmployeeExample.Criteria criteria= example.createCriteria();
        criteria.andDIdEqualTo(1);
        criteria.andEmpNameLike("%飞%");
        EmployeeExample.Criteria criteria1=example.createCriteria();
        criteria1.andEmpNameEqualTo("王五");
        example.or(criteria1);
        Page<Object> page = PageHelper.startPage(1, 2);
        //开启分页后，Employee对象会变为Page对象
        List<Employee> employees = employeeService.selectByExampleWithDept(example);
        PageInfo<Employee> pageInfo=new PageInfo<Employee>(employees,2);
        System.out.println(employees);
        for (Employee employee : employees) {
            System.out.println(employee);
        }
        System.out.println("当前页码"+pageInfo.getPageNum());
        System.out.println("总页数"+pageInfo.getPages());
        System.out.println("每页大小"+pageInfo.getPageSize());
        System.out.println("总记录数"+pageInfo.getTotal());
        int[] navigatepageNums = pageInfo.getNavigatepageNums();
        for (int navigatepageNum : navigatepageNums) {
            System.out.println("第"+navigatepageNum+"页");
        }
    }
    @Test
    public void test2(){
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for(int i=0;i<1000;i++){
            String uid= UUID.randomUUID().toString().substring(0,5)+i;
            Employee employee=new Employee();
            employee.setEmpName(uid);
            employee.setGender("男");
            employee.setEmail(uid+"@qq.com");
            employee.setdId(1);
            mapper.insertSelective(employee);
        }
        System.out.println("批量完成");
    }
    @Test
    public void test3(){
        Page<Object> page = PageHelper.startPage(20, 20);
        //开启分页后，Employee对象会变为Page对象
        List<Employee> employees = employeeService.selectByExampleWithDept(example);
        PageInfo<Employee> pageInfo=new PageInfo<Employee>(employees,15);
        System.out.println(employees);
        for (Employee employee : employees) {
            System.out.println(employee);
        }
        System.out.println("当前页码"+pageInfo.getPageNum());
        System.out.println("总页数"+pageInfo.getPages());
        System.out.println("每页记录数"+pageInfo.getPageSize());
        System.out.println("总记录数"+pageInfo.getTotal());
        int[] navigatepageNums = pageInfo.getNavigatepageNums();
        for (int navigatepageNum : navigatepageNums) {
            System.out.println("第"+navigatepageNum+"页");
        }
    }
}
