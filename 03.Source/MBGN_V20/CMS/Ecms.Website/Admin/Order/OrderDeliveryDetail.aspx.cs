using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ecms.Biz;
using CommonUtils;
using Ecms.Biz.Entities;
using Ecms.Website.DBServices;
using Ecms.Website.Common;
using System.Globalization;
using System.Data;

namespace Ecms.Website.Admin.Order
{
    public partial class OrderDeliveryDetail : PageBase
    {
        #region // Declares

        private readonly OrderService _orderService = new OrderService();
        private readonly CommonService _commonService = new CommonService();

        protected double dWeight = 0;
        protected double dTotalAmount = 0;
        #endregion

        #region // Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["User"] == null)
                    Response.Redirect("~/admin/security/login.aspx");

                LoadData(1);

                // Set Auth
                this.btnSave.CommandName = MenuFunction.Func_VCConfirm;
                this.btnUpdate.CommandName = MenuFunction.Func_VCFinished;
                this.btnComplete.CommandName = MenuFunction.Func_VCDeliverly;
                this.btnReverFirst.CommandName = MenuFunction.Func_VCRevertFinished;
                this.btnRevert.CommandName = MenuFunction.Func_VCRevertPending;

                this.btnReverPending.CommandName = MenuFunction.Func_VCRevertPending;

                this.btnCancel.CommandName = MenuFunction.Func_VCCancel;

                this.SetButtonAuth();


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
                        lblMessage.Text = "Đơn hàng đã được HỦY!";
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
                        lblMessage.Text = "Đơn hàng đã được xác nhận!";
                        btnConfirm.Visible = false;
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
                    var result = _orderService.OrderChangeStatus(
                                Request.QueryString["orderId"]
                                , Convert.ToString(OrderInStatus.Deliveried)
                                , this);

