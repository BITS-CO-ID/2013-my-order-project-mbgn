<%@ Page Title="" Language="C#" MasterPageFile="~/Site/CMS.Master" AutoEventWireup="true"
    CodeBehind="QAList.aspx.cs" Inherits="Ecms.Website.Site.MBGN2.QAList" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <div class="contener">
        <div id="qaContent">
            <div class="qafirst">
                <a href='<%= ResolveUrl("~/hoidap-0.htm")%>'>
                    <img height="169px" width="710px" src="../../content2/images/qa_cau_hoi.png" alt="hoi dap thuong gap" /></a>
                <h3>
                    Khách mới - làm thế nào để</h3>
                <asp:Literal ID="litQAHeader" runat="server"></asp:Literal>
            </div>
            <asp:Literal ID="litQA" runat="server"></asp:Literal>
        </div>
    </div>
    <!-- # End page content -->
</asp:Content>
