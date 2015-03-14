using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ecms.Website.Common;
using Ecms.Website.DBServices;
using Ecms.Biz.Entities;
using System.Globalization;
using Ecms.Biz;
using CommonUtils;

namespace Ecms.Website.Site.MBGN
{
    public partial class Quotation : System.Web.UI.Page
    {
        #region //Declares

        private readonly CustomerService _customerService = new CustomerService();
        private readonly CommonService _commonService = new CommonService();


        #endregion

        #region //Events

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    InitData();
                }
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        protected void btnAccept_Click(object sender, EventArgs e)
        {
			try
			{

				var cartDetailLinks = (List<OrderDetailModel>)Session["QtCartLink"];

				// Build:
				var order = new Order
				{
					OrderTypeId = 1,
				};

				foreach (var item in cartDetailLinks)
				{
					var detail = new OrderDetail
					{
						ProductLink = item.ProductLink,
						CountryId = item.CountryId,
						Quantity=item.Quantity,
						Color=item.Color,
						Size=item.Size
					};

					order.OrderDetails.Add(detail);
				}
				#region // configBusiness for ConfigRateId in Order table
				var configBusinessRateOrder = _customerService.ConfigBusinessGet(
								""
								, ""
								, ""
								, ""
								, Const_BusinessCode.Business_ORGRATEDE
								, ""
								, ""
								, ""
								, ""
								, this).OrderByDescending(p => p.CreatedDate).FirstOrDefault();

				if (configBusinessRateOrder != null)
				{
					order.ConfigRateId = configBusinessRateOrder.ConfigBusinessId;
				}
				#endregion

				Session["Quotation"] = order;
				if (Session["Customer"] == null)
				{
					Response.Redirect("~/site/mbgn/login.aspx?qtacart=1");
				}
				else
				{
					Response.Redirect("~/site/mbgn/confirmquotation.aspx");
				}
			}
			catch (Exception ex)
			{
				Utils.ShowExceptionBox(ex, this);
			}
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
			Session.Remove("QtCartLink");
			Session.Remove("Quotation");
            Response.Redirect("~/site/mbgn/orderproduct.aspx");
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/site/mbgn/orderproduct.aspx");
        }

		protected void btnAddToCartLink_Click(object sender, EventArgs e)
		{
			try
			{
				// validate
				if (!IsValidData()) return;

				List<OrderDetailModel> cartLinks = new List<OrderDetailModel>();
				OrderDetailModel orderDetailTemp = new OrderDetailModel();

				orderDetailTemp.CountryId = Convert.ToInt32(ddlOrigin1.SelectedValue);
				orderDetailTemp.CountryName = ddlOrigin1.SelectedItem.Text;
				orderDetailTemp.ProductLink = txtLink1.Text;

				if (!string.IsNullOrEmpty(txtQuantity.Text))
				{
					orderDetailTemp.Quantity = Convert.ToInt32(txtQuantity.Text);
				}

				if (!string.IsNullOrEmpty(txtColor.Text))
				{
					orderDetailTemp.Color = txtColor.Text;
				}

				if (!string.IsNullOrEmpty(txtSize.Text))
				{
					orderDetailTemp.Size = txtSize.Text;
				}

				if (Session["QtCartLink"] != null)
				{
					cartLinks = (List<OrderDetailModel>)Session["QtCartLink"];
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
				Session["QtCartLink"] = cartLinks;
				txtLink1.Text = ddlOrigin1.SelectedValue = "";
				txtQuantity.Text = "";
				txtSize.Text = "";
				txtColor.Text = "";

				LoadData();
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
						if (Session["QtCartLink"] != null)
						{
							var cartLinks = (List<OrderDetailModel>)Session["QtCartLink"];
							if (cartLinks.Count != 0)
							{
								var orderDetail = cartLinks.Where(x => x.OrderDetailId == orderDetailId).FirstOrDefault();

								if (orderDetail != null)
								{
									cartLinks.Remove(orderDetail);
									Session["QtCartLink"] = cartLinks;
									//Response.Redirect("");
									LoadData();
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
        #endregion

        #region //Private Methods

        private void InitData()
        {
            var parentWebsite = _commonService.WebsiteList("", "", "").Where(x => x.ParentId == null);
            var orginal = _commonService.CountryGet("", "", "", this);
            ddlOrigin1.DataSource = orginal;
            ddlOrigin1.DataTextField = "CountryName";
            ddlOrigin1.DataValueField = "CountryId";
            ddlOrigin1.DataBind();
            ddlOrigin1.Items.Insert(0, new ListItem("-- Chọn xuất xứ Web--", ""));           
        }

        private bool IsValidData()
        {
            lblError.Text = string.Empty;
            lblError.Visible = false;

            if (string.IsNullOrEmpty(ddlOrigin1.SelectedValue))
            {
                lblError.Text = "Quý khách chưa chọn xuất xứ website";
                lblError.Visible = true;
                return false;
            }

			if (string.IsNullOrEmpty(txtLink1.Text))
			{
				lblError.Text = "Quý khách chưa nhập link sản phẩm";
				lblError.Visible = true;
				return false;
			}

			var qty = 0;
			if(!string.IsNullOrEmpty(txtQuantity.Text) && !Int32.TryParse(txtQuantity.Text, out qty))
			{
				lblError.Text = "Số lượng không chính xác";
				lblError.Visible = true;
				return false;
			}

            return true;
        }

		private void LoadData()
		{
			if (Session["QtCartLink"] != null)
			{
				var cartLinks = (List<OrderDetailModel>)Session["QtCartLink"];
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