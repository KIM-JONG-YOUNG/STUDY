#com.jong.editor
이미지 업로드가 가능한 에디터 제작
 
#에디터 작성
1.Controller:이미지를 업로드할 폴더 생성 (폴더명 : yyyyMMddHHmmss)
	     생성한 폴더명을 데이터 베이스에 저장 (사용여부를 N으로 하여 저장)<-추후에 에디터를 통해 글을 작성할 때 사용여부를 Y로 변경
2.JSP:자바스크립트 및 제이쿼리를 이용하여 에디터 생성
      에디터를 통해 이미지 업로드 및 내용 작성
	-이미지를 Ajax를 통해 전송 (이미지 접근 URL 받음)
      작성된 내용 컨트롤러로 전송
	-에디터의 html 내용
	-작성한 글의 이미지 업로드 폴더명
	-마지막에 작성한 html에서 사용한 이미지의 파일명들
3.Controller:JSP에서 받은 업로드 폴더명과 이미지 파일명들을 통해 업로드 폴더 정리 (사용되지 않을 이미지 파일 삭제)
	     1에서 데이터베이스에 저장한 사용여부를 Y로 변경

#사용하지 않는 폴더 및 이미지 삭제
1.JSP:yyyyMMddHHmmss 형식으로 폴더명을 입력
2.Controller:데이터베이스에서 폴더명 조회
		-사용여부 = N
		-폴더명 < 입력받은 폴더명 (yyyyMMddHHmmss 형식이기 때문에 모두 숫자)
	     조회된 폴더명 목록을 통해 해당 폴더 및 폴더 내의 파일 일괄 삭제
