package com.controller;

import com.entity.Student;
import com.entity.mapper.StudentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class Hello {
    @Autowired
    private StudentMapper studentMapper;
    @RequestMapping("/test")
    public ModelAndView test(){
        ModelAndView mv = new ModelAndView("show");
        mv.addObject("student",studentMapper.query());
        return mv;
    }
    @RequestMapping("/save")
    public String save(Student student){
        studentMapper.insert(student);
        return "redirect:/test";
    }

    @RequestMapping("/del")
    public String del(int id){
        studentMapper.delById(id);
        return "redirect:/test";
    }
}
