package com.koi.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import cn.hutool.core.io.IoUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.koi.annotation.LogAnnotation;
import com.koi.exception.CustomException;
import com.koi.pojo.URole;
import com.koi.service.UserRoleService;
import com.koi.utils.ResultInfo;
import com.koi.vo.ResuleVo;

@Controller
@RequestMapping("/role")
public class RoleController {
	@Autowired
	private UserRoleService userRoleService;

	// 分页查询角色列表或者查询角色列表
	@RequestMapping("/selectRoleList")
	public @ResponseBody
	ResuleVo selectRoleList(
			@RequestParam(value = "info", required = false) String info,
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "limit", required = false) Integer limit,
			HttpSession session) {
		long count = 0;
		List<URole> list;
		if (info != null) {// 分页查询
			PageHelper.startPage(page, limit, true);
			list = userRoleService.selectRoleByInfo(info);
			PageInfo<URole> pageInfo = new PageInfo<URole>(list);
			count = pageInfo.getTotal();
		} else {// 查询所有角色
			list = userRoleService.selectRoleByInfo(info);
		}
		ResuleVo resuleVo = ResuleVo.toLayui(count, list);
		session.setAttribute("selectRoleList", resuleVo);
		return resuleVo;
	}

	// 角色列表添加
	@RequestMapping("/addListRole")
	public @ResponseBody
	ResultInfo addListRole(@Validated URole uRole,
			BindingResult result) throws Exception {
		if (result.hasErrors()) {
			List<ObjectError> allErrors = result.getAllErrors();
			for (ObjectError objectError : allErrors) {
				return ResultInfo.setResultInfo(false,
						objectError.getDefaultMessage());
			}
		}
		return userRoleService.addRoleList(uRole);
	}

	// 角色列表修改
	@RequestMapping("/updateListRole")
	public @ResponseBody
	ResultInfo updateListRole(
			@Validated URole uRole,
			BindingResult result) throws Exception {
		if (result.hasErrors()) {
			List<ObjectError> allErrors = result.getAllErrors();
			for (ObjectError objectError : allErrors) {
				return ResultInfo.setResultInfo(false,
						objectError.getDefaultMessage());
			}
		}
		return userRoleService.updateRoleList(uRole);
	}

	// 角色列表删除
	@RequestMapping("/deleteRoleListById")
	public @ResponseBody
	ResultInfo deleteRoleListById(int[] ids) throws Exception {
		return userRoleService.deleteRoleListById(ids);// 批量或者单个删除
	}
	
	// 角色列表导出Excel
	@RequestMapping("/exportExcel")
	@LogAnnotation(operateType="导出角色")
	public void exportExcel(HttpServletResponse response, HttpSession session)
			throws IOException, CustomException {
		// 获取session数据
		ResuleVo resuleVo = (ResuleVo) session.getAttribute("selectRoleList");
		if (resuleVo != null) {
			// 通过工具类创建writer，默认创建xls格式
			ExcelWriter writer = ExcelUtil.getWriter();
			// 一次性写出内容，使用默认样式，强制输出标题
			writer.write((Iterable<?>) resuleVo.getData(), true);
			String filename = "角色列表" + System.currentTimeMillis() + ".xls";// 文件名称
			String resetName = new String(filename.getBytes(), "ISO-8859-1");// 设置fileName的编码
			response.setContentType("application/vnd.ms-excel;charset=utf-8");// 设置响应的格式
			response.setHeader("Content-Disposition", "attachment;filename="
					+ resetName);// 设置响应头内容，设置文件名称
			ServletOutputStream outputStream = response.getOutputStream();// 创建响应输出流
			writer.flush(outputStream, true);
			writer.close();
			// 此处记得关闭输出Servlet流
			IoUtil.close(outputStream);
		} else {
			throw new CustomException("要导出的数据不存在，请尝试重新登录");
		}
	}

	// 角色列表导入Excel (主要 MultipartFile对象名与表单name对应)
	@RequestMapping(value = "/importExcel", method = RequestMethod.POST)
	public @ResponseBody
	ResultInfo importExcel(MultipartFile file) throws CustomException {
		if (!file.isEmpty()) {
			String fileName = file.getOriginalFilename();
			if (fileName.indexOf(".xls") > 0) {
				try {
					InputStream inputStream = file.getInputStream();// 获取文件流
					POIFSFileSystem fs = new POIFSFileSystem(inputStream);
					HSSFWorkbook workbook = new HSSFWorkbook(fs);// 创建工作簿对象
					HSSFSheet sheet = workbook.getSheetAt(0);// 获取第一个工作表
					List<URole> list = new ArrayList<URole>();
					for (int i = 1; i <= sheet.getLastRowNum(); i++) {
						URole role = new URole();
						HSSFRow rows = sheet.getRow(i);// 获取Excel表格行数据
						role.setName(rows.getCell(1).getStringCellValue());
						role.setType(rows.getCell(2).getStringCellValue());
						list.add(role);
					}
					userRoleService.addBatchRoleList(list);
					return ResultInfo.setResultInfo(true,
							"成功导入" + sheet.getLastRowNum() + "条数据");
				} catch (IOException e) {
					throw new CustomException("上传失败");
				} catch (Exception e) {
					throw new CustomException("上传失败");
				}
			} else {
				return ResultInfo.setResultInfo(false, "不支持该文件格式");
			}
		} else {
			return ResultInfo.setResultInfo(false, "上传文件不存在");
		}
	}

	// 查询角色分配列表
	@RequestMapping("/selectRoleAllocation")
	public @ResponseBody
	ResuleVo selectRoleAllocation(String info, Integer page, Integer limit) {
		return userRoleService.selectRoleAllocation(info, page, limit);
	}

	// 角色分配保存
	@RequestMapping("/saveRoleAllocation")
	public @ResponseBody
	ResultInfo saveRoleAllocation(Integer uId, Integer[] roleIds)
			throws Exception {
		return userRoleService.saveRoleAllocation(uId, roleIds);
	}

	// 角色分配清空
	@RequestMapping("/deleteRoleAllocationByUseRId")
	public @ResponseBody
	ResultInfo deleteRoleAllocationByUseRId(int[] userIds)
			throws Exception {
		return userRoleService.deleteRoleAllocationByUserRId(userIds);
	}

}
