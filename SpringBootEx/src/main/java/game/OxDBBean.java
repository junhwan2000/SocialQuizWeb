package game;

import java.util.List;

import jakarta.annotation.Resource;

public class OxDBBean {
	@Resource
	private OxMapper oxMapper;
	
	public List<OxDataBean> getOxQuiz(){
        return oxMapper.getOxQuiz(); 
    }
}
