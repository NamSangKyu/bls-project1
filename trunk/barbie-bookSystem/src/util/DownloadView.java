package util;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class DownloadView extends AbstractView {
	// 다운로드 파일의 컨텐트 타입을 지정
	public String getContentType() {
		return "application/octet-stream";
	}

	protected void renderMergedOutputModel(Map<String, Object> map, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("DownloadView 실행");
		String path = (String) map.get("path");
		String orgFileName = request.getParameter("orgFileName");
		String newFileName = request.getParameter("newFileName");
		
		// 업로드 경로가 저장된 파일 객체
		File file = new File(path + newFileName);
		
		// 파일 다운로드
		response.setContentType(this.getContentType());
		response.setContentLength((int) file.length());// 파일 크기 설정
		// 다운로드 파일에 대한 설정
		response.setHeader("Content-Disposition", "attachment; fileName="+new String(orgFileName.getBytes("UTF-8"), "8859_1"));
		// 데이터 인코딩이 바이너리 파일임을 명시
		response.setHeader("Content-Transfer-encoding", "binary");
		// 실제 업로드 파일을 inputStream 으로 읽어서
		// response 에 연결된 OutputStream으로 전송
		OutputStream os = response.getOutputStream();
		FileInputStream fis = new FileInputStream(file);
		FileCopyUtils.copy(fis, os);
		System.out.println("Download 시작");
	}
}
