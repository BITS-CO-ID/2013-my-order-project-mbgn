using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CommonUtils;
using Ecms.Biz;
using Ecms.Website.DBServices;
using Ecms.Website.Common;
using Ecms.Biz.Entities;

namespace Ecms.Website.Admin.Order
{
    public partial class QuotationDetailUpdate : PageBase
    {
        #region //Declares

        private readonly ProductService _productService = new ProductService();
        private readonly OrderService _orderService = new OrderService();
        private readonly CustomerService _customerService = new CustomerService();
        private readonly CommonService _commonService = new CommonService();

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

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
			try
			{
				if (ValidData(ddlWebsite.SelectedValue) == false)
					return;

				var categoryId = ddlCategory.SelectedValue;
				var weight = txtWeight.Text;
				if (Request.QueryString["orderId"] == null)
				{
					Response.Redirect("~/admin/security/login.aspx");
				}
				var orderDetail = new OrderDetail();
				orderDetail.OrderDetailId = Convert.ToInt32(hdOrrderDetailId.Value);
				var order = _orderService.OrderGet(Request.QueryString["orderId"].ToString(), "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", this).FirstOrDefault();
				var currentOrderDetail = order.lstOrderDetailModel.ToList().Where(p => p.OrderDetailId == orderDetail.OrderDetailId).SingleOrDefault();
				if (order == null)
				{
					lblError.Text = "Đơn hàng không tồn tại!";
					lblError.Visible = true;
					return;
				}

				if (order.OrderStatus == 2)
				{
					lblError.Text = "Báo giá đã trả lời không được phép cập nhật!";
					lblError.Visible = true;
					return;
				}

				if (!string.IsNullOrEmpty(categoryId))
				{
					//Lấy phí
					var configBusiness = _customerService.ConfigBusinessGet("", order.CustomerTypeId + "", "", "", "FEEMH", "",
																			Convert.ToInt32(categoryId) + "", "", "",
																			this).FirstOrDefault();
					if (configBusiness != null)
					{
						orderDetail.ShipConfigId = configBusiness.ConfigBusinessId;
					}
					orderDetail.CategoryId = Convert.ToInt32(categoryId);
				}

				if (string.IsNullOrEmpty(txtEffort.Text))
				{
					var configBusiness = _customerService.ConfigBusinessGet("", order.CustomerTypeId + "", "2", "", "101",
																			ddlWebsite.SelectedValue, "", "", "", this).FirstOrDefault();
					if (configBusiness != null)
					{
						orderDetail.EffortConfigId = configBusiness.ConfigBusinessId;
					}
				}

				orderDetail.WebsiteId = Convert.ToInt32(ddlWebsite.SelectedValue);
				orderDetail.CountryId = Convert.ToInt32(ddlOrigin.SelectedValue);
				orderDetail.RateCountryId = currentOrderDetail.RateCountryId;

				if (!string.IsNullOrEmpty(weight))
				{
					orderDetail.Weight = Convert.ToDouble(weight.Replace(",", ""));
				}

				if (!string.IsNullOrEmpty(txtQuantity.Text))
				{
					orderDetail.Quantity = Convert.ToDouble(txtQuantity.Text.Replace(",", ""));
				}
				else
				{
					orderDetail.Quantity = 1;
				}

				if (!string.IsNullOrEmpty(txtPriceWeb.Text))
				{
					orderDetail.PriceWeb = Convert.ToDouble(txtPriceWeb.Text.Replace(",", ""));
				}

				if (!string.IsNullOrEmpty(txtPriceWebOff.Text))
				{
					orderDetail.PriceWebOff = Convert.ToDouble(txtPriceWebOff.Text.Replace(",", ""));
				}

				if (!string.IsNullOrEmpty(txtColor.Text))
				{
					orderDetail.Color = txtColor.Text;
				}

				if (chkTaxUsa.Checked)
				{
					var configBusinessTax = _customerService.ConfigBusinessGet("", "", "", "", "TAXUSA", "", "", "", "", this).FirstOrDefault();
					if (configBusinessTax != null)
					{
						orderDetail.TaxUsaConfigId = configBusinessTax.ConfigBusinessId;
					}
				}

				if (!string.IsNullOrEmpty(txtSurcharge.Text))
				{
					orderDetail.Surcharge = Convert.ToDouble(txtSurcharge.Text.Replace(",", ""));
				}

				if (!string.IsNullOrEmpty(txtShipUsa.Text))
				{
					orderDetail.ShipUSA = Convert.ToDouble(txtShipUsa.Text.Replace(",", ""));
				}

				if (!string.IsNullOrEmpty(txtEffort.Text))
				{
					orderDetail.EffortModified = Convert.ToDouble(txtEffort.Text.Replace(",", ""));
				}
				else
				{
					orderDetail.EffortModified = null;
				}

				if (!string.IsNullOrEmpty(txtShipModified.Text))
				{
					orderDetail.ShipModified = Convert.ToDouble(txtShipModified.Text.Replace(",", ""));
				}
				else
				{
					orderDetail.ShipModified = null;
				}

				orderDetail.Size = txtSize.Text;
				orderDetail.ImageUrl = txtImage.Text;

				#region //Get ship fee for orign change
				if (orderDetail.CountryId != currentOrderDetail.CountryId)
				{
					if (orderDetail.CountryId == null)
					{
						orderDetail.RateCountryId = null;
					}
					else
					{
						var configBusinessRate = _customerService.ConfigBusinessGet(
												""
												, ""
												, ""
												, Convert.ToString(orderDetail.CountryId)
												, Const_BusinessCode.Business_ORGRATE
												, ""
												, ""
												, ""
												, ""
												, this).OrderByDescending(p => p.CreatedDate).FirstOrDefault();

						if (configBusinessRate != null)
						{
							orderDetail.RateCountryId = configBusinessRate.ConfigBusinessId;
						}
						else
						{
							orderDetail.RateCountryId = null;
						}
					}
				}
				#endregion

				var orderDetailreturn = _orderService.OrderDetailUpdate(orderDetail, this);
				if (orderDetailreturn != null)
				{
					mtvMain.ActiveViewIndex = 1;
					Session["orderId"] = orderDetailreturn.OrderId + "";
				}
			}
			catch (Exception ex)
			{
				Utils.ShowExceptionBox(ex, this);
			}
        }

