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


if __name__ == "__main__":
    file = open('../populate/new_populate.sql', 'w')

    products()
    file.write('\n')

    file.close()
