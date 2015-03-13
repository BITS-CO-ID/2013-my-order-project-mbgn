using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ecms.Website.DBServices;
using Ecms.Biz;
using System.Globalization;
using Ecms.Website.Common;
using CommonUtils;

namespace Ecms.Website.Admin.Order
{
    public partial class OrderManage : PageBase
    {
        #region //Declares

        private readonly OrderService _orderService = new OrderService();

        #endregion

        #region //Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitData();
                LoadData(1,1);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadData(1,0);
        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/admin/order/orderdeliverycreate.aspx");
        }

		protected void btnOrderByLink_Click(object sender, EventArgs e)
		{
			Response.Redirect("~/admin/order/orderbylink.aspx");
		}

        protected void gridMain_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gridMain.PageIndex = e.NewPageIndex;
            LoadData(2, 1);
        }

        protected void gridMain_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (Session[Constansts.SS_ORDERMODEL_LIST_ADMIN] == null)
            {
                Response.Redirect("~/admin/order/ordermanage.aspx");
            }

            var param = e.CommandArgument.ToString().Split('|');
            int id = Convert.ToInt32(param[0]);

            switch (e.CommandName)
            {
                case "OrderEditTrackingNumber":
                    Response.Redirect("~/admin/order/orderupdate.aspx?orderId=" + id);
                    break;
                case "OrderDetail":
                    if (param[1].Equals("1")) // Báo giá
                    {
                        Response.Redirect("~/admin/order/quotationreply.aspx?orderId=" + id);
                    }

                    if (param[1].Equals("2")) // order link
                    {
                        Response.Redirect("~/admin/order/orderbylinkdetail.aspx?orderId=" + id);
                    }

                    if (param[1].Equals("3")) // order hàng gửi
                    {
                        Response.Redirect("~/admin/order/orderdeliverydetail.aspx?orderId=" + id);
                    }

                    if (param[1].Equals("4")) // order sản phẩm có sẵn
                    {
                        Response.Redirect("~/admin/order/orderbydetail.aspx?orderId=" + id);
                    }
                    break;
            }
        }

		protected void lbtEmployee_Click(object sender, CommandEventArgs e)
		{
			switch (e.CommandName)
			{
				case "Employee":
					try
					{
						string id = e.CommandArgument.ToString();
						Session[Constansts.SESSION_ORDERID] = id;
						Response.Redirect("OrderUpdateEmployee.aspx");
					}
					catch (Exception exc)
					{
						Utils.ShowExceptionBox(exc, this);
					}
					break;
			}
		}

		protected void lbtnPaymentForward_Click(object sender, CommandEventArgs e)
		{
			switch (e.CommandName)
			{
				case "PaymentForward":
					try
					{
						Response.Redirect(string.Format("~/admin/order/PaymentForward.aspx?orderId={0}", e.CommandArgument));
					}
					catch (Exception exc)
					{
						Utils.ShowExceptionBox(exc, this);
					}
					break;
			}
		}

		protected void lbtFeeDelay_Click(object sender, CommandEventArgs e)
		{
			switch (e.CommandName)
			{
				case "FeeDelay":
					try
					{
						var param = e.CommandArgument.ToString().Split('|');
						Response.Redirect(string.Format("~/admin/order/OrderUpdateConfigFee.aspx?orderId={0}&calFeeDelay={1}&dayAllowedDelay={2}&feeDelay={3}&amountFeeDelay={4}&status={5}&isCalFeeDelay={6}", param[0], param[1], param[2], param[3], param[4], param[5], param[6]));
					}
					catch (Exception exc)
					{
						Utils.ShowExceptionBox(exc, this);
					}
					break;
			}
		}

		protected void gridMain_RowDataBound(object sender, GridViewRowEventArgs e)
		{
			if (e.Row.RowType == DataControlRowType.DataRow)
			{
				var hdn = (HiddenField)e.Row.FindControl("hdnOrderTypeId");
				var orderTypeId = hdn == null ? 0 : Convert.ToInt32(hdn.Value);
				if (orderTypeId == OrderType_Const.Quote)
				{
					e.Row.Cells[1].ToolTip = OrderType_Const.Quote_Text;
				}

				if (orderTypeId == OrderType_Const.OrderShipOnly)
				{
					e.Row.Cells[1].ToolTip = OrderType_Const.OrderShipOnly_Text;
				}

				if (orderTypeId == OrderType_Const.OrderBylink)
				{
					e.Row.Cells[1].ToolTip = OrderType_Const.OrderBylink_Text;
				}

				if (orderTypeId == OrderType_Const.OrderByProduct)
				{
					e.Row.Cells[1].ToolTip = OrderType_Const.OrderByProduct_Text;
				}

				var hdnUserCode = (HiddenField)e.Row.FindControl("hdnUserCode");
				e.Row.Cells[4].ToolTip = hdnUserCode==null?"":hdnUserCode.Value;
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

                var currentDate = DateTime.Now;
                //Lấy ngày đầu tháng
                DateTime fDate = new DateTime(currentDate.Year, currentDate.Month, 1, 0, 0, 0);
                txtFromDate.Text = fDate.ToString("dd/MM/yyyy");
                txtToDate.Text = currentDate.ToString("dd/MM/yyyy");
                //Set data vào calendar conntrol
                cldFromDate.SelectedDate = fDate;
                cldToDate.SelectedDate = currentDate;
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        private void LoadData(int type, int btnClick)
        {
            try
            {
                if (type == 1)
                {
                    DateTime fDate = new DateTime();
                    DateTime tDate = new DateTime();
                    if (ValidData(ref fDate, ref tDate) == false)
                        return;
                    var searchParamDict = new Dictionary<string, string>();
                    if (Request.QueryString["returnBack"] != null)
                    {
                        if (btnClick == 0)
                        {
                            searchParamDict["orderCode"] = txtOrderCode.Text;
                            searchParamDict["trackingNumber"] = txtTrackingNumber.Text;
                            searchParamDict["fDate"] = fDate.ToString("yyyy-MM-dd 00:00:00");
                            searchParamDict["tDate"] = tDate.ToString("yyyy-MM-dd 23:59:59");
                            searchParamDict["customerCode"] = txtCustomerCode.Text;
                            //searchParamDict["userCode"] = txtUserCode.Text;
                            searchParamDict["customerDeliveryNo"] = txtCustomerNoDelivery.Text;
                            searchParamDict["orderNumber"] = txtOrderNumber.Text;
                            searchParamDict["orderStatus"] = ddlOrderStatus.SelectedValue;
                            searchParamDict["orderType"] = ddlOrderType.SelectedValue;
                            Session["searchParamDict"] = searchParamDict;
                        }
                        else
                        {
                            if (Session["searchParamDict"] != null)
                            {
                                searchParamDict = (Dictionary<string, string>)Session["searchParamDict"];
                                txtOrderCode.Text = searchParamDict["orderCode"];
                                //txtTrackingNumber.Text = searchParamDict["trackingNumber"];
                                txtFromDate.Text = Convert.ToDateTime(searchParamDict["fDate"]).ToString("dd/MM/yyyy");
                                cldFromDate.SelectedDate = Convert.ToDateTime(searchParamDict["fDate"]);
                                txtToDate.Text = Convert.ToDateTime(searchParamDict["tDate"]).ToString("dd/MM/yyyy");
                                cldToDate.SelectedDate = Convert.ToDateTime(searchParamDict["tDate"]);
                                txtCustomerCode.Text = searchParamDict["customerCode"];
                                //txtUserCode.Text = searchParamDict["userCode"];
                                txtCustomerNoDelivery.Text = searchParamDict["customerDeliveryNo"];
                                txtOrderNumber.Text = searchParamDict["orderNumber"];
                                ddlOrderStatus.SelectedValue = searchParamDict["orderStatus"];
                                ddlOrderType.SelectedValue = searchParamDict["orderType"];
                            }
                        }
                    }
                    else
                    {
                        searchParamDict["orderCode"] = txtOrderCode.Text;
                        searchParamDict["trackingNumber"] = txtTrackingNumber.Text;
                        searchParamDict["fDate"] = fDate.ToString("yyyy-MM-dd 00:00:00");
                        searchParamDict["tDate"] = tDate.ToString("yyyy-MM-dd 23:59:59");
                        searchParamDict["customerCode"] = txtCustomerCode.Text;
                        //searchParamDict["userCode"] = txtUserCode.Text;
                        searchParamDict["customerDeliveryNo"] = txtCustomerNoDelivery.Text;
                        searchParamDict["orderNumber"] = txtOrderNumber.Text;
                        searchParamDict["orderStatus"] = ddlOrderStatus.SelectedValue;
                        searchParamDict["orderType"] = ddlOrderType.SelectedValue;
                        Session["searchParamDict"] = searchParamDict;
                    }

					var employeeCode = ((List<UserModel>)Session["UserModel"]).FirstOrDefault().SupperAdmin ==Constansts.FlagActive ? "" : Session["User"].ToString();
					var createUser = ((List<UserModel>)Session["UserModel"]).FirstOrDefault().SupperAdmin == Constansts.FlagActive ? "" : Session["User"].ToString();

                    var listOrder = _orderService.OrderGet("", searchParamDict["orderCode"], "",
                                                            searchParamDict["trackingNumber"],
                                                            searchParamDict["fDate"],
                                                            searchParamDict["tDate"],
                                                            "",
                                                            searchParamDict["customerCode"],
                                                            "",//searchParamDict["userCode"],
                                                            searchParamDict["customerDeliveryNo"],
                                                            searchParamDict["orderNumber"],
                                                            "", 
															"",
                                                            searchParamDict["orderStatus"],
                                                            searchParamDict["orderType"],
															employeeCode,
															createUser,
															Constansts.FlagActive,
															"",
															this);
                    if (listOrder.Count == 0)
                    {
                        gridMain.Visible = false;
                        lblError.Visible = true;
                        lblError.Text = "Không tìm thấy dữ liệu theo điều kiện tìm kiếm!";
                        return;
                    }

                    gridMain.Visible = true;
                    lblError.Visible = false;
                    gridMain.DataSource = listOrder;
                    gridMain.DataBind();
                    Session[Constansts.SS_ORDERMODEL_LIST_ADMIN] = listOrder;
                }

                if (type == 2)
                {
                    if (Session[Constansts.SS_ORDERMODEL_LIST_ADMIN] != null)
                    {
                        var listOrder = (List<OrderModel>)Session[Constansts.SS_ORDERMODEL_LIST_ADMIN];
                        gridMain.DataSource = listOrder;
                        gridMain.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        private bool ValidData(ref DateTime fDate, ref DateTime tDate)
        {
            if (string.IsNullOrEmpty(txtFromDate.Text))
            {
                lblError.Text = "Từ ngày không được để trống!";
                lblError.Visible = true;
                return false;
            }

            try
            {
                CultureInfo viVN = new CultureInfo("vi-VN");
                fDate = DateTime.ParseExact(txtFromDate.Text, "dd/MM/yyyy", viVN);
            }
            catch
            {
                lblError.Text = "Từ ngày không đúng định dạng!";
                lblError.Visible = true;
                return false;
            }

            if (string.IsNullOrEmpty(txtToDate.Text))
            {
                lblError.Text = "Đến ngày không được để trống!";
                lblError.Visible = true;
                return false;
            }

            try
            {
                CultureInfo viVN = new CultureInfo("vi-VN");
                tDate = DateTime.ParseExact(txtToDate.Text, "dd/MM/yyyy", viVN);
            }
            catch
            {
                lblError.Text = "Đến ngày không đúng định dạng!";
                lblError.Visible = true;
                return false;
            }

            return true;
        }

		
        #endregion
    }
}