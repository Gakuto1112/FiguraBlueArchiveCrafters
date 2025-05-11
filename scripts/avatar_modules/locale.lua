---@alias Locale.Language
---| "en_us" # 英語（米国）
---| "ja_jp" # 日本語

---@class (exact) Locale : AvatarModule アバターの表示言語を管理するクラス
---@field public localeData {[Locale.Language]: {[string]: string}} 言語データ
---@field public getLocale fun(self: Locale, key: string): string 翻訳キーに対する訳文を返す。設定言語が存在しない場合は英語の文が返される。また、指定したキーの訳が無い場合は英語->キーそのままが返される。

Locale = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return Locale
    new = function (parent)
        ---@type Locale
        local instance = Avatar.instantiate(Locale, AvatarModule, parent)

		instance.localeData = {
			en_us = {};
			ja_jp = {};
		}

		---言語データのリスト
		---1. キー名, 2. 英語（米国）, 3. 日本語
		local localeStrings = {
			{"avatar.old_version_warning", "For the best experience, playing with 1.21.4 or higher is recommended!", "生徒さんとより良い時間を過ごすためにバージョン1.21.4以上でのプレイをおすすめします！"};
			{"avatar.zombies_mode.enable", "Enabled Zombies mode.", "Zombiesモードを有効にしました。"};
			{"avatar.zombies_mode.already_enabled", "Already enabled Zombies mode.", "Zombiesモードは既に有効化されています。"};
			{"avatar.zombies_mode.disable", "Disabled Zombies mode.", "Zombiesモードを無効にしました。"};
			{"avatar.zombies_mode.already_disabled", "Already disabled Zombies mode.", "Zombiesモードは既に無効化されています。"};
			{"action_wheel.toggle_off", "off", "オフ"};
			{"action_wheel.toggle_on", "on", "オン"};
			{"action_wheel.main.action_1.title", "Change costume: ", "衣装を変更："};
			{"action_wheel.main.action_1.unavailable", "There is no costume available.", "利用可能な衣装はありません。"};
			{"action_wheel.main.action_1.done_first", "Changed costume to §b", "衣装を§b"};
			{"action_wheel.main.action_1.done_last", "§r.", "§rに変更しました。"};
			{"action_wheel.main.action_2.title", "Change display name: ", "表示名を変更："};
			{"action_wheel.main.action_2.title_2", "Show club name: ", "部活名を表示："};
			{"action_wheel.main.action_2.done_first", "Changed display name to §b", "表示名を§b"};
			{"action_wheel.main.action_2.done_last", "§r.", "§rに変更しました。"};
			{"action_wheel.main.action_3.title", "Show armors: ", "防具を表示："};
			{"action_wheel.main.action_4.title", "Show weapon models in first person: ", "一人称視点で武器モデルを表示："};
			{"action_wheel.main.action_5.title", "Amount of particles in Ex skill frame: ", "Exスキルフレームのパーティクルの量："};
			{"action_wheel.main.action_5.option_1", "Standard", "標準"};
			{"action_wheel.main.action_5.option_2", "Minimum", "少なめ"};
			{"action_wheel.main.action_5.option_3", "None", "なし"};
			{"action_wheel.main.action_5.option_4", "Hide Ex skill frame", "スキルフレーム非表示"};
			{"action_wheel.main.action_5.done_first", "Changed amount of particles in Ex skill frame to§b", "Exスキルフレームのパーティクルの量を§b"};
			{"action_wheel.main.action_5.done_last", "§r.", "§rに変更しました。"};
			{"action_wheel.main.action_6.title", "Replace vehicle models: ", "乗り物のモデルを置き換え："};
			{"action_wheel.main.action_6.unavailable", "This option is unavailable for this character.", "この生徒さんでは利用できません。"};
			{"action_wheel.main.action_7.title", "FPM compatibility mode: ", "FPM互換モード："};
			{"action_wheel.main.action_7.message", "When enabling First-person Model compatibility mode, avatar's head may not be rendered in some environments.", "First-person Model互換モードを有効にすると一部環境下で頭が描画されない場合があります。"};
			{"action_wheel.main.action_8.title_1", "Check for new FBAC Updates ", "FBACアップデートの確認"};
			{"action_wheel.main.action_8.title_2", "(Left-click)", "（左クリック）"};
			{"action_wheel.main.action_8.title_3", "Copy URL for the latest FBAC ", "最新FBACバージョンのURLをコピー"};
			{"action_wheel.main.action_8.title_4", "(Right-click)", "（右クリック）"};
			{"action_wheel.main.action_8.networking_api", "To enable update checking, you need to allow Figura's Networking and put \"api.github.com\" in the Network Filter from Figura settings!", "アップデート確認機能を有効にするにはFiguraの設定より、FiguraのNetworkingの使用を許可し、\"api.github.com\"を許可リストに入れる必要があります！"};
			{"action_wheel.main.action_8.ongoing", "Checking for updates is ongoing. Please DO NOT click repeatedly!", "現在アップデートの確認中です。連打しないでください！"};
			{"action_wheel.main.action_8.copied", "Coped the link to the latest FBAC to your clipboard. Please open the link in your browser.", "最新のFBACへのリンクをクリップボードにコピーしました。ブラウザでリンクを開いてください。"};
			{"action_wheel.main.action_8.cannot_check_latest", "Cannot get the link because cannot check the latest FBAC.", "FBACの最新バージョンを確認できないため、リンクを取得できません。"};
			{"action_wheel.gui.bubble_guide.title", "§0Bubble emote guide", "§0吹き出しエモートガイド"};
			{"action_wheel.gui.ex_skill_guide.title", "§0Ex skill guide", "§0Exスキルガイド"};
			{"action_wheel.gui.ex_skill_guide.key_pre", "Press \"", "\""};
			{"action_wheel.gui.ex_skill_guide.key_post", "\"key to play", "\"キーで再生"};
			{"action_wheel.gui.update_check.checking", "Checking for updates...", "アップデートを確認中..."};
			{"action_wheel.gui.update_check.latest", "No FBAC update available", "最新のFBACを使用中です"};
			{"action_wheel.gui.update_check.update_available", "New FBAC update is available: ", "FBACのアップデートが利用可能です："};
			{"action_wheel.gui.update_check.error_not_allowed", "Failed to check for updates - Networking API not allowed", "アップデート確認失敗 - ネットワーキング機能が不許可"};
			{"action_wheel.gui.update_check.error_network_err", "Failed to check for updates - Network error", "アップデート確認失敗 - ネットワークエラー"};
			{"action_wheel.gui.update_check.error_request_failed", "Failed to check for updates - Request failure ", "アップデート確認失敗 - リクエスト失敗 "};
			{"action_wheel.gui.update_check.error_invalid_json_syntax", "Failed to check for updates - Json parsing failure", "アップデート確認失敗 - リクエスト解析失敗"};
			{"action_wheel.gui.update_check.error_invalid_json", "Failed to check for updates - Unexpected Request", "アップデート確認失敗 - 予期しないリクエスト"};
			{"key_name.ex_skill", "Ex Skill", "Exスキル"};
			{"key_name.ex_skill_sub", "Sub Ex Skill", "サブExスキル"};
			{"key_name.bubble_1", "Bubble: Good", "吹き出し：いいね"};
			{"key_name.bubble_2", "Bubble: Heart", "吹き出し：ハート"};
			{"key_name.bubble_3", "Bubble: Note", "吹き出し：音符"};
			{"key_name.bubble_4", "Bubble: Question", "吹き出し：はてな"};
			{"key_name.bubble_5", "Bubble: Sweat", "吹き出し：汗"};
			{"key_bind.ex_skill.unavailable", "You cannot do this now.", "今は再生できません。"};
			{"key_bind.ex_skill.unavailable_firstperson", "You cannot do this in first person perspective.", "一人称視点では再生できません。"};
		}

		for _, localeSet in ipairs(localeStrings) do
			instance.localeData.en_us[localeSet[1]] = localeSet[2]
			instance.localeData.ja_jp[localeSet[1]] = localeSet[3]
		end

        return instance
    end;

    ---初期化関数
    ---@param self Locale
    init = function (self)
		AvatarModule.init(self)

		self.localeData.en_us["nameplate.club_name"] = self.parent.characterData.basic.clubName.en_us
		self.localeData.ja_jp["nameplate.club_name"] = self.parent.characterData.basic.clubName.ja_jp

		if host:isHost() then
			for index, exSkill in ipairs(self.parent.characterData.exSkill.exSkills) do
				self.localeData.en_us["action_wheel.gui.ex_skill_guide.ex_skill_"..index..".name"] = exSkill.name.en_us
				self.localeData.ja_jp["action_wheel.gui.ex_skill_guide.ex_skill_"..index..".name"] = exSkill.name.ja_jp
			end
			for _, costume in ipairs(self.parent.characterData.costume.costumes) do
				self.localeData.en_us["costume."..costume.name] = costume.displayName.en_us
				self.localeData.ja_jp["costume."..costume.name] = costume.displayName.ja_jp
			end
		end
    end;

	---翻訳キーに対する訳文を返す。設定言語が存在しない場合は英語の文が返される。また、指定したキーの訳が無い場合は英語->キーそのままが返される。
	---@param self Locale
	---@param key string 翻訳キー
	---@return string translatedString 翻訳キーに対する翻訳データ。設定言語での翻訳が存在しない場合は英文が返される。英文すら存在しない場合は翻訳キーがそのまま返される。
	getLocale = function (self, key)
		local activeLanguage = client:getActiveLang()
		return (self.localeData[activeLanguage] ~= nil and self.localeData[activeLanguage][key] ~= nil) and self.localeData[activeLanguage][key] or (self.localeData.en_us[key] and self.localeData.en_us[key] or key)
	end;
}