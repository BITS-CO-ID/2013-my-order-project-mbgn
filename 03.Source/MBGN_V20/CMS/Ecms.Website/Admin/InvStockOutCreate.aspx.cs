using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ecms.Website.DBServices;
using Ecms.Website.Site.MBGN;
using Ecms.Website.Common;
using System.Configuration;
using System.Data;
using System.IO;
using Ecms.Biz.Entities;
using CommonUtils;

namespace Ecms.Website.Admin
{
    public partial class InvStockOutCreate : PageBase
    {
        #region //Declares

        private readonly StockService _stockService = new StockService();
        private readonly ProductService _productService = new ProductService();

        #endregion

        #region //Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["User"] == null)
                    Response.Redirect("~/admin/security/login.aspx");
                LoadData();

                loadCustomer();
            }
        }

        protected void chkCusType_OnCheckedChanged(object sender, EventArgs e)
        {
            if (chkCusType.Checked)
            {
                this.txtCusCode.Enabled = true;
                this.ddlCustomer.Enabled = false;
            }
            else
            {
                this.txtCusCode.Enabled = false;
                this.ddlCustomer.Enabled = true;
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            //if (ddlMethodImport.SelectedValue.Equals("0"))
            {
                AddToListProduct(txtSerial.Text, txtQuantity.Text, txtPrice.Text);
            }
            //else
            {
                //UploadAndAddToListProduct();
            }
        }

        protected void btnImport_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["CartExport"] != null)
                {
                    var carts = (List<CartModel>)Session["CartExport"];
                    var stockInOut = new Inv_StockInOut();
                    stockInOut.Type = (byte)StockType.StockOut; // stock out
                    if (Session["User"] != null)
                    {
                        stockInOut.CreatedUser = Session["User"].ToString();
                    }
					stockInOut.status = StockStatus.StockConfirmed;
					stockInOut.InOutDate = DateTime.Now;
					stockInOut.Remark = "Xuất kho";

                    if (chkCusType.Checked && !string.IsNullOrEmpty(txtCusCode.Text))
                    {
                        stockInOut.CusName = txtCusCode.Text;
                    }
                    else if (!chkCusType.Checked)
                    {
                        stockInOut.CustomerId = Convert.ToInt32(ddlCustomer.SelectedValue);
                        stockInOut.CusName = ddlCustomer.Text;
                    }

                    foreach (var item in carts)
                    {
                        var stockInOutDetail = new Inv_StockInOutDetail();
                        stockInOutDetail.ProductId = item.ProductId;
                        stockInOutDetail.Price = item.Price;
                        stockInOutDetail.Quantity = item.Quantity;
                        stockInOutDetail.Serial = item.Serial;                        
                        stockInOut.Inv_StockInOutDetail.Add(stockInOutDetail);
                    }
                    var stockInOutReturn = _stockService.StockInOutCreate(stockInOut, this);
                    if (stockInOutReturn != null)
                    {
						Session.Remove("CartExport");

                        Session["StockInOutReturn"] = stockInOutReturn;						
						mtvMain.ActiveViewIndex = 1;
                    }
                }
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/admin/invstockoutmanage.aspx");
        }

        protected void btnOk_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/admin/invstockoutmanage.aspx");
        }

        protected void gridMain_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                switch (e.CommandName)
                {
                    case "productDelete":
                        var productId = Convert.ToInt32(e.CommandArgument);
                        if (Session["CartExport"] != null)
                        {
                            var productCart = (List<CartModel>)Session["CartExport"];
                            if (productCart.Count != 0)
                            {
                                var product = productCart.Where(x => x.ProductId == productId).FirstOrDefault();

                                if (product != null)
                                {
                                    productCart.Remove(product);
                                    Session["CartExport"] = productCart;
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

        protected void btnConfirmImport_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["StockInOutReturn"] != null)
                {
                    var stockInOut = (Inv_StockInOut)Session["StockInOutReturn"];
                    if (stockInOut != null)
                    {
                        stockInOut.status = 2;
                        var stockInOutReturn = _stockService.StockInOutUpdate(stockInOut, this);
                        if (stockInOutReturn != null)
                        {
                            var listGoods = new List<Inv_Goods>();
                            foreach (var item in stockInOut.Inv_StockInOutDetail.ToList())
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
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        protected void gridMain_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gridMain.PageIndex = e.NewPageIndex;
            LoadData();
        }

        #endregion
        
        #region //Private methods

        private void AddToListProduct(string serial, string qty, string productPrice)
        {

            #region // validate input
            if (string.IsNullOrEmpty(serial))
            {
                lblError.Text = "Bạn chưa nhập serial sản phẩm!";
                lblError.Visible = true;
                return;
            }

            if (string.IsNullOrEmpty(qty))
            {
                lblError.Text = "Bạn chưa Xuất mã sản phẩm!";
                lblError.Visible = true;
                return;
            }else
            {
                double dQty=0;
                if (!double.TryParse(qty,out dQty))
                {
                    lblError.Text = "Số lượng không chunhs xác!";
                    lblError.Visible = true;
                    return;
                }
            }

            if (string.IsNullOrEmpty(productPrice))
            {
                lblError.Text = "Bạn chưa nhập giá sản phẩm!";
                lblError.Visible = true;
                return;
            }

            #endregion

            try
            {
                //Lấy thông tin sản phẩm
                var productReturn = _productService.ProductGet("", serial, "", "", "", "", "", "", "", "", "", this).FirstOrDefault();
                if (productReturn != null)
                {
                    List<CartModel> carts = new List<CartModel>();
                    CartModel productTemp = new CartModel();
                    if (Session["CartExport"] != null)
                    {
                        carts = (List<CartModel>)Session["CartExport"];                        
                        var product = carts.Where(x => x.Serial == serial).FirstOrDefault();
                        if (product != null)
                        {
                            lblError.Text = "Serial sản phẩm này đã có trong danh sách";
                            lblError.Visible = true;
                            return;
                        }
                        else
                        {
                            
                            productTemp.ProductId = productReturn.ProductId.Value;
                            productTemp.ProductName = productReturn.ProductName;
                            productTemp.ProductCode = productReturn.ProductCode;
                            productTemp.CategoryName = productReturn.CategoryName;
                            productTemp.Serial = serial;
                            productTemp.Price = Convert.ToInt32(txtPrice.Text.Replace(",", ""));
                            productTemp.Quantity = Convert.ToInt32(txtQuantity.Text.Replace(",", ""));
                        }
                    }
                    else
                    {
                        productTemp.ProductId = productReturn.ProductId.Value;
                        productTemp.ProductName = productReturn.ProductName;
                        productTemp.ProductCode = productReturn.ProductCode;
                        productTemp.CategoryName = productReturn.CategoryName;
                        productTemp.Serial = serial;
                        productTemp.Price = Convert.ToInt32(txtPrice.Text.Replace(",", ""));
                        productTemp.Quantity = Convert.ToInt32(txtQuantity.Text.Replace(",", ""));
                    }
                    carts.Add(productTemp);
                    Session["CartExport"] = carts;
                    txtPrice.Text = txtSerial.Text = "";
                    LoadData();
                }
                else
                {
                    lblError.Visible = true;
                    lblError.Text = "Mã sản phẩm(Serial) không tồn tại!";
                    return;
                }
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        private void LoadData()
        {
            if (Session["CartExport"] != null)
            {
                List<CartModel> carts = (List<CartModel>)Session["CartExport"];
                if (carts.Count == 0)
                {
                    pnData.Visible = false;
                }
                else
                {
                    gridMain.DataSource = carts;
                    gridMain.DataBind();
                    pnData.Visible = true;
                }
            }
            else
            {
                pnData.Visible = false;
            }
        }

        private void loadCustomer()
        {
            var  _cusService = new CustomerService();

            var lst= _cusService.CustomerList(
                        ""
                        ,""
                        ,""
                        ,""
                        ,""
                        ,""
                        ,""
                        ,""
                        ,""
                        ,"0"
                        ,"0"
                        , this.Page);

            foreach (var item in lst)
            {
                item.CustomerName = string.Format("{0} - {1}", item.CustomerCode, item.CustomerName);
            }

            ddlCustomer.DataSource = lst;
            ddlCustomer.DataTextField = "CustomerName";
            ddlCustomer.DataValueField = "CustomerId";
            ddlCustomer.DataBind();

        }

        #endregion
    }
}