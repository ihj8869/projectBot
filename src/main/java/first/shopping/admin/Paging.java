package first.shopping.admin;

import java.util.HashMap;

public class Paging {
	
	public HashMap<String, Object> paging(int pageScale, int totalRow, String page) {
		
		 int totalPage=totalRow%pageScale==0?totalRow/pageScale:totalRow/pageScale+1;
		 System.out.println("test 1234 = " + totalPage);
		    totalPage=totalPage==0?1:totalPage; 
		    int currentPage=1;
		    String temp="1";
		    try{
		    	temp=page;
		    	currentPage=Integer.parseInt(temp);
		    }catch(Exception e){
		    	
		    }
		    int start=1+(currentPage-1)*pageScale;
		    int end=pageScale+(currentPage-1)*pageScale;
		    int currentBlock=currentPage%pageScale==0?currentPage/pageScale:currentPage/pageScale+1;
		    int startPage=1+(currentBlock-1)*pageScale;
		    int endPage=pageScale+(currentBlock-1)*pageScale;
		    endPage=totalPage<=endPage?totalPage:endPage;
		    
		    HashMap<String, Object> map = new HashMap<>();
		    map.put("start", start);
		    map.put("end", end);
		    map.put("startPage", startPage);
		    map.put("endPage", endPage);
		    map.put("currentPage", currentPage);
		    map.put("currentBlock", currentBlock);
		    map.put("totalPage", totalPage);
		    map.put("totalRow", totalRow);
		    
		    return map;
	}
}
