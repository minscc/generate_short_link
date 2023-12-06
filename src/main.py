from fastapi import APIRouter, FastAPI, Depends
from starlette.responses import PlainTextResponse

from src.controllers import ROUTERS
from src.modules.database import AsyncSessionDepends
from src.services.request_service import RequestService

router = APIRouter()


@router.get("/", response_model=None)
async def hello(
    request: RequestService = Depends(),
):
    return PlainTextResponse(
        f"{request.base_url}\n"
        f"{request.user_agent}\n"
        f"{request.ip_address}\n"
        f"{request.browser}\n"
        f"{request.device}\n"
        f"{request.os}\n"
    )


app = FastAPI()
app.include_router(router)
for _router in ROUTERS:
    app.include_router(_router)
