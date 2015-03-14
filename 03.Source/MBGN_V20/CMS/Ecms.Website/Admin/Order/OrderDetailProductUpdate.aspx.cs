using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ecms.Website.DBServices;
using Ecms.Website.Common;
using Ecms.Biz.Entities;

namespace Ecms.Website.Admin.Order
{
    public partial class OrderDetailProductUpdate : PageBase
    {
        #region //Declares

        private readonly OrderService _orderService = new OrderService();
        private readonly CustomerService _customerService = new CustomerService();
        private readonly ProductService _productService = new ProductService();

        #endregion

        #region //Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitData();
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
			if (Request.QueryString["Odsu"] != null)
			{
				Response.Redirect("~/admin/order/OrderDetailStatusUpdate.aspx");
			}
			else
			{
				Response.Redirect("~/admin/order/orderdeliverydetail.aspx?orderId=" + Request.QueryString["orderId"].ToString());
			}
        }

        protected void btnAccept_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(ddlCategory.SelectedValue))
                {
                    lblError.Text = "Bạn chưa chọn chủng loại sản phẩm!";
                    lblError.Visible = true;
                    return;
                }
                if (Session["dictChangeStatus"] != null)
                {
                    var dictChangeStatus = (Dictionary<string, string>)Session["dictChangeStatus"];
                    string orderId = dictChangeStatus["orderId"];
                    var orderDetailId = Convert.ToInt32(dictChangeStatus["orderDetailId"]);

					var order = _orderService.OrderGet(Request.QueryString["orderId"].ToString(), "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", this).FirstOrDefault();

					if (order != null && order.OrderStatus == CommonUtils.OrderInStatus.Deliveried)
					{
						lblError.Text = "Đã hàng đã được xác nhận GIAO HÀNG không thể cập nhật thông tin!";
						lblError.Visible = true;
						return;
					}

                    if (order != null)
                    {
                        var orderDetail = new OrderDetail();
                        orderDetail.OrderDetailId = Convert.ToInt32(orderDetailId);
                        orderDetail.CategoryId = Convert.ToInt32(ddlCategory.SelectedValue);

                        if (!string.IsNullOrEmpty(txtQuantity.Text))
                        {
                            orderDetail.Quantity = Convert.ToDouble(txtQuantity.Text.Replace(",", ""));
                        }

                        if (!string.IsNullOrEmpty(txtWeight.Text))
                        {
                            orderDetail.Weight = Convert.ToDouble(txtWeight.Text.Replace(",", ""));
                        }

                        if (!string.IsNullOrEmpty(txtSurcharge.Text))
                        {
                            orderDetail.Surcharge = Convert.ToDouble(txtSurcharge.Text.Replace(",", ""));
                        }

                        if (!string.IsNullOrEmpty(txtDeclarePrice.Text))
                        {
                            orderDetail.DeclarePrice = Convert.ToDouble(txtDeclarePrice.Text.Replace(",", ""));
                        }

                        if (!string.IsNullOrEmpty(txtShipModified.Text))
                        {
                            orderDetail.ShipModified = Convert.ToDouble(txtShipModified.Text.Replace(",", ""));
                        }
                        else
                        {
                            orderDetail.ShipModified = null;
                        }

                        orderDetail.ProductName = txtProductName.Text;

                        if (order.CustomerTypeId != null)
                        {
                            var configBusiness = _customerService.ConfigBusinessGet("", order.CustomerTypeId + "", "3", "", "FEE", "", orderDetail.CategoryId + "", "", "", this).FirstOrDefault();
                            if (configBusiness != null)
                            {
                                orderDetail.ShipConfigId = configBusiness.ConfigBusinessId;
                            }
                        }

						if (chkInsuarance.Checked)
						{
							var configBusiness = _customerService.ConfigBusinessGet("", "", "", "", "INSUARANCE", "", "", "", "", this).OrderByDescending(x => x.CreatedDate).FirstOrDefault();

							if (configBusiness != null)
							{
								orderDetail.InsuaranceConfigId = configBusiness.ConfigBusinessId;
								//orderDetail.LotPrice = txtLotPrice.Text.Trim();
							}
							else
							{
								orderDetail.InsuaranceConfigId = null;
								orderDetail.LotPrice = string.Empty;
							}
						}
						else
						{
							orderDetail.InsuaranceConfigId = null;
							orderDetail.LotPrice = string.Empty;
						}

                        var orderDetailReturn = _orderService.OrderDetailDeliveryUpdate(orderDetail, this);
                        if (orderDetailReturn != null)
                        {
                            mtvMain.ActiveViewIndex = 1;
                        }
                    }
                }
                else
                {
                    Response.Redirect("~/admin/order/orderdeliverydetail.aspx?orderId=" + Request.QueryString["orderId"].ToString());
                }

            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            btnBack_Click(sender, e);
        }

		protected void chkInsuarance_OnCheckedChanged(object sender, EventArgs e)
		{
			if (chkInsuarance.Checked)
			{
				//trLotPrice.Visible = true;
			}
			else if (!chkInsuarance.Checked)
			{
				//trLotPrice.Visible = false;
			}
		}

        #endregion

        #region //Private methods

        private void InitData()
        {
            try
            {
                if (Session["User"] == null)
                    Response.Redirect("~/admin/security/login.aspx");

                ddlCategory.DataSource = _productService.CategoryGet("", "", "", this).Where(x => x.ParentId != null);
                ddlCategory.DataTextField = "CategoryName";
                ddlCategory.DataValueField = "CategoryId";
                ddlCategory.DataBind();
                ddlCategory.Items.Insert(0, new ListItem("-- Nhóm sản phẩm --", ""));

                if (Session["dictChangeStatus"] != null)
                {
                    var dictChangeStatus = (Dictionary<string, string>)Session["dictChangeStatus"];
                    string orderId = dictChangeStatus["orderId"];
                    var orderDetailId = Convert.ToInt32(dictChangeStatus["orderDetailId"]);
					var orderReturn = _orderService.OrderGet(orderId, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", this).FirstOrDefault();
                    var orderDetailDelivery = orderReturn.lstOrderDetailModel.ToList().Where(x => x.OrderDetailId == orderDetailId).ToList().FirstOrDefault();

                    if (orderDetailDelivery != null)
                    {
                        ddlCategory.SelectedValue = orderDetailDelivery.CategoryId + "";
                        txtProductName.Text = orderDetailDelivery.ProductName;
                        txtQuantity.Text = (orderDetailDelivery.Quantity ?? 0).ToString("N2");
                        txtWeight.Text = (orderDetailDelivery.Weight ?? 0).ToString("N2");
                        txtSurcharge.Text = (orderDetailDelivery.Surcharge ?? 0).ToString("N2");
                        txtDeclarePrice.Text = orderDetailDelivery.DeclarePrice != null ? (orderDetailDelivery.DeclarePrice ?? 0).ToString("N2") : "";
                        txtShipModified.Text = orderDetailDelivery.ShipModified != null ? (orderDetailDelivery.ShipModified ?? 0).ToString("N2") : "";

						if (orderDetailDelivery.InsuaranceConfigId != null)
						{
							chkInsuarance.Checked = true;
							// txtLotPrice.Text = orderDetailDelivery.LotPrice;
							// trLotPrice.Visible = true;
						}
						else
						{
							chkInsuarance.Checked = false;
							// txtLotPrice.Text = "";
							// trLotPrice.Visible = false;
						}
                    }
                }
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        #endregion
    }
}