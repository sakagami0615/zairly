"""Natural language processing service for chat messages."""

from app.schemas.chat import ChatResponse, InventoryAction, InventoryEvent


async def process_chat_message(message: str) -> ChatResponse:
    """チャットメッセージを処理し、在庫イベントを抽出する.

    TODO: LLMを使用した自然言語解析を実装
    現在はダミー実装

    Args:
        message: ユーザからのチャットメッセージ

    Returns:
        ChatResponse: 処理結果（返答メッセージと在庫イベント）
    """
    # TODO: LLM integration
    # 現在はダミーレスポンスを返す
    return ChatResponse(
        reply=f"メッセージを受け取りました: {message}",
        events=[
            InventoryEvent(
                item_name="サンプルアイテム",
                action=InventoryAction.BUY,
                quantity=1,
            )
        ],
    )
