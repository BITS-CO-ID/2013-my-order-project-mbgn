using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CommonUtils;
using Ecms.Biz.Class;
using Ecms.Biz.Entities;
using Ecms.Website.DBServices;

namespace Ecms.Website.Admin
{
    public partial class ImportStockOutDetail : PageBase
    {
        #region //Declares

        private readonly StockService _stockService = new StockService();
        protected double dAmount = 0; // tổng số lượng
        #endregion

        #region //Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["User"] == null)
                    Response.Redirect("~/admin/security/login.aspx");

                LoadData();
            }
        }

        protected void gridMain_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gridMain.PageIndex = e.NewPageIndex;
            LoadData();
        }

        protected void btnImport_Click(object sender, EventArgs e)
        {
            if (Session[Constansts.SS_STOCK_INOUT_ADMIN] != null)
            {
                var inv_stockInoutModel = (Inv_StockInOutModel)Session[Constansts.SS_STOCK_INOUT_ADMIN];
                if (inv_stockInoutModel != null)
                {


                    Inv_StockInOut stockInOut = new Inv_StockInOut();

                    stockInOut.InOutDate = DateTime.Now;
                    stockInOut.StockOutNo = inv_stockInoutModel.StockOutNo;
                    stockInOut.CreatedDate = inv_stockInoutModel.CreatedDate;
                    stockInOut.CreatedUser = inv_stockInoutModel.UserCode;
                    stockInOut.Remark = inv_stockInoutModel.Remark;
                    stockInOut.Type = inv_stockInoutModel.Type;
                    stockInOut.CustomerId = inv_stockInoutModel.CustomerId;                    
                    stockInOut.StockInOutId = inv_stockInoutModel.StockInOutId;
                    stockInOut.status = 2;
                    var stockInOutReturn = _stockService.StockInOutUpdate(stockInOut, this);
                    if (stockInOutReturn != null)
                    {
                        var listGoods = new List<Inv_Goods>();
                        foreach (var item in inv_stockInoutModel.lstStockInOutDetailModel.ToList())
                        {
                            var goods = new Inv_Goods();
                            goods.ProductId = item.ProductId;
                            goods.Serial = item.Serial;
                            goods.StockInId = stockInOut.StockInOutId;
                            listGoods.Add(goods);
                        }
                        _stockService.GoodsCreate(listGoods, this);
                        mtvMain.ActiveViewIndex = 1;
                    }
                }
            }
        }

        protected void btnOk_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/admin/InvStockOutManage.aspx");
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/admin/InvStockOutManage.aspx");
        }

        #endregion

        #region //Private methods

        private void LoadData()
        {
            if (Session[Constansts.SS_STOCK_INOUT_ADMIN] != null)
            {
                var inv_stockInoutModel = (Inv_StockInOutModel)Session[Constansts.SS_STOCK_INOUT_ADMIN];
                if (inv_stockInoutModel != null)
                {
                    lblCode.Text = inv_stockInoutModel.StockOutNo;
                    lblCreateDate.Text = inv_stockInoutModel.CreatedDate.Value.ToString("dd/MM/yyyy HH:mm:ss");
                    lblCreatedUser.Text = inv_stockInoutModel.UserCode;
                    lblImportDate.Text = inv_stockInoutModel.InOutDate != null ? inv_stockInoutModel.InOutDate.Value.ToString("dd/MM/yyyy HH:mm:ss") : "";
                    lblStatus.Text = inv_stockInoutModel.StatusText;

                    if (inv_stockInoutModel.Status == 1)
                    {
                        btnImport.Visible = true;
                    }
                    else
                    {
                        btnImport.Visible = false;
                    }
                    var lstDetail = inv_stockInoutModel.lstStockInOutDetailModel.ToList();
                    lblSumAmount.Text = lstDetail.Sum(x=>x.Price??0).ToString("N0");
                    gridMain.DataSource = lstDetail;
                    gridMain.DataBind();


                    // print

                    dAmount = lstDetail.Sum(x => (x.Price ?? 0) * (x.Quantity??0));

                    lblMaDonHang.Text = inv_stockInoutModel.StockOutNo;
                    lblDateStock.Text = inv_stockInoutModel.InOutDate != null ? inv_stockInoutModel.InOutDate.Value.ToString("dd/MM/yyyy") : "";
                    lblStatusPrint.Text = inv_stockInoutModel.StatusText;

                    grdStockPrint.DataSource = lstDetail;
                    grdStockPrint.DataBind();
                }
            }
            else
            {
                Response.Redirect("~/admin/InvStockOutManage.aspx");
            }
        }

        #endregion
    }
}