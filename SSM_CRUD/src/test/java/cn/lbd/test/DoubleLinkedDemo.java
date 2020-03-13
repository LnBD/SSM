package cn.lbd.test;

public class DoubleLinkedDemo {
	
	public static void main(String[] args) {
		HeroNode3 hero1 = new HeroNode3(1, "宋江","及时雨");
		HeroNode3 hero2 = new HeroNode3(2, "卢俊义","玉麒麟");
		HeroNode3 hero3 = new HeroNode3(3, "吴用","智多星");
		HeroNode3 hero4 = new HeroNode3(4, "林冲", "豹子头");
		DoubleLiked link = new DoubleLiked();
		link.addById(hero1);
		link.addById(hero2);
		link.addById(hero4);
		link.addById(hero3);
		
		link.show();
	}
}

class DoubleLiked{
	
	private HeroNode3 head = new HeroNode3(0,"","");
	
	public void addById(HeroNode3 heroNode) {
		HeroNode3 temp = head;
		boolean flag = false;
		while(true) {
			if(temp.next == null) {
				break;
			}
			if(temp.next.no > heroNode.no) {
				break;
			}else if(temp.next.no == heroNode.no) {
				flag = true;
				break;
			}
			temp = temp.next;
		}
		if(flag) {
			System.out.println("该英雄存在");
		}else {
			heroNode.next = temp.next;
			temp.next.pre = heroNode;
			temp = heroNode.pre;
			temp.next = heroNode;
		}
	}
	
	
	
	public void delete(int id) {
		HeroNode3 temp = head.next;
		boolean flag = false;
		while(true) {
			if(temp.no == id) {
				flag = true;
				break;
			}
			temp = temp.next;
		}
		if(flag) {
			temp.pre.next = temp.next;
			if(temp.next != null) {
				temp.next.pre = temp.pre;
			}
		}
		
	}
	
	public void add(HeroNode3 heroNode) {
		HeroNode3 temp = head;
		while(true) {
			if(temp.next == null) {
				break;
			}
			temp = temp.next;
		}
		temp.next = heroNode;
		heroNode.pre = temp;
	}
	
	public void show() {
		if(head.next == null) {
			System.out.println("空链表");
		}
		HeroNode3 temp = head.next;
		while(true) {
			if(temp == null) {
				break;
			}else {
				System.out.println(temp);
				temp = temp.next;
			}
			
		}
	}
}

class HeroNode3{
	Integer no;
	String name;
	String nickName;
	HeroNode3 next;
	HeroNode3 pre;
	public HeroNode3(Integer no,String name,String nickName) {
		this.no = no;
		this.name = name;
		this.nickName = nickName;
	}
	@Override
	public String toString() {
		return "HeroNode [no=" + no + ", name=" + name + ", nickName=" + nickName + "]";
	}
	
}