using System;
using System.Collections.Generic;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ecms.Website.DBServices;
using CommonUtils;
using Ecms.Website.Common;
using Ecms.Biz.Entities;
using Ecms.Biz;

namespace Ecms.Website.Admin.Order
{
    public partial class OrderByLinkDetail : PageBase
    {
        #region //Declares

        private readonly OrderService _orderService = new OrderService();
        private readonly CommonService _commonService = new CommonService();
        private readonly CustomerService _customerService = new CustomerService();

        protected double dQuantity = 0; // tổng số lượng

        protected double dShipToVN = 0; // Phí VC VN
        protected double dSurcharge = 0; // Phụ thu
        protected double dShip = 0; // Mua hộ

        protected double dCostBuyGood = 0; // Chi phí mua hàng
        protected double dSumFeeShip = 0; // Chi phí vận chuyển
        protected double dTotalBuyFor = 0; // Chi phí mua hộ
        protected double dPaymentBefor = 0; // Tiền thanh toán trước
        protected double dFeeDelay = 0; // Phí trả chậm
        protected double dTotalMoney = 0; // Tổng tiền đơn hàng
        protected double dRemainMoney = 0; // Tổng tiền còn lại phải trả
        #endregion

        #region //Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["User"] == null)
                    Response.Redirect("~/admin/security/login.aspx");

                LoadData();

