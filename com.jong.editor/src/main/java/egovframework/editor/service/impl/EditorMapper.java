package egovframework.editor.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("editorMapper")
public interface EditorMapper {

	List<EgovMap> selectUploadFolderList(Map<String, Object> paramMap) throws Exception;

	void insertUploadFolderOne(Map<String, Object> paramMap) throws Exception;

	void updateUploadFolderOne(Map<String, Object> paramMap) throws Exception;

	void deleteFolderList(Map<String, Object> paramMap) throws Exception;
	
}
