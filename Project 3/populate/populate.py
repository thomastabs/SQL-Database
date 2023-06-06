# Script de Python para fazer o populate
def copia_anexo_a():
    for line in open("anexo_a.sql"):
        file.write(line)


def customers():
    for line in open("customers.csv", "r"):
        customer = line.strip().split(",")
        ins = "INSERT INTO customer VALUES ('{}', '{}', '{}', '{}', '{}');\n".format(customer[0], customer[1],
                                                                                     customer[2], customer[3],
                                                                                     customer[4])
        file.write(ins)


def products():
    for line in open("products.csv", "r"):
        product = line.strip().split(",")
        # Se tem produto ean
        if len(product) == 5:
            ins = "INSERT INTO product VALUES ('{}', '{}', '{}', '{}', '{}');\n".format(product[0], product[1],
                                                                                        product[2], product[3],
                                                                                        product[4])
            file.write(ins)
        # Se tem produto normal
        if len(product) == 4:
            ins = "INSERT INTO product VALUES ('{}', '{}', '{}', '{}');\n".format(product[0], product[1],
                                                                                  product[2], product[3])
            file.write(ins)


def orders():
    for line in open("orders.csv", "r"):
        order = line.strip().split(",")
        ins = "INSERT INTO orders VALUES ('{}', '{}', '{}');\n".format(order[0], order[1], order[2])
        file.write(ins)


def employees():
    for line in open("employees.csv", "r"):
        employee = line.strip().split(",")
        ins = "INSERT INTO employee VALUES ('{}', '{}', '{}', '{}');\n".format(employee[0], employee[1],
                                                                               employee[2], employee[3])
        file.write(ins)


def process():
    for line in open("process.csv", "r"):
        process = line.strip().split(",")
        ins = "INSERT INTO process VALUES ('{}', '{}');\n".format(process[0], process[1])
        file.write(ins)


def workplaces():
    for line in open("workplaces.csv", "r"):
        workplace = line.strip().split(",")
        ins = "INSERT INTO workplace VALUES ('{}', '{}', '{}');\n".format(workplace[0], workplace[1], workplace[2])
        file.write(ins)


def departments():
    for line in open("departments.csv", "r"):
        department = line.strip().split(",")
        ins = "INSERT INTO department VALUES ('{}');\n".format(department[0])
        file.write(ins)


def offices():
    for line in open("offices.csv", "r"):
        office = line.strip().split(",")
        ins = "INSERT INTO office VALUES ('{}');\n".format(office[0])
        file.write(ins)


def warehouses():
    for line in open("warehouses.csv", "r"):
        warehouse = line.strip().split(",")
        ins = "INSERT INTO warehouse VALUES ('{}');\n".format(warehouse[0])
        file.write(ins)


def works():
    for line in open("works.csv", "r"):
        works_in = line.strip().split(",")
        ins = "INSERT INTO works VALUES ('{}','{}','{}');\n".format(works_in[0], works_in[1], works_in[2])
        file.write(ins)


def suppliers():
    for line in open("suppliers.csv", "r"):
        supplier = line.strip().split(",")
        ins = "INSERT INTO supplier VALUES ('{}','{}','{}');\n".format(supplier[0], supplier[1], supplier[2])
        file.write(ins)


def deliveries():
    for line in open("deliveries.csv", "r"):
        delivery = line.strip().split(",")
        ins = "INSERT INTO delivery VALUES ('{}','{}');\n".format(delivery[0], delivery[1])
        file.write(ins)


def contains():
    for line in open("contains.csv", "r"):
        contains_in = line.strip().split(",")
        ins = "INSERT INTO contains VALUES ('{}','{}','{}');\n".format(contains_in[0], contains_in[1], contains_in[2])
        file.write(ins)


def pays():
    for line in open("pays.csv", "r"):
        pays_for = line.strip().split(",")
        ins = "INSERT INTO pay VALUES ('{}','{}');\n".format(pays_for[0], pays_for[1])
        file.write(ins)


if __name__ == "__main__":
    file = open('../populate/populate.sql', 'w')

    copia_anexo_a()
    file.write('\n')
    products()
    file.write('\n')
    customers()
    file.write('\n')

    file.write('START TRANSACTION;\n')
    file.write('SET CONSTRAINTS ALL DEFERRED;\n')
    file.write('\n')

    orders()
    file.write('\n')
    contains()
    file.write('\n')

    file.write("COMMIT;\n")
    file.write('\n')

    employees()
    file.write('\n')
    process()
    file.write('\n')
    departments()
    file.write('\n')
    workplaces()
    file.write('\n')
    warehouses()
    file.write('\n')
    offices()
    file.write('\n')
    works()
    file.write('\n')
    suppliers()
    file.write('\n')
    deliveries()
    file.write('\n')
    pays()
    file.write('\n')

    file.close()
