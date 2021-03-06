package com.entity.mapper;

import com.entity.Student;
import org.apache.ibatis.annotations.Insert;

import java.util.List;


public interface StudentMapper {
    public List<Student> query();
    public int delById(int id);
    @Insert("insert into student values(null,#{uname},#{address})")
    public int insert(Student student);
}
