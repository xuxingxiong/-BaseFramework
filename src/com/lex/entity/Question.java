package com.lex.entity;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

/**
 * Created by chunye on 16/9/11.
 */
public class Question {
    private String user_id;
    private String question_id;
    private String question_title;
    private String question_text;
    private String hy_label;
    private String fx_label;
    private String zn_label;
    private String jn_label;
    private String question_price;
    private String spread;
    private String question_state;
    private String question_type;
    private String expire_text;

    public MultipartFile[] getPhotoFile() {
        return photoFile;
    }

    public void setPhotoFile(MultipartFile[] photoFile) {
        this.photoFile = photoFile;
    }

    public MultipartFile[] getVoiceFile() {
        return voiceFile;
    }

    public void setVoiceFile(MultipartFile[] voiceFile) {
        this.voiceFile = voiceFile;
    }

    private MultipartFile[] photoFile;
    private MultipartFile[] voiceFile;
    private String[] contacts;

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getQuestion_id() {
        return question_id;
    }

    public void setQuestion_id(String question_id) {
        this.question_id = question_id;
    }

    public String getQuestion_title() {
        return question_title;
    }

    public void setQuestion_title(String question_title) {
        this.question_title = question_title;
    }

    public String getQuestion_text() {
        return question_text;
    }

    public void setQuestion_text(String question_text) {
        this.question_text = question_text;
    }

    public String getHy_label() {
        return hy_label;
    }

    public void setHy_label(String hy_label) {
        this.hy_label = hy_label;
    }

    public String getFx_label() {
        return fx_label;
    }

    public void setFx_label(String fx_label) {
        this.fx_label = fx_label;
    }

    public String getZn_label() {
        return zn_label;
    }

    public void setZn_label(String zn_label) {
        this.zn_label = zn_label;
    }

    public String getJn_label() {
        return jn_label;
    }

    public void setJn_label(String jn_label) {
        this.jn_label = jn_label;
    }

    public String getQuestion_price() {
        return question_price;
    }

    public void setQuestion_price(String question_price) {
        this.question_price = question_price;
    }

    public String getSpread() {
        return spread;
    }

    public void setSpread(String spread) {
        this.spread = spread;
    }

    public String getQuestion_state() {
        return question_state;
    }

    public void setQuestion_state(String question_state) {
        this.question_state = question_state;
    }

    public String getQuestion_type() {
        return question_type;
    }

    public void setQuestion_type(String question_type) {
        this.question_type = question_type;
    }

    public String getExpire_text() {
        return expire_text;
    }

    public void setExpire_text(String expire_text) {
        this.expire_text = expire_text;
    }



    public String[] getContacts() {
        return contacts;
    }

    public void setContacts(String[] contacts) {
        this.contacts = contacts;
    }
}
