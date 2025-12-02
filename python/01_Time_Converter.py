# Question 1: Convert minutes to human readable form

def convert_minutes(num_minutes):
    hours = num_minutes // 60
    minutes = num_minutes % 60

    if hours == 1:
        hr_str = "hr"
    else:
        hr_str = "hrs"

    print(f"{num_minutes} becomes \"{hours} {hr_str} {minutes} minutes\"")


convert_minutes(130)
convert_minutes(110)
