using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ecms.Website.Site
{
    public partial class CMS1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        ///  Get url for display login text panel
        /// </summary>
        /// <returns></returns>
        protected bool CheckSigin()
        {
            return (Session["Customer"] == null);
        }
    }
}