                // Set Auth
                this.btnSave.CommandName = MenuFunction.Func_MHConfirm;
                this.btnUpdate.CommandName = MenuFunction.Func_MHFinished;
                this.btnComplete.CommandName = MenuFunction.Func_MHDeliverly;
                this.btnReverFirst.CommandName = MenuFunction.Func_MHRevertFinished;
                this.btnRevert.CommandName = MenuFunction.Func_MHRevertPending;
                this.btnCancel.CommandName = MenuFunction.Func_MHCancel;
                this.btnReverPending.CommandName = MenuFunction.Func_VCRevertPending;
                this.SetButtonAuth();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            mtvMain.ActiveViewIndex = 1;
            lblMessage.Text = "Bạn hãy nhập thông tin xác nhận đơn hàng này";
            btnConfirm.Visible = true;
            txtRemark.Visible = true;
            btnOK.Visible = false;
            btnConfirmCancel.Visible = false;
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            try
            {
                if (Request.QueryString["orderId"] != null)
                {

                    var orderId = Request.QueryString["orderId"].ToString();

                    var result = _orderService.OrderChangeStatusWithRemark(
                                    orderId
                                    , Convert.ToString(OrderInStatus.OrderConfirmed)
                                    , this.txtRemark.Text
                                    , this);
                    if (result)
                    {
                        mtvMain.ActiveViewIndex = 1;
                        lblMessage.Text = "Bạn đã xác nhận đơn hàng thành công";

                        btnConfirm.Visible = false;
                        btnConfirmCancel.Visible = false;
                        txtRemark.Visible = false;
                        btnOK.Visible = true;

                        //Gửi mail thông báo
                        string pathFile = Server.MapPath("~/Content/TemplateMail/OrderByLinkDetail.htm").Replace("\\", "/");
                        _commonService.SendMailConfirmedOrder(orderId, pathFile, this);
                    }

                }
                else
                {
                    Response.Redirect("~/admin/order/ordermanage.aspx");
                }
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        protected void btnReverPending_Click(object sender, EventArgs e)
        {
            try
            {
                lblError.Visible = false;
                if (Request.QueryString["orderId"] != null)
                {
                    var orderId = Request.QueryString["orderId"].ToString();

                    var result = _orderService.RevertFirstOrderStatus01(
                                    orderId
                                    , this);
                    if (result)
                    {
                        mtvMain.ActiveViewIndex = 1;
                        lblMessage.Text = "Bạn đã Hoàn lại TT cho đơn hàng thành công";
                        btnConfirm.Visible = false;
                        btnConfirmCancel.Visible = false;
                        txtRemark.Visible = false;
                        btnOK.Visible = true;
                    }
                }
                else
                {
                    Response.Redirect("~/admin/order/ordermanage.aspx");
                }
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        protected void btnReverFirst_Click(object sender, EventArgs e)
        {
            try
            {
                lblError.Visible = false;
                if (Request.QueryString["orderId"] != null)
                {
                    var orderId = Request.QueryString["orderId"].ToString();
                    // Check Xem đã thanh toán chưa?
                    var payments = new InvoiceService().InvoiceGet(
                                    ""
                                    , ""
                                    , ""
                                    , ""
                                    , ""
                                    , ""
                                    , ""
                                    , Convert.ToString(InvoiceStatus.Confirm)
                                    , orderId
                                    , ""
                                    , Const_BusinessCode.Business_201
                                    , ""
                                    , ""
                                    , ""
                                    , this);
                    if (payments != null && payments.Count > 0)
                    {
                        lblError.Text = "Đơn hàng đã được khớp thanh toán, bạn hãy Hủy khớp thanh toán trước khi Hoàn lại tình trạng!";
                        lblError.Visible = true;
                        return;
                    }

                    var result = _orderService.RevertFirstOrderStatus(
                                    orderId
                                    , this);
                    if (result)
                    {
                        mtvMain.ActiveViewIndex = 1;
                        lblMessage.Text = "Bạn đã Hoàn lại tình trạng Chưa xác nhận đơn hàng thành công";
                        btnConfirm.Visible = false;
                        btnConfirmCancel.Visible = false;
                        txtRemark.Visible = false;
                        btnOK.Visible = true;
                    }
                }
                else
                {
                    Response.Redirect("~/admin/order/ordermanage.aspx");
                }
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        protected void btnRevert_Click(object sender, EventArgs e)
        {
            try
            {

                if (Request.QueryString["orderId"] != null)
                {
                    var orderId = Request.QueryString["orderId"].ToString();

                    var result = _orderService.RevertOrderStatus(
                                    orderId
                                    , this);
                    if (result)
                    {
                        mtvMain.ActiveViewIndex = 1;
                        lblMessage.Text = "Bạn đã Hoàn lại tình trạng đơn hàng thành công";
                        btnConfirm.Visible = false;
                        btnConfirmCancel.Visible = false;
                        txtRemark.Visible = false;
                        btnOK.Visible = true;
                    }
                }
                else
                {
                    Response.Redirect("~/admin/order/ordermanage.aspx");
                }
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            mtvMain.ActiveViewIndex = 1;
            lblMessage.Text = "Bạn hãy nhập thông tin xác nhận HỦY đơn hàng này";
            btnConfirm.Visible = false;
            txtRemark.Visible = true;
            btnOK.Visible = false;
            btnConfirmCancel.Visible = true;
        }
        protected void btnConfirmCancel_Click(object sender, EventArgs e)
        {
            try
            {
                if (Request.QueryString["orderId"] != null)
                {
                    var orderId = Request.QueryString["orderId"].ToString();
                    var result = _orderService.OrderChangeStatusWithRemark(
                                    orderId
                                    , Convert.ToString(OrderInStatus.OrderCancel)
                                    , this.txtRemark.Text
                                    , this);

                    if (result)
                    {
                        mtvMain.ActiveViewIndex = 1;
                        lblMessage.Text = "Bạn đã HỦY đơn hàng thành công";
                        btnConfirm.Visible = false;
                        btnConfirmCancel.Visible = false;
                        txtRemark.Visible = false;
                        btnOK.Visible = true;
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
            Response.Redirect("~/admin/order/ordermanage.aspx?returnBack=return");
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/admin/order/ordermanage.aspx?returnBack=return");
        }

        protected void btnComplete_Click(object sender, EventArgs e)
        {
            try
            {
                if (Request.QueryString["orderId"] != null)
                {
                    var orderId = Request.QueryString["orderId"].ToString();
                    var result = _orderService.OrderChangeStatus(
                                    orderId
                                    , Convert.ToString(OrderInStatus.Deliveried)
                                    , this);
                    if (result)
                    {
                        lblMessage.Text = "Đơn hàng đã được xác nhận giao hàng.";
                        mtvMain.ActiveViewIndex = 1;
                        btnConfirm.Visible = false;
                        btnConfirmCancel.Visible = false;
                        txtRemark.Visible = false;
                        btnOK.Visible = true;
                    }
                }
                else
                {
                    Response.Redirect("~/admin/order/ordermanage.aspx");
                }
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                if (Request.QueryString["orderId"] != null)
                {
                    var orderId = Request.QueryString["orderId"].ToString();

                    var result = _orderService.OrderChangeStatus(orderId
                                    , Convert.ToString(OrderInStatus.Finished)
                                    , this);
                    if (result)
                    {
                        lblMessage.Text = "Đơn hàng đã được hoàn tất.";
                        mtvMain.ActiveViewIndex = 1;
                        btnConfirm.Visible = false;
                        btnConfirmCancel.Visible = false;
                        txtRemark.Visible = false;
                        btnOK.Visible = true;

                        ////Gửi mail thông báo
                        string pathFile = Server.MapPath("~/Content/TemplateMail/OrderByLinkDetailFinished.htm").Replace("\\", "/");
                        _commonService.SendMailConfirmedOrder(orderId, pathFile, this);
                    }
                }
                else
                {
                    Response.Redirect("~/admin/order/ordermanage.aspx");
                }
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        protected void gridMain_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            GridViewRow gvr = e.Row;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // cells 0 is columns SST
                HiddenField hdfOrderDetailId=(HiddenField)e.Row.Cells[0].FindControl("hdOrderDetailId");
                HiddenField hdfOrderDetailStatus = (HiddenField)e.Row.Cells[0].FindControl("hdfOrderDetailStatus");
                var orderId = hdfOrderDetailId.Value;
                var detailStatus = Convert.ToInt32(hdfOrderDetailStatus.Value==string.Empty?"0":hdfOrderDetailStatus.Value);

                // Get linkbutton Delete
                LinkButton lbnForDelete = (LinkButton)e.Row.Cells[0].FindControl("lbtnDelete");

                if (Session["OrderStatus"] != null && !string.IsNullOrEmpty(Session["OrderStatus"].ToString()))
                {
                    int orderstatus = (int)Session["OrderStatus"];

                    if (orderstatus == OrderInStatus.QuotePending || orderstatus == OrderInStatus.QuoteConfirmed || orderstatus == OrderInStatus.OrderPending)
                    {
                        if (detailStatus == OrderOutboundStatus.Cancel
                            || detailStatus == OrderOutboundStatus.InProcess
                            || detailStatus == OrderOutboundStatus.NoStatus)
                        {
                            lbnForDelete.Visible = true;
                        }
                        else
                        {
                            lbnForDelete.Visible = false;
                        }
                    }
                    else
                    {
                        lbnForDelete.Visible = false;
                    }
                }
            }
        }

        protected void gridMain_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "updateOrderDetail":
                    if (Request.QueryString["orderId"] != null)
                    {
                        var order = _orderService.OrderGet(Request.QueryString["orderId"].ToString(), "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", this).FirstOrDefault();
                        if (order != null)
                        {
                            var orderDetailId = Convert.ToInt32(e.CommandArgument + "");
                            var orderDetailFirst = order.lstOrderDetailModel.ToList().Where(x => x.OrderDetailId == orderDetailId).FirstOrDefault();
                            if (orderDetailFirst != null)
                            {
                                Session[Constansts.SS_ORDER_DETAIL_ADMIN] = orderDetailFirst;
                                Response.Redirect("~/admin/order/orderdetailupdate.aspx?orderId=" + Request.QueryString["orderId"].ToString());
                            }
                            else
                            {
                                Response.Redirect("~/admin/order/ordermanage.aspx");
                            }
                        }
                    }
                    break;
                case "ChangeStatusDelivery":
                    var param = e.CommandArgument.ToString().Split('|');
                    Response.Redirect(string.Format("~/admin/order/orderstatusupdate.aspx?orderDetailId={0}&cur_status={1}", param[1], param[0]));
                    break;
                case "DeleteOrderDetail":
                    var detailId = Convert.ToInt32(e.CommandArgument + "");

                    // delete detail
                    var result = _orderService.OrderDetailDelete(Convert.ToString(detailId), this.Page);

                    // bind data
                    this.LoadData();
                    break;
            }
        }

        protected void grvPrintDetail_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            GridViewRow gvr = e.Row;
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                e.Row.Cells[0].ColumnSpan = 11;                

                e.Row.Cells[1].Text = dShipToVN.ToString("N2");
                e.Row.Cells[2].Text = dSurcharge.ToString("N2");
                e.Row.Cells[3].Text = dShip.ToString("N2");
                e.Row.Cells[4].Text = dTotalMoney.ToString("N0");

                e.Row.Cells[0].CssClass
                    = e.Row.Cells[1].CssClass
                    = e.Row.Cells[2].CssClass
                    = e.Row.Cells[3].CssClass
                    = e.Row.Cells[4].CssClass = "Align-Text";

                for (int i = 5; i < grvPrintDetail.Columns.Count; i++)
                {
                    e.Row.Cells[i].Visible = false;
                }

                //// add column
                //this.AddRowFooter("Chi phí mua hàng(2): ", "0");

                //// add column
                //this.AddRowFooter("Chi phí nhập hộ hàng về Việt Nam(3):", "0");                

                // add column
                this.AddRowFooter("Đã thanh toán(2): ", dPaymentBefor.ToString("N0"));

                // add column
                this.AddRowFooter("Tiền vận chuyển(3):", "0");

                // add column
                this.AddRowFooter("Phí trả chậm(4): ", dFeeDelay.ToString("N0"));

                // add column
                this.AddRowFooter("Tổng tiền còn lại phải thanh toán = (1) + (4) - (2):", dRemainMoney.ToString("N0"));
            }
        }

        #endregion

        #region //Private methods

        private void LoadData()
        {
            if (Request.QueryString["orderId"] != null)
            {
                var order = _orderService.OrderGet(Request.QueryString["orderId"].ToString(), "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", this).FirstOrDefault();

                if (order != null)
                {
                    Session["OrderStatus"] = order.OrderStatus;

                    lblOrderNo.Text = order.OrderNo;
                    lblCreatedDate.Text = order.CreatedDate.Value.ToString("dd/MM/yyyy HH:mm:ss");
                    lblNgayDatHang.Text = order.CreatedDate.Value.ToString("dd/MM/yyyy");
                    lblMaDh.Text = order.OrderNo;
                    lblMaDonHang.Text = order.OrderNo;
                    lblNhanVienBH.Text = order.EmployeeCode;
                    lblTenKh.Text = order.CustomerName;
                    lblTenNv.Text = order.EmployeeName;
                    lblDiaChiKh.Text = order.Address;
                    lblSdtKh.Text = order.Mobile;
                    lblSdtNv.Text = order.DeliveryMobile;
                    lblEmailKh.Text = order.Email;
                    lblCustomerCode.Text = order.CustomerCode;
                    lblMaKh.Text = order.CustomerCode;
                    lblMaKhachHang.Text = order.CustomerCode;
                    lblCustomerName.Text = order.CustomerName;
                    lblTenKhachHang.Text = order.CustomerName;
                    lblDiaChi.Text = order.Address;
                    lblDienThoai.Text = order.Mobile;
                    lblTrackingNumber.Text = order.TrackingNo;
                    txtRemark.Text = order.Remark;
                    lblRemark.Text = order.Remark;
                    lblConfirmDate.Text = order.ConfirmDate == null ? "" : order.ConfirmDate.Value.ToString("dd/MM/yyyy");
                    lblNgayXacNhan.Text = order.ConfirmDate == null ? "" : order.ConfirmDate.Value.ToString("dd/MM/yyyy");
                    lblPhone.Text = order.Mobile;
                    lblAddress.Text = order.Address;
                    lblTotalMoneyOrder.Text = (order.SumAmount ?? 0).ToString("N0");
                    lblAmountFeeDelay.Text = (order.AmountFeeDelay).ToString("N0");
                    lblTotalAmountNormal.Text = order.TotalPayAmountNormal.ToString("N0");
                    lblAmountCalFeeDelay.Text = (order.AmountCalFeeDelay).ToString("N0");
                    lblSumFeeShip.Text = (order.SumFeeShip ?? 0).ToString("N0");
                    lblTotalAmount.Text = ((order.RemainAmount ?? 0)).ToString("N0");
                    gridMain.DataSource = order.lstOrderDetailModel;
                    gridMain.DataBind();


                    // bind data for delivery report
                    BindDataForDeliveryReport(order);

                    // bind data for order report
                    BindDataForOrderReport(order);

                    

                    if (order.OrderStatus == OrderInStatus.OrderPending)
                    {
                        btnUpdate.Enabled = btnComplete.Enabled = btnRevert.Enabled = btnReverFirst.Enabled = btnReverPending.Enabled = false;
                        btnUpdate.CssClass = btnComplete.CssClass = btnRevert.CssClass = btnReverFirst.CssClass = btnReverPending.CssClass = Constansts.CssClass_buttonDisable;
                    }

                    if (order.OrderStatus == OrderInStatus.OrderConfirmed)
                    {
                        btnSave.Enabled = btnCancel.Enabled = btnComplete.Enabled = btnRevert.Enabled = false;
                        btnSave.CssClass = btnCancel.CssClass = btnComplete.CssClass = btnRevert.CssClass = Constansts.CssClass_buttonDisable;
                    }

                    if (order.OrderStatus == OrderInStatus.OrderCancel)
                    {
                        btnSave.Enabled = btnComplete.Enabled = btnUpdate.Enabled = btnCancel.Enabled = btnRevert.Enabled = btnReverFirst.Enabled = btnReverPending.Enabled = false;
                        btnSave.CssClass = btnComplete.CssClass = btnUpdate.CssClass = btnCancel.CssClass = btnRevert.CssClass = btnReverFirst.CssClass = btnReverPending.CssClass = Constansts.CssClass_buttonDisable;
                    }

                    if (order.OrderStatus == OrderInStatus.Finished)
                    {
                        btnSave.Enabled = btnUpdate.Enabled = btnCancel.Enabled = btnRevert.Enabled = false;
                        btnSave.CssClass = btnUpdate.CssClass = btnCancel.CssClass = btnRevert.CssClass = Constansts.CssClass_buttonDisable;
                    }

                    if (order.OrderStatus == OrderInStatus.Deliveried)
                    {
                        btnSave.Enabled = btnUpdate.Enabled = btnCancel.Enabled = btnComplete.Enabled = btnReverFirst.Enabled = false;
                        btnSave.CssClass = btnUpdate.CssClass = btnCancel.CssClass = btnComplete.CssClass = btnReverFirst.CssClass = Constansts.CssClass_buttonDisable;
                    }
                }
            }
            else
            {
                Response.Redirect("~/admin/order/ordermanage.aspx");
            }

            // tạm thời ẩn
            //btnComplete.Visible = false;
        }

        #region // delivery report
        /// <summary>
        /// bind data for control on delivery report
        /// </summary>
        /// <param name="orderModel"></param>
        private void BindDataForDeliveryReport(OrderModel orderModel)
        {
            // bind data overview
            var lstDetail = orderModel.lstOrderDetailModel.ToList();
            dQuantity = lstDetail.Sum(p => p.Quantity ?? 0);

            // bind data to gridview
            grvMuaHo.DataSource = lstDetail.ToList();
            grvMuaHo.DataBind();
        }
        #endregion

        #region // order report
        /// <summary>
        /// bind data for control on delivery report
        /// </summary>
        /// <param name="orderModel"></param>
        private void BindDataForOrderReport(OrderModel orderModel)
        {
            // bind data overview
            lblPrtRemark.Text = orderModel.Remark;
            var lstDetail = orderModel.lstOrderDetailModel.ToList();
            dQuantity = lstDetail.Sum(p => p.Quantity ?? 0);

            dShipToVN = lstDetail.Sum(p => p.ShipModified != null ? p.ShipModified : p.ShipConfigValue != null ? p.ShipConfigValue : 0) ?? 0;
            dSurcharge = lstDetail.Sum(p => p.Surcharge ?? 0);
            dShip = lstDetail.Sum(p => p.ShipModified ?? 0);

            dPaymentBefor = orderModel.TotalPayAmountNormal;

            dFeeDelay = orderModel.AmountFeeDelay;

            dSumFeeShip = orderModel.SumFeeShip ?? 0;

            dTotalMoney = orderModel.SumAmount ?? 0;

            dRemainMoney = orderModel.RemainAmount ?? 0;

            // bind data to gridview
            grvPrintDetail.DataSource = lstDetail.ToList();
            grvPrintDetail.DataBind();

            // tổng tiền
            if (dRemainMoney > 0)
            {
                lblTienBangChu.Text = CommonUtils.StringUtils.LongInt2VNSpeakString((long)(Math.Round(dRemainMoney, 0)), "đồng");
            }
        }

        /// <summary>
        /// Add row in footer
        /// </summary>
        /// <param name="strColumnText">text of column</param>
        /// <param name="strColumnValue">value of colum</param>
        private void AddRowFooter(string strColumnText, string strColumnValue)
        {

            GridViewRow row = new GridViewRow(0, 0, DataControlRowType.Footer, DataControlRowState.Normal);

            // cel text
            TableCell cellText = new TableCell();
            cellText.Text = string.Format("<strong>{0}</strong>", strColumnText);
            row.Cells.Add(cellText);

            // cel value
            TableCell cellValue = new TableCell();
            cellValue.Text = string.Format("<strong>{0}</strong>", strColumnValue);
            row.Cells.Add(cellValue);

            grvPrintDetail.Controls[0].Controls.Add(row);

            // span first column for 11 columns
            row.Cells[0].ColumnSpan = 11;
            row.Cells[0].CssClass = "Align-Text";

            row.Cells[1].ColumnSpan = 4;
            row.Cells[1].CssClass = "Align-Text";
        }
        #endregion

        #endregion
    }
}