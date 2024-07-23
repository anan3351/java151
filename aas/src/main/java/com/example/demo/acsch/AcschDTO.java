package com.example.demo.acsch;

public class AcschDTO {
    private int acsch_id;
    private int casting_id;
    private int ticket_id;
    
    public AcschDTO() {}

	public int getAcsch_id() {
		return acsch_id;
	}

	public void setAcsch_id(int acsch_id) {
		this.acsch_id = acsch_id;
	}

	public int getCasting_id() {
		return casting_id;
	}

	public void setCasting_id(int casting_id) {
		this.casting_id = casting_id;
	}

	public int getTicket_id() {
		return ticket_id;
	}

	public void setTicket_id(int ticket_id) {
		this.ticket_id = ticket_id;
	}

	@Override
	public String toString() {
		return "AcschDTO [acsch_id=" + acsch_id + ", casting_id=" + casting_id + ", ticket_id=" + ticket_id + "]";
	}
    
    

}//class end
