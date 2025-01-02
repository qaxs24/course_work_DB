ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_Positions
FOREIGN KEY (PositionID) REFERENCES Positions(PositionID);

ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_Departments
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID);

ALTER TABLE Projects
ADD CONSTRAINT FK_Projects_Clients
FOREIGN KEY (ClientID) REFERENCES Clients(ClientID);

ALTER TABLE Projects
ADD CONSTRAINT FK_Projects_ProjectManager
FOREIGN KEY (ProjectManagerID) REFERENCES Employees(EmployeeID);

ALTER TABLE Tasks
ADD CONSTRAINT FK_Tasks_Employees
FOREIGN KEY (AssignedTo) REFERENCES Employees(EmployeeID);

ALTER TABLE Tasks
ADD CONSTRAINT FK_Tasks_Projects
FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID);

ALTER TABLE Timesheets
ADD CONSTRAINT FK_Timesheets_Employees
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID);

ALTER TABLE Timesheets
ADD CONSTRAINT FK_Timesheets_Projects
FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID);

ALTER TABLE Timesheets
ADD CONSTRAINT FK_Timesheets_Tasks
FOREIGN KEY (TaskID) REFERENCES Tasks(TaskID);

ALTER TABLE Payroll
ADD CONSTRAINT FK_Payroll_Employees
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID);

ALTER TABLE Departments
ADD CONSTRAINT FK_Departments_Manager
FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID);

ALTER TABLE Inventory
ADD CONSTRAINT FK_Inventory_Materials
FOREIGN KEY (MaterialID) REFERENCES Materials(MaterialID);

ALTER TABLE Invoices
ADD CONSTRAINT FK_Invoices_Clients
FOREIGN KEY (ClientID) REFERENCES Clients(ClientID);

ALTER TABLE Invoices
ADD CONSTRAINT FK_Invoices_Projects
FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID);

ALTER TABLE Payments
ADD CONSTRAINT FK_Payments_Invoices
FOREIGN KEY (InvoiceID) REFERENCES Invoices(InvoiceID);

ALTER TABLE Contracts
ADD CONSTRAINT FK_Contracts_Projects
FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID);

ALTER TABLE Contracts
ADD CONSTRAINT FK_Contracts_Clients
FOREIGN KEY (ClientID) REFERENCES Clients(ClientID);

ALTER TABLE SupplierMaterials
ADD CONSTRAINT FK_SupplierMaterials_Suppliers
FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID);

ALTER TABLE SupplierMaterials
ADD CONSTRAINT FK_SupplierMaterials_Materials
FOREIGN KEY (MaterialID) REFERENCES Materials(MaterialID);

ALTER TABLE Equipment
ADD CONSTRAINT FK_Equipment_Projects
FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID);

ALTER TABLE Equipment
ADD CONSTRAINT FK_Equipment_Tasks
FOREIGN KEY (TaskID) REFERENCES Tasks(TaskID);

ALTER TABLE Equipment
ADD CONSTRAINT FK_Equipment_Suppliers
FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID);

ALTER TABLE ProjectMaterials
ADD CONSTRAINT FK_ProjectMaterials_Projects
FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID);

ALTER TABLE ProjectMaterials
ADD CONSTRAINT FK_ProjectMaterials_Materials
FOREIGN KEY (MaterialID) REFERENCES Materials(MaterialID);