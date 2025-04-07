import requests
from fastapi import HTTPException

EDAMAM_APP_ID = "8c13c88c"  # Remplacez par votre ID d'application Edamam
EDAMAM_APP_KEY = "bea36ae6b4371ff35dc06c63ac29a896"  # Remplacez par votre clé d'application Edamam

def analyze_nutrition(text: str):
    url = f"https://api.edamam.com/api/nutrition-details"
    headers = {
        "Content-Type": "application/json"
    }
    payload = {
        "ingr": [text]
    }
    response = requests.post(url, json=payload, headers=headers, params={
        "app_id": EDAMAM_APP_ID,
        "app_key": EDAMAM_APP_KEY
    })

    if response.status_code != 200:
        raise HTTPException(status_code=response.status_code, detail="Erreur lors de l'analyse nutritionnelle")

    return response.json()