        protected void ddlWebsiteGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlWebsiteGroup.SelectedValue.Equals(""))
            {
                ddlWebsite.Items.Clear();
                ddlWebsite.Items.Insert(0, new ListItem("-- Chọn website --", ""));
            }
            else
            {
                int websiteParentId = Convert.ToInt32(ddlWebsiteGroup.SelectedValue);
                var websiteList = _commonService.WebsiteList("", "", "").Where(x => x.ParentId == websiteParentId);
                ddlWebsite.DataSource = websiteList;
                ddlWebsite.DataTextField = "WebsiteName";
                ddlWebsite.DataValueField = "WebsiteId";
                ddlWebsite.DataBind();
                ddlWebsite.Items.Insert(0, new ListItem("-- Chọn website --", ""));
            }
        }

        protected void ddlOrigin_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(ddlOrigin.SelectedValue))
            {
                var country = _commonService.CountryGet(ddlOrigin.SelectedValue, "", "", this).FirstOrDefault();
                lblCurencyCode.Text = country.CurrencyCode;
                lblCurencyCode.Visible = true;
            }
            else
            {
                lblCurencyCode.Visible = false;
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/admin/order/quotationreply.aspx?orderId=" + Request.QueryString["orderId"].ToString());
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/admin/order/quotationreply.aspx?orderId=" + Request.QueryString["orderId"].ToString());
        }

        #endregion

        #region //Private methods

        private void InitData()
        {
            if (Session["User"] == null)
                Response.Redirect("~/admin/security/login.aspx");

            ddlCategory.DataSource = this._productService.CategoryGet("", "", "-1", this);
            ddlCategory.DataTextField = "CategoryName";
            ddlCategory.DataValueField = "CategoryId";
            ddlCategory.DataBind();
            ddlCategory.Items.Insert(0, new ListItem("-- Chọn chủng loại sản phẩm --", ""));

            ddlWebsiteGroup.DataSource = _commonService.WebsiteList("", "", "").Where(x => x.ParentId == null);
            ddlWebsiteGroup.DataTextField = "WebsiteName";
            ddlWebsiteGroup.DataValueField = "WebsiteId";
            ddlWebsiteGroup.DataBind();

            ddlWebsiteGroup.Items.Insert(0, new ListItem("-- Chọn nhóm website --", ""));
            ddlWebsite.Items.Insert(0, new ListItem("-- Chọn website --", ""));

            ddlOrigin.DataSource = _commonService.CountryGet("", "", "", this);
            ddlOrigin.DataTextField = "CountryName";
            ddlOrigin.DataValueField = "CountryId";
            ddlOrigin.DataBind();
        }

        private void LoadData()
        {
            if (Session[Constansts.SS_ORDER_DETAIL_ADMIN] != null)
            {
                var orderDetailModel = (OrderDetailModel)Session[Constansts.SS_ORDER_DETAIL_ADMIN];
                hdOrrderDetailId.Value = orderDetailModel.OrderDetailId + "";
                ddlOrigin.SelectedValue = orderDetailModel.CountryId+"";
                txtPriceWeb.Text = orderDetailModel.PriceWeb != null ? (Convert.ToDouble(orderDetailModel.PriceWeb) + "") : "";
                txtQuantity.Text = (orderDetailModel.Quantity ?? 0).ToString("N2");
                txtEffort.Text = orderDetailModel.EffortModified == null ? (orderDetailModel.EffortConfigValue ?? 0).ToString("N2") :
                                                                   (orderDetailModel.EffortModified ?? 0).ToString("N2");
                lblCurencyCode.Text = orderDetailModel.CurrencyCode;
                lblStatusText.Text = orderDetailModel.DetailStatusText;
                lblProductLink.Text = string.Format("<a href='{0}' title='{1}' target='_blank'>{2}</a>",
                                                    orderDetailModel.ProductLink, orderDetailModel.ProductLink,
                                                    orderDetailModel.ProductLink.Length < 100 ? orderDetailModel.ProductLink : orderDetailModel.ProductLink.Substring(0, 100));
                lblProductImage.Text = string.Format("<a href='{0}' target='_blank'><img src='{1}' width='50' height='50' /></a>",
                                                        orderDetailModel.ImageUrl, orderDetailModel.ImageUrl);
                txtSize.Text = orderDetailModel.Size;
                txtShipUsa.Text = orderDetailModel.ShipUSA != null ? (Convert.ToDouble(orderDetailModel.ShipUSA) + "") : "";
                txtImage.Text = orderDetailModel.ImageUrl;
                txtColor.Text = orderDetailModel.Color;
                txtPriceWebOff.Text = orderDetailModel.PriceWebOff != null ? (Convert.ToDouble(orderDetailModel.PriceWebOff) + "") : "";
                txtWeight.Text = orderDetailModel.Weight != null ? (Convert.ToDouble(orderDetailModel.Weight) + "") : "";
                chkTaxUsa.Checked = orderDetailModel.TaxUsaConfigId != null ? true : false;
                txtSurcharge.Text = orderDetailModel.Surcharge != null ? (Convert.ToDouble(orderDetailModel.Surcharge) + "") : "";
                ddlCategory.SelectedValue = orderDetailModel.CategoryId != null ? (orderDetailModel.CategoryId + "") : "";
                txtShipModified.Text = orderDetailModel.ShipModified != null ? orderDetailModel.ShipModified.Value.ToString("N2") : "";

                var website = _commonService.WebsiteList(orderDetailModel.WebsiteId + "", "", "").FirstOrDefault();
                if (website != null)
                {
                    ddlWebsiteGroup.SelectedValue = website.ParentId + "";
                    var websiteBind = _commonService.WebsiteList("", "", "").Where(x => x.ParentId == website.ParentId);
                    ddlWebsite.DataSource = websiteBind;
                    ddlWebsite.DataTextField = "WebsiteName";
                    ddlWebsite.DataValueField = "WebsiteId";
                    ddlWebsite.DataBind();
                    ddlWebsite.SelectedValue = orderDetailModel.WebsiteId + "";
                }
            }
        }

        private bool ValidData(string websiteId)
        {
            if (string.IsNullOrEmpty(websiteId))
            {
                lblError.Text = "Bạn chưa chọn Website!";
                lblError.Visible = true;
                return false;
            }
            return true;
        }

        #endregion
    }
}