                    if (result)
                    {
                        mtvMain.ActiveViewIndex = 1;
                        lblMessage.Text = "Đơn hàng đã được xác nhận giao hàng.";
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

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                if (Request.QueryString["orderId"] != null)
                {
                    var orderId = Request.QueryString["orderId"].ToString();
                    var result = _orderService.OrderChangeStatus(
                        orderId
                        , Convert.ToString(OrderInStatus.Finished)
                        , this);

                    if (result)
                    {
                        mtvMain.ActiveViewIndex = 1;
                        lblMessage.Text = "Đơn hàng đã được hoàn thành!";
                        btnConfirm.Visible = false;
                        btnConfirmCancel.Visible = false;
                        txtRemark.Visible = false;
                        btnOK.Visible = true;
                        //Gửi mail thông báo đã xác nhận đơn hàng
                        string pathFile = Server.MapPath("~/Content/TemplateMail/OrderDeliveryDetail.htm").Replace("\\", "/");
                        _commonService.SendMailConfirmedOrder(orderId, pathFile, this);
                    }
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

                    //// Check Xem đã thanh toán chưa?
                    //var payments = new InvoiceService().InvoiceGet(
                    //                ""
                    //                , ""
                    //                , ""
                    //                , ""
                    //                , ""
                    //                , ""
                    //                , ""
                    //                , Convert.ToString(InvoiceStatus.Confirm)
                    //                , orderId
                    //                , ""
                    //                , Const_BusinessCode.Business_201
                    //                , ""
                    //                , ""
                    //                , ""
                    //                , this);
                    //if (payments != null && payments.Count > 0)
                    //{
                    //    lblError.Text = "Đơn hàng đã được khớp thanh toán, bạn hãy Hủy khớp thanh toán trước khi Hoàn lại tình trạng!";
                    //    lblError.Visible = true;
                    //    return;
                    //}

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
                        lblMessage.Text = "Bạn đã Hoàn lại tình trạng Chưa xác nhận cho đơn hàng thành công";
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
                    var result = _orderService.RevertOrderStatus(
                                Request.QueryString["orderId"]
                                , this);

                    if (result)
                    {
                        mtvMain.ActiveViewIndex = 1;
                        lblMessage.Text = "Đơn hàng đã được Hoàn lại tình trạng 'Hoàn Thành'";
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

        protected void gridMain_DataBound(object sender, EventArgs e)
        {
            MergeRows(gridMain);
        }

        protected void gridMain_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (Request.QueryString["orderId"] != null)
                {
                    var order = _orderService.OrderGet(Request.QueryString["orderId"].ToString(), "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", this).FirstOrDefault();
                    var dictChangeStatus = new Dictionary<string, string>();
                    var param = e.CommandArgument.ToString().Split('|');
                    if (order != null && param.Count() == 7)
                    {
                        dictChangeStatus.Add("orderId", order.OrderId + "");
                        dictChangeStatus.Add("trackingNumber", param[0]);
                        dictChangeStatus.Add("orderNumber", param[1]);
                        dictChangeStatus.Add("DetailStatus", param[2]);
                        dictChangeStatus.Add("orderDetailId", param[3]);
                        dictChangeStatus.Add("customerTypeId", order.CustomerTypeId + "");
                        dictChangeStatus.Add("DateToUsa", param[4]);
                        dictChangeStatus.Add("DeliveryVNDate", param[5]);
                        dictChangeStatus.Add("DeliveryDate", param[6]);
                        Session["dictChangeStatus"] = dictChangeStatus;
                    }
                    else
                    {
                        //Response.Redirect("~/admin/order/ordermanage.aspx");
                    }

                    switch (e.CommandName)
                    {
                        case "ChangeStatus":
                            Response.Redirect("~/admin/order/changedeliverystatus.aspx?orderId=" + order.OrderId);
                            break;
                        case "UpdateProduct":
                            Response.Redirect("~/admin/order/orderdetaildeliveryupdate.aspx?orderId=" + order.OrderId);
                            break;
                        case "UpdateOrderDetail":
                            Response.Redirect(string.Format("~/admin/order/orderdetailproductupdate.aspx?orderId={0}", order.OrderId));
                            break;
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

        protected void gridMain_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gridMain.PageIndex = e.NewPageIndex;
            LoadData(2);
        }

        #endregion

        #region // Private methods

        private void LoadData(int type)
        {
            if (type == 1)
            {
                if (Request.QueryString["orderId"] != null)
                {
                    var order = _orderService.OrderGet(Request.QueryString["orderId"].ToString(), "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", this).FirstOrDefault();

                    if (order != null)
                    {
                        lblOrderNo.Text = order.OrderNo;
                        lblCreatedDate.Text = order.CreatedDate.Value.ToString("dd/MM/yyyy HH:mm:ss");
                        if (!string.IsNullOrEmpty(order.CustomerCodeDelivery))
                        {
                            lblCustomerCode.Text = order.CustomerCode + "/" + order.CustomerCodeDelivery;
                        }
                        else
                        {
                            lblCustomerCode.Text = order.CustomerCode;
                        }
                        lblCustomerName.Text = order.CustomerName;                        
                        lblPhone.Text = order.Mobile;
                        lblAddress.Text = order.Address;
                        txtRemark.Text = order.Remark;
                        lblRemark.Text = order.Remark;
                        lblTotalMoneyOrder.Text = (order.SumAmount ?? 0).ToString("N0");
                        lblTotalAmountNormal.Text = order.TotalPayAmountNormal.ToString("N0");
                        lblTotalRemain.Text = (order.RemainAmount ?? 0).ToString("N0");

                        if (order.DateToUsa != null)
                        {
                            cldFromDate.SelectedDate = order.DateToUsa.Value;
                        }

                        var dataSource = order.lstOrderDetailModel.ToList().OrderBy(x => x.TrackingNo).ToList();

                        gridMain.DataSource = dataSource;
                        gridMain.DataBind();

                        Session["OrderDelivery"] = order;
                        Session["OrderDeliveryDetail"] = dataSource;

                        // bind data for Print
                        this.BindDataForPrint(order);

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
            }

            if (type == 2)
            {
                if (Session["OrderDeliveryDetail"] != null)
                {
                    var listOrderDetail = (List<OrderDetailModel>)Session["OrderDeliveryDetail"];
                    gridMain.DataSource = listOrderDetail;
                    gridMain.DataBind();

                    // bind data for Print
                    if (Session["OrderDelivery"] != null)
                    {
                        var orderDelivery = (OrderModel)Session["OrderDelivery"];

                        this.BindDataForPrint(orderDelivery);
                    }
                }
            }

            // tạm thời ẩn
            //btnComplete.Visible = false;
        }

        private bool ValidData(ref DateTime tDate)
        {
            //if (string.IsNullOrEmpty(txtDateToUsa.Text))
            //{
            //    lblError.Text = "Ngày đến Mỹ không được để trống!";
            //    lblError.Visible = true;
            //    return false;
            //}
            if (!string.IsNullOrEmpty(txtDateToUsa.Text))
            {
                try
                {
                    CultureInfo viVN = new CultureInfo("vi-VN");
                    tDate = DateTime.ParseExact(txtDateToUsa.Text, "dd/MM/yyyy", viVN);
                }
                catch
                {
                    lblError.Text = "Ngày đến Mỹ không đúng định dạng!";
                    lblError.Visible = true;
                    return false;
                }
            }
            return true;
        }

        public void MergeRows(GridView gridView)
        {
            for (int rowIndex = gridView.Rows.Count - 2; rowIndex >= 0; rowIndex--)
            {
                GridViewRow row = gridView.Rows[rowIndex];
                GridViewRow previousRow = gridView.Rows[rowIndex + 1];
                var lit1 = (LinkButton)row.Cells[1].FindControl("lbtnTrackingNumber");
                var lit2 = (LinkButton)previousRow.Cells[1].FindControl("lbtnTrackingNumber");

                if (lit1.Text == lit2.Text)
                {
                    //Gộp tracking
                    row.Cells[2].RowSpan = previousRow.Cells[2].RowSpan < 2 ? 2 : previousRow.Cells[2].RowSpan + 1;
                    previousRow.Cells[2].Visible = false;
                    //Gộp Order Number
                    row.Cells[3].RowSpan = previousRow.Cells[3].RowSpan < 2 ? 2 : previousRow.Cells[3].RowSpan + 1;
                    previousRow.Cells[3].Visible = false;


                    //Gộp ngày đến Mỹ
                    row.Cells[12].RowSpan = previousRow.Cells[12].RowSpan < 2 ? 2 : previousRow.Cells[12].RowSpan + 1;
                    previousRow.Cells[12].Visible = false;

                    // Gộp ngày giao hàng
                    row.Cells[13].RowSpan = previousRow.Cells[13].RowSpan < 2 ? 2 : previousRow.Cells[13].RowSpan + 1;
                    previousRow.Cells[13].Visible = false;

                    //Gộp trạng thái
                    row.Cells[16].RowSpan = previousRow.Cells[16].RowSpan < 2 ? 2 : previousRow.Cells[16].RowSpan + 1;
                    previousRow.Cells[16].Visible = false;
                }
            }
        }

        /// <summary>
        /// bind data for print screen
        /// </summary>
        /// <param name="order"></param>
        private void BindDataForPrint(OrderModel order)
        {
            // bind data for Print Overview
            lblOrderNoPrint.Text = order.OrderNo;
            if (!string.IsNullOrEmpty(order.CustomerCodeDelivery))
            {
                lblMaKh.Text = order.CustomerCode + "/" + order.CustomerCodeDelivery;
            }
            else
            {
                lblMaKh.Text = order.CustomerCode;
            }
            lblTenKH.Text = order.CustomerName;
            lblDiaChi.Text = order.Address;
            lblSdtKH.Text = order.Mobile;

            // bind data for Print Detail
            var lstOrderDetail = order.lstOrderDetailModel.ToList();
            if (lstOrderDetail != null && lstOrderDetail.Count > 0)
            {
                dWeight = lstOrderDetail.Sum(p => p.Weight??0);
                dTotalAmount = lstOrderDetail.Sum(p => p.TotalMoney);

                grvPrintDetail.DataSource = lstOrderDetail;
                grvPrintDetail.DataBind();                
            }
        }

        #endregion
    }
}