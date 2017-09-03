package com.lex.util;

import com.fh.util.Const;

/**
 * Created by chunye on 16/9/7.
 */
public enum AppResultInfoEnum {
    APP_RESULT_FAIL(Const.APP_RESULT_CODE_FAIL,"访问失败"),
    APP_RESULT_SUCCESS(Const.APP_RESULT_CODE_SUCCESS,"访问成功");

    private String resultCode;
    private String resultMessage;

    private AppResultInfoEnum(String resultCode, String resultMessage) {
        this.resultCode = resultCode;
        this.resultMessage = resultMessage;

    }

    public String getResultCode() {
        return resultCode;
    }

    public void setResultCode(String resultCode) {
        this.resultCode = resultCode;
    }

    public String getResultMessage() {
        return resultMessage;
    }

    public void setResultMessage(String resultMessage) {
        this.resultMessage = resultMessage;
    }

    // 普通方法
    public static String getResultMessage(String index) {
        for (AppResultInfoEnum c : AppResultInfoEnum.values()) {
            if (c.getResultCode() == index) {
                return c.resultMessage;
            }
        }
        return null;
    }
}
