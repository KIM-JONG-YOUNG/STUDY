package egovframework.editor.web;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import egovframework.editor.service.EditorService;
import egovframework.editor.service.impl.EditorServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class EditorController {
	private static final Logger LOGGER = LoggerFactory.getLogger(EditorController.class);
	
	@Resource(name = "gson")
	private Gson gson;
	
	@Resource(name = "editorService")
	private EditorService editorService;
	
	@Resource(name = "propertiesService")
	private EgovPropertyService propertiesService;
	
	@RequestMapping(value = "editorMain.do")
	public String editorMain(Model model) throws Exception {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss", Locale.KOREA);
		Date curTime = new Date();
		String formatTime = dateFormat.format(curTime);
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("uploadDir", propertiesService.getString("uploadDir"));
		paramMap.put("uploadFolder", formatTime);
		
		// 업로드 폴더 생성 및 사용여부 'N'으로 데이터베이스 저장
		editorService.createUploadFolder(paramMap);
		
		model.addAttribute("uploadFolder", formatTime);
		
		return "editor/editorMain";
	}
	
	@RequestMapping(value = "imgUpload.do")
	@ResponseBody
	public String imgUpload(HttpServletRequest req, @RequestParam MultipartFile img, Model model) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("width", req.getParameter("width"));
		paramMap.put("height", req.getParameter("height"));
		paramMap.put("uploadDir", propertiesService.getString("uploadDir"));
		paramMap.put("uploadFolder", req.getParameter("uploadFolder"));
		
		// 이미지 업로드
		String imgSrc = editorService.uploadImgFile(paramMap, img);
		
		paramMap.put("uploadPath", propertiesService.getString("uploadPath"));
		paramMap.put("imgSrc", imgSrc);
		
		return gson.toJson(paramMap);
	}
	
	@RequestMapping(value = "write.do")
	public String write(@RequestParam Map<String, Object> paramMap, Model model) throws Exception {
		paramMap.put("uploadDir", propertiesService.getString("uploadDir"));
		
		// 업로드 폴더 내부의 사용하지 않은 이미지 삭제
		// 업로드 폴더 사용여부 'Y'로 변경
		editorService.writeEditorData(paramMap);
		
		return "redirect:editorMain.do";
	}
	
	@RequestMapping(value = "uploadFolderList.do")
	public String uploadFolderList(@RequestParam Map<String, Object> paramMap, Model model) throws Exception {
		List<EgovMap> list = editorService.selectUploadFolderList(paramMap);
		model.addAttribute("uploadDir", propertiesService.getString("uploadDir"));
		model.addAttribute("uploadFolderList", list);
		return "editor/uploadFolderList";
	}
	
	@RequestMapping(value = "deleteFolder.do")
	@ResponseBody
	public String deleteFolder(@RequestParam String delDate) throws Exception {
		LOGGER.info(delDate);
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("uploadDir", propertiesService.getString("uploadDir"));
		paramMap.put("delDate", delDate);
		paramMap.put("useYn", "N");
		
		editorService.deleteFolderList(paramMap);

		paramMap.put("result", "success");
		return gson.toJson(paramMap);
	}
}
