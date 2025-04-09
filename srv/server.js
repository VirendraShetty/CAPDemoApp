const cds = require("@sap/cds");
const convertV2 = require("@cap-js-community/odata-v2-adapter");

cds.on("bootstrap",(app)=>app.use(convertV2()));
module.exports = cds.server;