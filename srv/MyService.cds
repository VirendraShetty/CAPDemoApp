using {soa.db} from '../db/data-model';

service MyService@(path:'FunctionExampleService'){

    function helloWorld(name:String(20)) returns String(100);

    @readOnly
    entity EmployeeService as projection on db.master.employees;
}