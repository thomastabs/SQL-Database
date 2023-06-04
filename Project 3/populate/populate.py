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


    file.close()
