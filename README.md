**PLSQL GROUPWORK**
**GROUP MEMBERS**
**Imani Nzeyimana David 27896**
**Isaro Shania Ida 27970**
**MURERWA Molly 28057**
**MUWUMUREMYI Honorine 27830**



# AUCA System Access Policy & HR Employee Management System

## 1. What the Questions Were About

### Question 1 — AUCA System Access Policy (Triggers)
The task required enforcing access rules for the AUCA system:
- Users **cannot access or modify data on Saturday and Sunday**.
- Users **can only access the system Monday–Friday, from 8:00 AM to 5:00 PM**.
- Any attempt outside allowed days or hours should be **blocked**.
- All blocked attempts should be **logged automatically** for auditing purposes.

**Goal:** Demonstrate database triggers that enforce real-time security and logging.

---

### Question 2 — HR Employee Management System (PL/SQL Package)
The task required designing a PL/SQL package to manage employees’ salaries:
- **Function** to calculate RSSB tax (5%) and return net salary.
- **Dynamic procedure** using `EXECUTE IMMEDIATE` to perform operations (e.g., create or update tables).
- Demonstrate **USER / CURRENT_USER** and **DEFINER / INVOKER rights**.
- Provide **sample calls** to show function and procedure outputs.

**Goal:** Demonstrate PL/SQL package development, dynamic SQL, and database security context.

---

## 2. How we Solved It

### Part 1 — AUCA System Access Policy
[Auca System Access Policy](sql/Aucasystemaccesspolicy.sql)
### Part 2 — HR Employee Management system Package
[Employees Table Script](sql/HRemployeemanagementsysystempackage.sql)

### Screenshots
![Table Created of Employee](Screenshots/screenshot1.png)

![Access Denied](Screenshots/screenshot2.png)

![Access Allowed](Screenshots/screenshot3.png)

"# pl-group-work" 
