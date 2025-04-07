from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from nutrition import analyze_nutrition
import requests

app = FastAPI()

# Configuration CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# Modèle Pydantic pour les requêtes
class NutritionRequest(BaseModel):
    text: str

@app.get("/")
def read_root():
    return {"message": "Bienvenue sur l'API NutriCoach"}

@app.post("/analyze")
async def analyze_nutrition_endpoint(request: NutritionRequest):
    try:
        result = analyze_nutrition(request.text)
        return {
            "calories": result.get("calories", 0),
            "protein": result.get("totalNutrients", {}).get("PROCNT", {}).get("quantity", 0),
            "carbs": result.get("totalNutrients", {}).get("CHOCDF", {}).get("quantity", 0),
            "fat": result.get("totalNutrients", {}).get("FAT", {}).get("quantity", 0)
        }
    except HTTPException as e:
        raise e
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)