"""Chat API endpoints."""

from fastapi import APIRouter

from app.schemas.chat import ChatRequest, ChatResponse
from app.services.nlp import process_chat_message

router = APIRouter()


@router.post("/", response_model=ChatResponse)
async def chat(request: ChatRequest) -> ChatResponse:
    """チャットメッセージを受け取り、在庫イベントを処理する.

    Args:
        request: チャットリクエスト

    Returns:
        ChatResponse: 処理結果
    """
    return await process_chat_message(request.message)
