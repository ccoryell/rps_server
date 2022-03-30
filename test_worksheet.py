from worksheet import Worksheet

def test_is_empty():
    worksheet = Worksheet()
    assert worksheet.is_empty == True

    worksheet.store_value(1, "A", "1")
    assert worksheet.is_empty == False

    worksheet.delete_value(1, "A")
    assert worksheet.is_empty == True

def test_read_value():
    worksheet = Worksheet()
    worksheet.store_value(1, "A", "1")
    worksheet.store_value(1, "B", "2")

    assert worksheet.read_value(1, "A") == "1"
    assert worksheet.read_value(1, "B") == "2"