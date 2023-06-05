def customers():
    for line in open("customers.csv", "r"):
        customer = line.strip().split(",")
        ins = "INSERT INTO customer VALUES ('{}', '{}', '{}', '{}');\n".format(customer[0], customer[1],
                                                                               customer[2], customer[3])
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
        ins = "INSERT INTO employee VALUES ('{}', '{}');\n".format(process[0], process[1])
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


def

if __name__ == "__main__":
    file = open('../populate/populate.sql', 'w')

    products()
    file.write('\n')
    customers()
    file.write('\n')
    orders()
    file.write('\n')
    employees()
    file.write('\n')
    process()
    file.write('\n')
    workplaces()
    file.write('\n')

    file.close()
