extends Electronic
class_name Generator
# Generators convert a fuel source into electricty.


# Percentage of total capacity this generator is working at. At 0% capacity,
# the generator is off.
export(float, 0, 100) var operating_capacity := 0
