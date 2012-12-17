package model.vo;

import java.util.ArrayList;

public class ListVO {
	private ArrayList list;
	private PagingBean bean;

	public ListVO() {
		super();
	}

	public ListVO(ArrayList list, PagingBean bean) {
		super();
		this.list = list;
		this.bean = bean;
	}

	public ArrayList getList() {
		return list;
	}

	public void setList(ArrayList list) {
		this.list = list;
	}

	public PagingBean getBean() {
		return bean;
	}

	public void setBean(PagingBean bean) {
		this.bean = bean;
	}

	public String toString() {
		return "ListVO [list=" + list + ", bean=" + bean + "]";
	}
}
