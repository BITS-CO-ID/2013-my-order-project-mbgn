using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ecms.Biz.Entities;
using Ecms.Biz;
using Ecms.Website.Common;
using Ecms.Website.DBServices;
using System.Web.Security;
using System.Text;

namespace Ecms.Website.Site.PartControl2
{
    public partial class Header : System.Web.UI.UserControl
    {
        protected List<Ecms.Website.Site.MBGN.CartModel> lstCart;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //if (Session["Customer"] != null)
                //{
                //    var sysUser = (UserCustomerModel)Session["Customer"];

                //    lblAccountInfo.Text = string.Format("Xin chào: {0}", string.Format("<a href='{0}'>"+sysUser.UserName.ToString()+"</a>",ResolveUrl("~/site/mbgn/editprofile.aspx")));
                //    pnInfoAccount.Visible = true;
                //    pnLinkLoginAndRegister.Visible = false;
                //}
                //else
                //{
                //    pnInfoAccount.Visible = false;
                //    pnLinkLoginAndRegister.Visible = true;
                //}

                if (Session["Cart"] != null)
                {
                    lstCart = (List<Ecms.Website.Site.MBGN.CartModel>)Session["Cart"];
                }
                this.LoadData();
            }
        }

        protected void lbtnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Session.Clear();
            Response.Redirect("~/site/home.aspx");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                var userName = txtUserName.Text;
                var password = txtPassword.Text;

                var sysUser = new CustomerService().Logon(userName, password, "0", this.Page);
                if (sysUser != null)
                {

                    #region // calfeeDelay
                    var fee = new OrderService().CalDelayFeeOrder(this.Page);
                    #endregion

                    Session["Customer"] = sysUser;
                    FormsAuthentication.SetAuthCookie(sysUser.UserCode, false);

                    if (Session["Quotation"] != null && !string.IsNullOrEmpty(Request.QueryString["qtacart"]) && Request.QueryString["qtacart"].Equals(CommonUtils.Constansts.FlagActive))
                    {
                        Response.Redirect("~/site/mbgn/confirmquotation.aspx");
                    }
                    else if (Session["Order"] != null && !string.IsNullOrEmpty(Request.QueryString["ordercart"]) && Request.QueryString["ordercart"].Equals(CommonUtils.Constansts.FlagActive))
                    {
                        // if orderCart before login then forword to below url
                        Response.Redirect("~/site/mbgn/addInfodelivery.aspx");
                    }
                    else
                    {
                        if (Request.QueryString["returnUrl"] != null)
                        {
                            Response.Redirect(Request.QueryString["returnUrl"]);
                        }
                        else
                        {
                            Response.Redirect("~/site/mbgn/orderproduct.aspx");
                        }
                    }

                    return;
                }

                //lblError.Text = "Tên đăng nhập hoặc mật khẩu không đúng";
                //lblError.Visible = true;
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this.Page);
            }
        }

        protected void btnSeach_OnClick(object sender, EventArgs e)
        {
            Response.Redirect(string.Format("~/san-pham/{0}/tim-kiem.htm", txtSearch.Text.Trim()));
        }

        /// <summary>
        /// Get text for present panel login
        /// </summary>
        /// <returns></returns>
        protected string GetLoginText()
        {
            return Session["Customer"] == null ? "Đăng nhập / Đăng ký" : string.Format("Welcome: {0}", ((Ecms.Biz.UserCustomerModel)Session["Customer"]).UserCode);
        }

        /// <summary>
        ///  Get url for display login text panel
        /// </summary>
        /// <returns></returns>
        protected string GetUrlLogin()
        {
            return Session["Customer"] == null ? "#" : ResolveUrl(string.Format("~/site/mbgn/editprofile.aspx"));
        }

        /// <summary>
        ///  Get url for display login text panel
        /// </summary>
        /// <returns></returns>
        protected bool CheckSigin()
        {
            return (Session["Customer"] == null);
        }


        private void LoadData()
        {
            //try
            //{
            //    var websites = new CommonService().WebsiteList("", "", "");
            //    var strParentWebsite = new StringBuilder();
            //    foreach (var item in websites.Where(x => x.ParentId == null).Take(9))
            //    {
            //        string strParentWebFormat = string.Format("<li><a href='{0}' title='{1}'>{2}</a></li>"
            //                                    //, type
            //                                    , ResolveUrl(string.Format("~/site/mbgn2/weblist.aspx?webId={0}", item.WebsiteId))
            //                                    , item.WebsiteName
            //                                    , item.WebsiteName);

            //        strParentWebsite.Append(strParentWebFormat);
            //    }

            //    // add last item
            //    strParentWebsite.Append(string.Format("<li class='last'><a href='{0}' title='{1}'>{2}</a></li>"
            //                                    , ResolveUrl(string.Format("~/site/mbgn2/weblist.aspx"))
            //                                    , ""
            //                                    , "Nhiều website hơn..."));

            //    litMenuLeft.Text = strParentWebsite.ToString();
            //}
            //catch (Exception ex)
            //{
            //    Utils.ShowExceptionBox(ex, this.Page);
            //}
        }

        protected void btnPaymentCheckOut_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/site/mbgn/cart.aspx");
        }
    }
}