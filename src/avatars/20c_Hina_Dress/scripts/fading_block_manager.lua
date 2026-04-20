---@class (exact) FadingBlockManager : SpawnObjectManager Exスキル3で使用する消えるブロックを管理するクラス
local FadingBlockManager = {

	---コンストラクタ
	new = function ()
		local instance = MiscUtils.instantiate(FadingBlockManager, SpawnObjectManager)

		instance.managerName = "fading_block"

		return instance
	end;

	---初期化関数
	init = function ()
		local areaModel = models:newPart("script_fading_block_area")
		areaModel:setPos(-8, -15.9, -8)
	end;

	---消えるブロックのインスタンスを生成して返す。
	---@param pos Vector3 ブロックをスポーンさせる座標
	---@param block Minecraft.blockID このブロックの見た目
	---@param blockProperty? string `block`で設定したブロックのプロパティ（あれば）
	---@param lifetime integer このブロックが消えるまでの時間
	---@param shouldShine boolean `lifetime`が0になったときに光って消えるかどうか
	---@param shineTime? integer ブロックが輝く時間
	getObject = function (_, pos, block, blockProperty, lifetime, shouldShine, shineTime)
		return FadingBlock.new(pos, block, blockProperty, lifetime, shouldShine, shineTime)
	end;

	---消えるブロックをスポーンさせる。
	---@param pos Vector3 ブロックをスポーンさせる座標
	---@param block Minecraft.blockID このブロックの見た目
	---@param blockProperty? string `block`で設定したブロックのプロパティ（あれば）
	---@param lifetime integer このブロックが消えるまでの時間
	---@param shouldShine boolean `lifetime`が0になったときに光って消えるかどうか
	---@param shineTime? integer ブロックが輝く時間
	spawn = function (self, pos, block, blockProperty, lifetime, shouldShine, shineTime)
		SpawnObjectManager.spawn(self, pos, block, blockProperty, lifetime, shouldShine, shineTime)
	end;
}

return FadingBlockManager
