package egovframework.editor.service.impl;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import egovframework.cmmn.EgovSampleOthersExcepHndlr;
import egovframework.editor.service.EditorService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("editorService")
public class EditorServiceImpl implements EditorService {
	private static final Logger LOGGER = LoggerFactory.getLogger(EditorServiceImpl.class);
	
	@Resource(name = "editorMapper")
	private EditorMapper editorMapper;
	
	@Override
	public String uploadImgFile(Map<String, Object> paramMap, MultipartFile img) throws Exception {
		// TODO Auto-generated method stub
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss", Locale.KOREA);
		Date curTime = new Date();
		String formatTime = dateFormat.format(curTime);
		
		String uploadDir = paramMap.get("uploadDir").toString();
		String uploadFolder = paramMap.get("uploadFolder").toString();
		String orgImgName = img.getOriginalFilename();
		
		img.transferTo(new File(uploadDir + File.separator + uploadFolder + File.separator + formatTime + orgImgName.substring(orgImgName.lastIndexOf("."))));
		
		return formatTime + orgImgName.substring(orgImgName.lastIndexOf("."));
	}
	
	@Override
	public void createUploadFolder(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		String uploadDir = paramMap.get("uploadDir").toString();
		String uploadFolder = paramMap.get("uploadFolder").toString();
		
		File folder = new File(uploadDir + File.separator + uploadFolder);
		if (!folder.exists()) {
			folder.mkdir(); // 폴더 생성합니다.
			LOGGER.info(folder.getPath() + " 폴더가 생성되었습니다.");
			editorMapper.insertUploadFolderOne(paramMap);
		} else {
			LOGGER.info("이미 폴더가 생성되어 있습니다.");
		}
	}
	
	@Override
	public void clearUploadFolder(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		String uploadDir = paramMap.get("uploadDir").toString();
		String uploadFolder = paramMap.get("uploadFolder").toString();
		List<String> imgNmList = new ArrayList<>();
		
		if (paramMap.get("imgNmArr") != null && !paramMap.get("imgNmArr").toString().equals("")) {
			imgNmList = Arrays.asList(paramMap.get("imgNmArr").toString().split(","));
		}
		
		File folder = new File(uploadDir + File.separator + uploadFolder);
		if (folder.exists()) {
			File[] fileList = folder.listFiles(); // 파일리스트 얻어오기
			for (File file : fileList) {
				String fileName = file.getName();
				if (!imgNmList.contains(fileName)) {
					file.delete();
					LOGGER.info(fileName + " 파일이 삭제되었습니다.");
				}
			}
		} else {
			throw new Exception("이미지 업로드 폴더가 존재하지 않습니다. 폴더명 : " + uploadDir + File.separator + uploadFolder);
		}
	}

	@Override
	public void writeEditorData(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		clearUploadFolder(paramMap);
		editorMapper.updateUploadFolderOne(paramMap);
	}

	@Override
	public List<EgovMap> selectUploadFolderList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return editorMapper.selectUploadFolderList(paramMap);
	}

	@Override
	public void deleteFolderList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		List<EgovMap> delFolderList = selectUploadFolderList(paramMap);
		String uploadDir = paramMap.get("uploadDir").toString();
		File folder = null;
		for (EgovMap egovMap : delFolderList) {
			folder = new File(uploadDir + File.separator + egovMap.get("uploadFolder"));
			if (folder.exists()) {
				File[] fileList = folder.listFiles(); // 파일리스트 얻어오기
				for (File file : fileList) {
					file.delete();
					LOGGER.info(file.getName() + " 파일이 삭제되었습니다.");
				}
				folder.delete();
			} 
		}
		editorMapper.deleteFolderList(paramMap);
	}
	
}
