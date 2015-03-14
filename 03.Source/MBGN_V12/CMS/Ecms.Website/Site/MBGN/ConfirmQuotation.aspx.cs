using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ecms.Biz.Entities;
using Ecms.Biz;
using Ecms.Website.DBServices;
using Ecms.Website.Common;
using CommonUtils;

namespace Ecms.Website.Site.MBGN
{
    public partial class ConfirmQuotation : System.Web.UI.Page
    {
        private readonly CustomerService _customerService = new CustomerService();
        private readonly OrderService _orderService = new OrderService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Customer"] == null)
                {
                    var returnUrl = Request.Url.AbsolutePath;
                    Response.Redirect("~/site/mbgn/loginRequirement.aspx?returnUrl=" + returnUrl);
                }                
            }
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["Quotation"] != null)
                {
                    var customer = (UserCustomerModel)Session["Customer"];
                    var order = (Order)Session["Quotation"];
                    order.CustomerId = customer.CustomerId;
					if (string.IsNullOrEmpty(txtRemark.Text))
					{
						order.Remark = txtRemark.Text;
					}
                    foreach (var item in order.OrderDetails)
                    {
                        //Lấy thông tin công
                        var configBusinessEffort = _customerService.ConfigBusinessGet("", customer.CustomerTypeId + "", "2", "", "101", item.WebsiteId + "", "", "", "", this).FirstOrDefault();
                        if (configBusinessEffort != null)
                        {
                            item.EffortConfigId = configBusinessEffort.ConfigBusinessId;
                        }

						if (item.Quantity == null)
						{
							item.Quantity = 1;
						}
						
							if (item.CountryId == null)
							{
								item.RateCountryId = null;
							}
							else
							{
								var configBusinessRate = _customerService.ConfigBusinessGet(
														""
														, ""
														, ""
														, Convert.ToString(item.CountryId)
														, Const_BusinessCode.Business_ORGRATE
														, ""
														, ""
														, ""
														, ""
														, this).OrderByDescending(p => p.CreatedDate).FirstOrDefault();

								if (configBusinessRate != null)
								{
									item.RateCountryId = configBusinessRate.ConfigBusinessId;
								}
								else
								{
									item.RateCountryId = null;
								}
							}						
                    }
                    var orderReturn = _orderService.OrderCreate(order, this);
					if (orderReturn != null)
					{
						Session.Remove("QtCartLink");
						Session.Remove("Quotation");
						mtvMain.ActiveViewIndex = 1;
					}
                }
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/site/mbgn/orderproduct.aspx");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
			Session.Remove("Quotation");
            Response.Redirect("~/site/mbgn/orderproduct.aspx");
        }
    }
}