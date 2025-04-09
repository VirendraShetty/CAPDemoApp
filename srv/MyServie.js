module.exports = function (srv) {
   
    // Implementation
    srv.on('helloWorld', function (req) {
        return "Hello, "+ req.data.name + "! Welcome...";
    }),

    srv.on('READ', function(request){
        return {
            "ID": "DUMMY ID",
            "nameFirst": "VIRAT",
            "nameInitials": null,
            "nameLast": "KOHLI",
            "nameMiddle": null,
            "phoneNumber": "900000000",
            "salaryAmount": "55549.00",
            "sex": "M"
          }
    })

}
 