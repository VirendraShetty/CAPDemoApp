module.exports = cds.service.impl(async function () {
    // Refrence to your entity
    const { POService, EmployeeS } = this.entities;
    this.on('increasedPrice', async (request, response) => {
        try {
            const ID = request.params[0];
            console.log("Node Key : " + request.params[0].node_key);
            const tx = cds.tx(request);
            // SAP CDS TX Library calss object which will initiate the DB transactions
            await tx.update(POService).with({
                gross_amount: { '+=': 1000 }
            }).where(ID);

            return ID;
        } catch (error) {
            return "Error" + error.toString();
        }
    }),
        this.on('getHighestOrder', async (request, response) => {
            try {
                const tx = cds.tx(request);
                const HighestOrder = await tx.read(POService).orderBy({
                    gross_amount: 'desc'
                }).limit(1);

                return HighestOrder;
            } catch (error) {
                return "Error" + error.toString();
            }
        }),
        this.on('getLowestOrder', async (request, response) => {
            try {
                // Refrence constant for your transaction
                const tx = cds.transaction(request);
                const LowestOrder = await tx.run(
                    SELECT.from(SOA_DB_TRASACTION_PURCHASEORDER).orderBy({ 'gross_amount': desc }).limit(1)
                );
                return LowestOrder;
            } catch (error) {
                return "Error" + error.toString();
            }
        }),
        this.on('increasedTax', async (request, response) => {
            try {
                const ID = request.params[0];
                const tx = cds.tx(request);
                // await tx.update(POService).with({
                //     gross_amount: { '+=' : 1000 }
                // }).where(ID);
                await tx.run(
                    UPDATE(SOA_DB_TRASACTION_PURCHASEORDER).set({ tax_amount: 1000 }).where({ id: ID })
                );

                await tx.commit();
                return ID;
            } catch (error) {
                return "Error" + error.toString();
            }
        }),
        // Salary Chek
        this.before('CREATE', EmployeeS, async (request, response) => {
            // Data which will be inserted
            var empStructure = request.data;

            // Validate the salary
            if (empStructure.salaryAmount > 70000) {
                // Throw some error
                request.error(500, "This much salary is not allowed..!")
            }
        }),
        this.on('userLogin', async(request, response) => {
            try {
                var arrUserLogin = [];
                var struUserLogin = {};
                struUserLogin.username = request.data.username;
                struUserLogin.pwd = request.data.pwd;
                arrUserLogin.push(struUserLogin);
                // Declare promisfied class
                const dbClass = require("sap-hdbext-promisfied");
                const hdbext = require("@sap/hdbext");
                let dbConn = new dbClass(await dbClass.createConnection(db.operations.credentials));
                const sp = await dbClass.loadProcedurePromisfied(hdbext, null, 'createUser');
                const output = await dbConn.callProcedurePromisified(sp,arrUserLogin)
                return output;
            } catch (error) {
                return "Error" + error.toString();
            }
        })
     
})

// Second way
// const srv = (new cds.service).on('READ','Book', req=> console.log(req.event, resizeBy.event))