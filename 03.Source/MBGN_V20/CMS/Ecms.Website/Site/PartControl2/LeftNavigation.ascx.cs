using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ecms.Website.Common;
using Ecms.Website.DBServices;
using System.Text;

namespace Ecms.Website.Site.PartControl2
{
    public partial class LeftNavigation : System.Web.UI.UserControl
    {
        #region //Declares

        private readonly CommonService _commonService = new CommonService();

        #endregion

        #region //Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        #endregion

        #region //Private methods

        private void LoadData()
        {
            try
            {
                var websites = new CommonService().WebsiteList("", "", "");
                var strParentWebsite = new StringBuilder();
                foreach (var item in websites.Where(x => x.ParentId == null).Take(9))
                {
                    string strParentWebFormat = string.Format("<li><a href='{0}' title='{1}'>{2}</a></li>"
                                                , ResolveUrl(string.Format("~/web/{0}/{1}.htm", Utils.RecoverUrlName(item.WebsiteName), item.WebsiteId))
                                                , item.WebsiteName
                                                , item.WebsiteName);

                    strParentWebsite.Append(strParentWebFormat);
                }

                // add last item
                strParentWebsite.Append(string.Format("<li class='last'><a href='{0}' title='{1}'>{2}</a></li>"
                                                , ResolveUrl(string.Format("~/web/web-ban-hang-my/0.htm"))
                                                , ""
                                                , "Nhiều website hơn..."));

                litMenuLeft.Text = strParentWebsite.ToString();
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this.Page);
            }
        }

        #endregion
    }
}