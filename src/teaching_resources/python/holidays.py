# Store in holidays.py file
import requests
from datetime import datetime

def is_tradable() -> bool:
    """Function returns True if trades can execute on that day."""
    today = datetime.today()
    return (0 <= today.weekday() < 5)  # keep it simple, return True if weekday.

def get_holidays() -> dict | None:
    """Get holidays in a year"""
    r = requests.get("http://some_api/holidays")
    if r.status_code == 200:
        return r.json()
    return None