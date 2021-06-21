// Load Active Admin's styles into Webpacker,
// see `active_admin.scss` for customization.
import JQuery from 'jquery';
window.$ = window.JQuery = window.jQuery = JQuery;
require("jquery")
import "../stylesheets/active_admin";

import "@activeadmin/activeadmin";
