﻿<%@ WebHandler Language="C#" Class="News" %>

using System;
using System.Web;
using System.Web.UI;

public class News : IHttpHandler {
   

    public void ProcessRequest(HttpContext context)
    {
        HttpPostedFile uploads = context.Request.Files["upload"];
        string CKEditorFuncNum = context.Request["CKEditorFuncNum"];
        string file = System.IO.Path.GetFileName(uploads.FileName);
        uploads.SaveAs(context.Server.MapPath("~/Upload/NewsImage/" + file));
        string url =  "../../Upload/NewsImage/" + file;
        context.Response.Write("<script>window.parent.CKEDITOR.tools.callFunction(" + CKEditorFuncNum + ", \"" + url + "\");</script>");
        context.Response.End();
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}