"""Chat-related request and response schemas."""

from enum import Enum

from pydantic import BaseModel, Field


class InventoryAction(str, Enum):
    """在庫イベントの種別.

    Attributes:
        BUY: 購入イベント
        USE: 使用イベント
        ADJUST: 調整イベント
    """

    BUY = "buy"
    USE = "use"
    ADJUST = "adjust"


class ChatRequest(BaseModel):
    """チャットリクエストスキーマ.

    Attributes:
        message: ユーザからのメッセージ
    """

    message: str = Field(..., min_length=1, description="ユーザからのメッセージ")


class InventoryEvent(BaseModel):
    """在庫イベントスキーマ.

    Attributes:
        item_name: アイテム名
        action: 在庫操作の種別
        quantity: 数量
    """

    item_name: str = Field(..., description="アイテム名")
    action: InventoryAction = Field(..., description="在庫操作の種別")
    quantity: int = Field(..., gt=0, description="数量（正の整数）")


class ChatResponse(BaseModel):
    """チャットレスポンススキーマ.

    Attributes:
        reply: AIからの返答メッセージ
        events: 解析された在庫イベントのリスト
    """

    reply: str = Field(..., description="AIからの返答メッセージ")
    events: list[InventoryEvent] = Field(default_factory=list, description="在庫イベント")
