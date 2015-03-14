using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ecms.Website.DBServices;
using Ecms.Biz.Entities;
using Ecms.Biz;
using System.Globalization;
using Ecms.Website.Common;

namespace Ecms.Website.Site.MBGN
{
    public partial class OrderByLink : System.Web.UI.Page
    {
        #region //Declares

        private readonly CommonService _commonService = new CommonService();
        private readonly CustomerService _customerService = new CustomerService();

        #endregion

        #region //Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitData();
                LoadData();
            }
        }

        protected void btnAddToCartLink_Click(object sender, EventArgs e)
        {
            try
            {
                List<OrderDetailModel> cartLinks = new List<OrderDetailModel>();
                OrderDetailModel orderDetailTemp = new OrderDetailModel();

                //if (!string.IsNullOrEmpty(ddlWebsite.SelectedValue))
                //{
                //    orderDetailTemp.WebsiteId = Convert.ToInt32(ddlWebsite.SelectedValue);
                //    orderDetailTemp.WebsiteName = ddlWebsite.SelectedItem.Text;
                //}
                orderDetailTemp.CountryId = Convert.ToInt32(ddlOrigin.SelectedValue);
                orderDetailTemp.CountryName = ddlOrigin.SelectedItem.Text;
                orderDetailTemp.ProductLink = txtLinkProduct.Text;
                orderDetailTemp.ImageUrl = txtLinkProductImage.Text;

                orderDetailTemp.PriceWeb = Convert.ToDouble(txtPriceWeb.Text.Replace(",", ""));

                if (!string.IsNullOrEmpty(txtPriceWebOff.Text))
                {
                    orderDetailTemp.PriceWebOff = Convert.ToDouble(txtPriceWebOff.Text.Replace(",", ""));
                }

                orderDetailTemp.Quantity = Convert.ToDouble(txtQuantity.Text.Replace(",", ""));
                orderDetailTemp.Color = txtColor.Text;
                orderDetailTemp.Size = txtSize.Text;
                if (Session["CartLink"] != null)
                {
                    cartLinks = (List<OrderDetailModel>)Session["CartLink"];
                    if (cartLinks.Count != 0)
                    {
                        var orderDetailId = cartLinks.OrderByDescending(x => x.OrderDetailId).FirstOrDefault().OrderDetailId + 1;
                        orderDetailTemp.OrderDetailId = orderDetailId;
                    }
                }
                else
                {
                    orderDetailTemp.OrderDetailId = 1;
                }

                cartLinks.Add(orderDetailTemp);
                Session["CartLink"] = cartLinks;
                txtColor.Text = txtLinkProduct.Text = txtLinkProductImage.Text = txtPriceWeb.Text = txtPriceWebOff.Text 
                = txtQuantity.Text = txtSize.Text = ddlOrigin.SelectedValue = "";
                LoadData();
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
			Session.Remove("Order");
			Session.Remove("CartLink");
            Response.Redirect("~/site/ordermanager.aspx");
        }

        protected void btnOrder_Click(object sender, EventArgs e)
        {
            try
            {               
                if (Session["CartLink"] != null)
                {

                    var cartLinks = (List<OrderDetailModel>)Session["CartLink"];
                    var customer = (UserCustomerModel)Session["Customer"];

                    Order order = new Order();
                    order.OrderDate = order.CreatedDate = DateTime.Now;
                    order.OrderTypeId = 2;                    

                    foreach (var item in cartLinks)
                    {
                        var orderDetailTemp = new OrderDetail();
                        orderDetailTemp.WebsiteId = item.WebsiteId;
                        orderDetailTemp.ProductLink = item.ProductLink;
                        orderDetailTemp.ImageUrl = item.ImageUrl;
                        orderDetailTemp.CountryId = item.CountryId;
                        orderDetailTemp.PriceWeb = item.PriceWeb;
                        if ((item.PriceWebOff ?? 0) != 0)
                        {
                            orderDetailTemp.PriceWebOff = item.PriceWebOff;
                        }                                   
                        orderDetailTemp.Quantity = item.Quantity;
                        orderDetailTemp.Color = item.Color;
                        orderDetailTemp.Size = item.Size;
                        order.OrderDetails.Add(orderDetailTemp);
                    }

                    Session["Order"] = order;
                    Response.Redirect("~/site/mbgn/addInfodelivery.aspx");
                }
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        protected void gridCartByLink_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                switch (e.CommandName)
                {
                    case "deleteProduct":
                        int orderDetailId = Convert.ToInt32(e.CommandArgument);
                        if (Session["CartLink"] != null)
                        {
                            var cartLinks = (List<OrderDetailModel>)Session["CartLink"];
                            if (cartLinks.Count != 0)
                            {
                                var orderDetail = cartLinks.Where(x => x.OrderDetailId == orderDetailId).FirstOrDefault();

                                if (orderDetail != null)
                                {
                                    cartLinks.Remove(orderDetail);
                                    Session["CartLink"] = cartLinks;
                                    Response.Redirect("");
                                }
                            }
                        }
                        break;
                }
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        protected void ddlOrigin_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(ddlOrigin.SelectedValue))
            {
                var country = _commonService.CountryGet(ddlOrigin.SelectedValue, "", "", this).FirstOrDefault();
                lblCurencyPriceWeb.Text = lblCurencyPriceWebOff.Text = "(" + country.CurrencyCode + ")";
                lblCurencyPriceWeb.Visible = lblCurencyPriceWebOff.Visible = true;
            }
            else
            {
                lblCurencyPriceWeb.Visible = lblCurencyPriceWebOff.Visible = false;
            }
        }

        #endregion

        #region //Private methods

        private void InitData()
        {
            try
            {
                ddlOrigin.DataSource = _commonService.CountryGet("", "", "", this);
                ddlOrigin.DataTextField = "CountryName";
                ddlOrigin.DataValueField = "CountryId";
                ddlOrigin.DataBind();
                ddlOrigin.Items.Insert(0, new ListItem("-- Chọn xuất xứ --", ""));

                if (Request.QueryString["WebsiteId"] != null)
                {
                    var website = _commonService.WebsiteList(Request.QueryString["WebsiteId"].ToString(), "", "").FirstOrDefault();
                    if (website != null)
                    {
                        //ddlWebsiteGroup.SelectedValue = website.ParentId + "";
                        //var websiteBind = _commonService.WebsiteList("", "", "").Where(x=>x.ParentId == website.ParentId);
                        //ddlWebsite.DataSource = websiteBind;
                        //ddlWebsite.DataTextField = "WebsiteName";
                        //ddlWebsite.DataValueField = "WebsiteId";
                        //ddlWebsite.DataBind();
                        //ddlWebsite.SelectedValue = Request.QueryString["WebsiteId"];
                    }                    
                }
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        private void LoadData()
        {
            if (Session["CartLink"] != null)
            {
                var cartLinks = (List<OrderDetailModel>)Session["CartLink"];
                if (cartLinks.Count != 0)
                {
                    gridCartByLink.DataSource = cartLinks;
                    gridCartByLink.DataBind();
                    pnCartLink.Visible = true;
                }
                else
                {
                    pnCartLink.Visible = false;
                }
            }
        }

        #endregion
    }
}