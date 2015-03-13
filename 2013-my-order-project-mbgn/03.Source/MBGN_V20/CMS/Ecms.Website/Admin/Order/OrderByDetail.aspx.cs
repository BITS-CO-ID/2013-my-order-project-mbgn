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
    public partial class OrderByDetail : PageBase
    {
        #region //Declares

        private readonly OrderService _orderService = new OrderService();
        protected double dTotalMoney = 0;

        #endregion

        #region //Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["User"] == null)
                {
                    Response.Redirect("~/admin/security/login.aspx");
                }
                LoadData();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            try
            {
                if (Request.QueryString["orderId"] != null)
                {
                    var orderId = Request.QueryString["orderId"].ToString();
                    var result = _orderService.OrderChangeStatusWithRemark(
                                    orderId
                                    , Convert.ToString(OrderInStatus.OrderCancel)
                                    , ""
                                    , this);

                    if (result)
                    {
                        mtvMain.ActiveViewIndex = 1;
                        lblMessage.Text = "Bạn đã HỦY đơn hàng thành công";
                        //btnConfirm.Visible = false;
                        //btnConfirmCancel.Visible = false;
                        //txtRemark.Visible = false;
                        btnOK.Visible = true;
                    }

                }
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/admin/order/ordermanage.aspx");
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/admin/order/ordermanage.aspx");
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
                                    , "" //this.txtRemark.Text
                                    , this);
                    if (result)
                    {
                        mtvMain.ActiveViewIndex = 1;
                        lblMessage.Text = "Bạn đã xác nhận đơn hàng thành công";

                        //btnConfirm.Visible = false;
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

        protected void btnConfirmDelivery_Click(object sender, EventArgs e)
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
                        //btnConfirm.Visible = false;
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

        #endregion

        #region //Private methods

        private void LoadData()
        {
            if (Request.QueryString["orderId"] != null)
            {
                var order = _orderService.OrderGet(Request.QueryString["orderId"].ToString(), "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", this).FirstOrDefault();

                if (order != null)
                {
                    lblOrderNo.Text = order.OrderNo;
                    lblCreatedDate.Text = order.CreatedDate.Value.ToString("dd/MM/yyyy HH:mm:ss");
                    lblCustomerCode.Text = order.CustomerCode;
                    lblCustomerName.Text = order.CustomerName;
                    lblPhone.Text = order.Mobile;
                    lblAddress.Text = order.Address;
                    lblMaDonHang.Text = order.OrderNo;
                    lblMaKh.Text = order.CustomerCode;
                    lblTenKH.Text = order.CustomerName;
                    lblDiaChi.Text = order.Address;
                    lblSdtKH.Text = order.Mobile;
                    dTotalMoney = (order.SumAmount ?? 0);
                    gridMain.DataSource = order.lstOrderDetailModel;
                    gridMain.DataBind();
                    grvPrintDetail.DataSource = order.lstOrderDetailModel;
                    grvPrintDetail.DataBind();

                    if (order.OrderStatus == OrderInStatus.OrderPending)
                    {
                        btnConfirmDelivery.Enabled = false;
                        btnConfirmDelivery.CssClass = Constansts.CssClass_buttonDisable;
                    }

                    if (order.OrderStatus == OrderInStatus.OrderConfirmed)
                    {
                        btnConfirm.Enabled = btnCancel.Enabled = false;
                        btnConfirm.CssClass = btnCancel.CssClass = Constansts.CssClass_buttonDisable;
                    }

                    if (order.OrderStatus == OrderInStatus.OrderCancel)
                    {
                        btnConfirm.Enabled = btnConfirmDelivery.Enabled = btnCancel.Enabled = false;
                        btnConfirm.CssClass = btnConfirmDelivery.CssClass = btnCancel.CssClass = Constansts.CssClass_buttonDisable;
                    }

                    //if (order.OrderStatus == OrderInStatus.Finished)
                    //{
                    //    btnSave.Enabled = btnUpdate.Enabled = btnCancel.Enabled = btnRevert.Enabled = false;
                    //    btnSave.CssClass = btnUpdate.CssClass = btnCancel.CssClass = btnRevert.CssClass = Constansts.CssClass_buttonDisable;
                    //}

                    if (order.OrderStatus == OrderInStatus.Deliveried)
                    {
                        btnConfirm.Enabled = btnConfirmDelivery.Enabled = btnCancel.Enabled = false;
                        btnConfirm.CssClass = btnConfirmDelivery.CssClass = btnCancel.CssClass = Constansts.CssClass_buttonDisable;
                    }
                }
            }
            else
            {
                Response.Redirect("~/admin/order/ordermanage.aspx");
            }
        }

        protected void grvPrintDetail_OnDataBound(object sender, EventArgs e)
        {
            DataBound();
        }

        private void DataBound()
        {
            using (var db = new EcmsEntities())
            {
                if (grvPrintDetail.Rows.Count > 0)
                {
                    string strCategoryName = string.Empty;
                    string strWebsite = string.Empty;
                    for (int i = 0; i < grvPrintDetail.Rows.Count; i++)
                    {
                        var cellLoaiHang = grvPrintDetail.Rows[i].Cells[3];
                        var lblLoaiHang = (Label)cellLoaiHang.FindControl("lblLoaiHang");
                        var cellWebSite = grvPrintDetail.Rows[i].Cells[2];
                        var lblWebSite = (Label)cellWebSite.FindControl("lblWebsite");
                        int idCategory = !string.IsNullOrEmpty(lblLoaiHang.Text) ? Convert.ToInt32(lblLoaiHang.Text) : 0;
                        int idWebSite = !string.IsNullOrEmpty(lblWebSite.Text) ? Convert.ToInt32(lblWebSite.Text) : 0;
                        var category = (from m in db.Categories where m.CategoryId.Equals(idCategory) select m).FirstOrDefault();
                        var website = (from m in db.WebsiteLinks where m.WebsiteId.Equals(idWebSite) select m).FirstOrDefault();
                        if (category != null)
                            strCategoryName = category.CategoryName;
                        if (website != null)
                            strWebsite = website.WebLink;

                        grvPrintDetail.Rows[i].Cells[3].Text = strCategoryName;
                        grvPrintDetail.Rows[i].Cells[2].Text = strWebsite;
                    }

                }

            }

        }

        #endregion
    }
}