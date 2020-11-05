package com.koi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.koi.service.LogService;

@Controller
public class LogController {
	@Autowired
	private LogService logService;
}
