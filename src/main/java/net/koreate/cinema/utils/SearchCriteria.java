package net.koreate.cinema.utils;

/**
 * 키워드 검색 기능이 추가 된
 * 테이블 검색 파라미터 기준 정보 class
 * page				요청 페이지
 * perPageNum		요청 게시물 개수(페이지 당 출력 될 행 개수)
 * searchType		검색 열 이름
 * keyword			검색 키워드
 */
public class SearchCriteria extends Criteria {
	
	/**
	 *  검색 타입
	 *  어떤 컬럼을 기준으로 검색 할 건지 선택한 컬럼 정보 저장
	 */
	private String searchType;
	
	/**
	 *  검색 할 키워드(단어) 저장
	 */
	private String keyword;
	
	// 1 페이지 10개 이름으로...
	public SearchCriteria() {
		this(1, 10, "name", "");
	}

	public SearchCriteria(int page, int perPageNum, String searchType, String keyword) {
		super(page, perPageNum);
		this.searchType = searchType;
		this.keyword = keyword;
	}

	
	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	@Override
	public String query(int requestPage) {
		// super.query(requestPage) == ?page=1&perPageNum=30
		StringBuilder sb = new StringBuilder(super.query(requestPage));
		sb.append("&searchType=" + this.searchType);
		sb.append("&keyword=" + this.keyword);
		String query = sb.toString();
		System.out.println(query);
		return query;
	}

	@Override
	public String toString() {
		return "SearchCriteria [searchType=" + searchType + ", keyword=" + keyword + ", criteria=" + super.toString()
				+ "]";
	}
	
}
