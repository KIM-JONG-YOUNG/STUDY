package egovframework.editor.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface EditorService {

	String uploadImgFile(Map<String, Object> paramMap, MultipartFile img) throws Exception;

	void createUploadFolder(Map<String, Object> paramMap) throws Exception;

	void clearUploadFolder(Map<String, Object> paramMap) throws Exception;

	void writeEditorData(Map<String, Object> paramMap) throws Exception;

	List<EgovMap> selectUploadFolderList(Map<String, Object> paramMap) throws Exception;

	void deleteFolderList(Map<String, Object> paramMap) throws Exception;
	
}
