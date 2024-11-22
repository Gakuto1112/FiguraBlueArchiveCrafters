---@alias BlueArchiveCharacter.RightEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）

---@alias BlueArchiveCharacter.LeftEyeTextures
---| "NORMAL" # 通常
---| "SURPRISED" # 驚いた目（ダメージを受けたときなど）
---| "TIRED" # 疲れた目（死亡アニメーションなど）
---| "CLOSED" # 閉じた目（瞬き、睡眠中など）

---@alias BlueArchiveCharacter.MouthTextures
---| "NORMAL" # 通常

---銃の構え方
---@alias BlueArchiveCharacter.GunHoldType
---| "NORMAL" # バニラの弓やクロスボウの構え方と同じ
---| "CUSTOM" # BBアニメーション"[models.main][gun_hold_right]"と"[models.main][gun_hold_left]"で構え方を定義する

---銃を持っていない場合の銃のモデルの扱い
---@alias BlueArchiveCharacter.GunPutType
---| "BODY" # アバターのBodyに銃を移動させる
---| "HIDDEN" # 銃を隠す

---生徒の配置タイプ
---@alias BlueArchiveCharacter.FormationType
---| "STRIKER" # ストライカー（前衛）
---| "SPECIAL" # スペシャル（後方支援）

--[[ ******************************** ]]

---@class BlueArchiveCharacter キャラクター変数を保持するクラス。別のキャラクターに対してもここを変更するだけで対応できるようにする。
---@field public basic BasicStruct 生徒の基本情報
---@field public faceParts FacePartsStruct 目や口による表情
---@field public arms ArmsStruct 腕
---@field public skirt SkirtStruct スカート
---@field public gun GunStruct 銃
---@field public placementObjects PlacementObjectStruct[] 設置物
---@field public exSkill ExSkillStruct[] Exスキル
---@field public costume CostumeStruct コスチューム
---@field public bubble BubbleStruct 吹き出しエモート
---@field public headBlock HeadBlockStruct 頭ブロック
---@field public portrait HeadBlockStruct ポートレート
---@field public deathAnimation DeathAnimationStruct 死亡アニメーション
---@field public actionWheel ActionWheelStruct アクションホイール
---@field public physics PhysicsStruct 物理演算

--[[ ******************************** ]]

---@class BasicStruct 生徒の基本情報のデータ構造体
---@field public firstName LocaleStringSet 生徒の名前
---@field public lastName LocaleStringSet 生徒の苗字
---@field public clubName LocaleStringSet 生徒が所属している部活名
---@field public birth MonthDaySet 生徒の誕生日

---@class FacePartsStruct 目や口による表情のデータ構造体。UVマッピング情報は、デフォルトパーツから見て左からx番目、上からy番目とする。
---@field public rightEye {[BlueArchiveCharacter.RightEyeTextures]: Vector2} 右目のテクスチャのUVマッピング情報
---@field public leftEye {[BlueArchiveCharacter.LeftEyeTextures]: Vector2} 左目のテクスチャのUVマッピング情報
---@field public mouth {[BlueArchiveCharacter.MouthTextures]: Vector2} 口のテクスチャのUVマッピング情報
---@field public emotionSet? {onDamage: EmotionSet, onSleep: EmotionSet} 特定の状況における表情を上書きする

---@class ArmsStruct 腕のデータ構造体
---@field public callbacks? ArmsCallbacksSet 腕の制御のコールバック関数群

---@class SkirtStruct スカートのデータ構造体
---@field public skirtModels? ModelPart[] スカートとして制御するモデル

---@class GunStruct 銃のデータ構造体
---@field public scale number 銃モデルの大きさの倍率
---@field public gunPosition GunPositionSet 銃モデルの位置や向き
---@field public sound GunSoundSet 銃の射撃音
---@field public callbacks? GunCallbacksSet 銃のコールバック関数

---@class PlacementObjectStruct 設置物のデータ構造体
---@field public model ModelPart 設置物として扱うモデル
---@field public boundingBox PlacementObjectBoundingBoxSet 設置物の当たり判定
---@field public placementMode PlacementObjectManager.PlacementMode 設置物の設置モード
---@field public gravity? number 設置物にかかる重力。1が標準的な自由落下。0で空中静止。負の数で反重力（上に向かって落ちる）。
---@field public hasFireResistance? boolean 設置物に火炎耐性を付与するかどうか。trueにすると炎やマグマで焼かれなくなる。
---@field public callbacks? PlacementObjectCallbacksSet 設置物のコールバック関数

---@class ExSkillStruct Exスキルのデータ構造体
---@field public name LocaleStringSet Exスキルの名前
---@field public formationType BlueArchiveCharacter.FormationType この生徒の戦闘配置タイプ
---@field public models ModelPart[] Exスキルアニメーション開始時に表示し、Exスキルアニメーション終了時に非表示にするモデルパーツ
---@field public animations string[] Exスキルアニメーションが含まれるモデルファイル名。アニメーション名は"ex_skill_<Exスキルのインデックス番号>"にすること。
---@field public camera ExSkillCameraSet Exスキルアニメーション中のカメラワーク
---@field public callbacks? ExSkillCallbacks Exスキルのコールバック関数

---@class CostumeStruct コスチュームのデータ構造体
---@field public costumes CostumeDataSet[] コスチュームデータ
---@field public callbacks? CostumeCallbacks コスチュームのコールバック関数

---@class BubbleStruct 吹き出しエモートのデータ構造体
---@field public callbacks? BubbleCallbacks

---@class HeadBlockStruct 頭ブロック、ポートレートのデータ構造体
---@field public includeModels ModelPart[] 頭モデルに追加でアタッチするモデル
---@field public callbacks? HeadBlockCallbacks 頭ブロック、ポートレートのコールバック関数

---@class DeathAnimationStruct 死亡アニメーションのデータ構造体
---@field public callbacks? DeathAnimationCallbacks 死亡アニメーションのコールバック関数

---@class ActionWheelStruct アクションホイールのデータ構造体
---@field public isVehicleOptionEnabled boolean 乗り物のモデル置き換えオプションを有効にするかどうか

---@class PhysicsStruct 物理演算のデータ構造体
---@field physicData PhysicDataSet[] 物理演算データ
---@field callbacks? PhysicCallbacks 物理演算のコールバック関数

--[[ ******************************** ]]

---@class (exact) OverrideEmotionSet 特定の状況における表情を上書きするセット
---@field public onDamage? EmotionSet ダメージを受けたとき
---@field public onSleep? EmotionSet ベッドで寝ているとき

---@class (exact) EmotionSet 表情のデータセット
---@field public rightEye BlueArchiveCharacter.RightEyeTextures 右目の表情名
---@field public leftEye BlueArchiveCharacter.LeftEyeTextures 左目の表情名
---@field public mouth BlueArchiveCharacter.MouthTextures 口の表情名

---@class (exact) ArmsCallbacksSet 腕処理のコールバック関数のセット
---@field public onArmStateChanged? fun(right: integer, left: integer): {right?: integer, left?: integer}|nil 腕の状態が変更された際のコールバック関数
---@field public onAdditionalRightArmProcess? fun(state: integer) 右腕の追加処理
---@field public onAdditionalLeftArmProcess? fun(state: integer) 左腕の追加処理

---@class (exact) GunPositionSet 銃のモデルの位置や向きのデータセット
---@field public hold GunHoldPositionSet 銃を構えているとき
---@field public put GunPutPositionSet 銃をしまっているとき

---@class (exact) GunHoldPositionSet 構えているときの銃のモデルの位置や向きのデータセット
---@field public type BlueArchiveCharacter.GunHoldType 銃の構え方の種類
---@field public firstPersonPos? Vector3RightLeftSet 一人称視点での銃の位置
---@field public firstPersonRot? Vector3RightLeftSet 一人称視点での銃の方向
---@field public thirdPersonPos? Vector3RightLeftSet 三人称視点での銃の位置
---@field public thirdPersonRot? Vector3RightLeftSet 三人称視点での銃の方向

---@class (exact) GunPutPositionSet しまっているときの銃のモデルの位置や向きのデータセット
---@field public type BlueArchiveCharacter.GunPutType 銃のしまい方の種類
---@field public pos? Vector3RightLeftSet 一人称視点での銃の位置
---@field public rot? Vector3RightLeftSet 一人称視点での銃の方向

---@class (exact) GunSoundSet 銃の音のデータセット
---@field public name Minecraft.soundID 銃の音として使用するゲームの音源名
---@field public pitch number 音源の再生ピッチ（0.5～2）

---@class (exact) GunCallbacksSet 銃のコールバック関数のセット
---@field public onMainHandChange? fun(direction: Gun.HandDirection) 利き手が変更されたときに呼び出される関数

---@class (exact) PlacementObjectBoundingBoxSet 設置物の当たり判定のデータセット
---@field public offsetPos? Vector3 設置物の底の中心点のオフセット位置（任意）。基準点は(0, 0, 0)。
---@field public size? Vector3 当たり判定の大きさ。BlockBenchでのサイズの値をそのまま入力する。基準点はモデルの底面の中心。

--TODO: tableを設置物オブジェクトに置き換える！
---@class (exact) PlacementObjectCallbacksSet 設置物のコールバック関数のセット
---@field public onInit? fun(placementObject: table) 設置物インスタンスが生成された直後に呼ばれる関数
---@field public onDeinit? fun(placementObject: table) 設置物インスタンスが破棄される直前に呼ばれる関数
---@field public onTick? fun(placementObject: table) 各ティック毎に呼ばれる関数
---@field public onRender? fun(placementObject: table) 各レンダーティック毎に呼ばれる関数
---@field public onGround? fun(placementObject: table) 設置物が接地した瞬間に呼ばれる関数

---@class (exact) ExSkillCameraSet Exスキルアニメーション中のカメラワークのセット
---@field public start ExSkillCameraPositionSet Exスキルアニメーション開始地点
---@field public fin ExSkillCameraPositionSet Exスキルアニメーション終了地点

---@class (exact) ExSkillCameraPositionSet Exスキルアニメーション中のカメラワークの開始/終了地点の位置のデータセット
---@field public pos Vector3 カメラの位置
---@field public rot Vector3 カメラの方向

---@class (exact) ExSkillCallbacks Exスキルのコールバック関数のセット
---@field public onPreTransition? fun() Exスキルアニメーション開始前のトランジション開始前に実行されるコールバック関数
---@field public onPreAnimation? fun() Exスキルアニメーション開始前のトランジション終了後に実行されるコールバック関数
---@field public onAnimationTick? fun(tick: integer) Exスキルアニメーション再生中のみ実行されるティック関数
---@field public onPostAnimation? fun(forcedStop: boolean) Exスキルアニメーション終了後のトランジション開始前に実行されるコールバック関数
---@field public onPostTransition? fun(forcedStop: boolean) Exスキルアニメーション終了後のトランジション終了後に実行されるコールバック関数

---@class CostumeDataSet コスチュームのデータセット
---@field public name string コスチュームの内部名
---@field public displayName LocaleStringSet コスチュームの表示名
---@field public exSkill integer コスチュームに対応するExスキルのインデックス番号
---@field public subExSkill? integer コスチュームに対応するサブExスキルのインデックス番号

---@class (exact) CostumeCallbacks コスチュームのコールバック関数のセット
---@field public onChange? fun(costumeId: integer) 衣装が変更されたときに実行されるコールバック関数。デフォルトの衣装はここに含めない。
---@field public onReset? fun() 衣装がリセットされたときに実行されるコールバック関数。あらゆる衣装からデフォルトの衣装へ推移できるようにする。
---@field public onArmorChange? fun(parts: Armor.ArmorPart, isVisible: boolean) 防具が変更された（防具が見える/見えない）ときに実行されるコールバック関数

---@class (exact) BubbleCallbacks 吹き出しエモートのコールバック関数のセット
---@field public onPlay? fun(type: Bubble.BubbleType, duration: integer, showInGui: boolean) 吹き出しエモートが再生された時に実行されるコールバック関数
---@field public  onStop? fun(type: Bubble.BubbleType, forcedStop: boolean) 吹き出しアニメーション終了時に実行されるコールバック関数

---@class (exact) HeadBlockCallbacks 頭ブロックのコールバック関数のセット
---@field public onBeforeModelCopy? fun() モデルのコピー直前に実行される関数
---@field public onAfterModelCopy? fun() モデルのコピー直後に実行される関数

---@class (exact) DeathAnimationCallbacks 死亡アニメーションのコールバック関数のセット
---@field public onPhase1? fun(dummyAvatar: ModelPart, costume: integer) 死亡アニメーションが再生された直後に実行される関数
---@field public onPhase2? fun(dummyAvatar: ModelPart, costume: integer) ダミーアバターが縄ばしごにつかまった直後に実行される関数
---@field public onBeforeModelCopy? fun() モデルのコピー直前に実行される関数
---@field public onAfterModelCopy? fun() モデルのコピー直後に実行される関数

---@class (exact) PhysicDataSet 物理演算のデータセット
---@field public models ModelPart[] 物理演算の対象にするモデルパーツ
---@field public x? PhysicAxisData x軸のデータ
---@field public y? PhysicAxisData y軸のデータ
---@field public z? PhysicAxisData z軸のデータ

---@class (exact) PhysicAxisData 物理演算の1軸のデータセット
---@field public vertical? PhysicCoreData 体が垂直方向である時（通常時）の物理演算データ
---@field public horizontal? PhysicCoreData 体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ

---@class (exact) PhysicCoreData 物理演算のコアデータ
---@field public min number このモデルパーツ、回転軸の絶対的な回転の最小値（度）
---@field public neutral number このモデルパーツ、回転軸の中立の回転位置（度）
---@field public max number このモデルパーツ、回転軸の絶対的な回転の最大値（度）
---@field public sneakOffset? number スニーク時にこのモデルパーツの回転に加えられるオフセット値
---@field public headRotMultiplayer? number 頭の縦方向の回転と共にこのモデルパーツの回転に加えられる値の倍率
---@field public headX? PhysicFactorData 頭を基準とした、前後方向移動によるモデルパーツの回転データ
---@field public headZ PhysicFactorData 頭を基準とした、左右方向移動によるモデルパーツの回転データ
---@field public headRot PhysicFactorData 頭の回転によるによるモデルパーツの回転データ
---@field public bodyX PhysicFactorData 体を基準とした、前後方向移動によるモデルパーツの回転データ
---@field public bodyY PhysicFactorData 体を基準とした、上下方向移動によるモデルパーツの回転データ
---@field public bodyZ PhysicFactorData 体を基準とした、左右方向移動によるモデルパーツの回転データ
---@field public bodyRot PhysicFactorData 体の回転によるによるモデルパーツの回転データ

---@class (exact) PhysicFactorData 物理演算を働かせる要因を定義するデータセット
---@field public multiplayer number この回転事象がモデルパーツに与える回転の倍率
---@field public min number この回転事象がモデルパーツに与える回転の最小値
---@field public max number この回転事象がモデルパーツに与える回転の最大値

---@class (exact) PhysicCallbacks 物理演算のコールバック関数のセット
---@field public onPhysicPerformed? fun(model: ModelPart) 物理演算処理後に実行されるコールバック関数（省略可）。ここでモデルパーツの向きを上書きできる。

--[[ ******************************** ]]

---@class (exact) LocaleStringSet ロケール文字列のセット
---@field public en_us string 英語（米国）
---@field public ja_jp string 日本語

---@class (exact) MonthDaySet 日月のデータセット
---@field public month integer 月
---@field public day integer 日

---@class (exact) Vector3RightLeftSet 左右で別々にVector3が定義できるデータセット
---@field public right? Vector3 右
---@field public left? Vector3 左

BlueArchiveCharacter = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return BlueArchiveCharacter
    new = function (parent)
        ---@type BlueArchiveCharacter
        local instance = Avatar.instantiate(BlueArchiveCharacter, AvatarModule, parent)

        instance.basic = {
            firstName = {
                en_us = "FirstName";
                ja_jp = "名前";
            };

            lastName = {
                en_us = "LastName";
                ja_jp = "苗字";
            };

            clubName = {
                en_us = "ClubName";
                ja_jp = "部活名";
            };

            birth = {
                month = 1;
                day = 1;
            };
        }

        instance.faceParts = {
            rightEye = {
                NORMAL = vectors.vec2(0, 0); --必須
                SURPRISED = vectors.vec2(1, 0); --必須
                TIRED = vectors.vec2(2, 0); --必須
                CLOSED = vectors.vec2(3, 0); --必須
            };

            leftEye = {
                NORMAL = vectors.vec2(0, 0); --必須
                SURPRISED = vectors.vec2(1, 0); --必須
                TIRED = vectors.vec2(2, 0); --必須
                CLOSED = vectors.vec2(3, 0); --必須
            };

            mouth = {
            };

            --[[
            emotionSet = {
                ---ダメージを受けたとき
                onDamage = {
                    rightEye = "SURPRISED";
                    leftEye = "SURPRISED";
                    mouth = "NORMAL";
                };

                ---ベッドで寝ているとき
                onSleep = {
                    rightEye = "CLOSED";
                    leftEye = "CLOSED";
                    mouth = "NORMAL";
                };
            };
            ]]
        }

        instance.arms = {
            --[[
            callbacks = {
                ---腕の状態が変更された際のコールバック関数
                ---@param right integer 新しい右腕の状態
                ---@param left integer 新しい左腕の状態
                ---@return {right?: integer, left?: integer}|nil overriddenArmState 返した値で腕の状態を上書きできる。
                onArmStateChanged = function (right, left)
                end;

                ---右腕の追加処理
                ---@param state integer 新しい右腕の状態
                onAdditionalRightArmProcess = function (state)

                end;

                ---左腕の追加処理
                ---@param state integer 新しい左腕の状態
                onAdditionalLeftArmProcess = function (state)
                end;
            };
            ]]
        }

        instance.skirt = {
            --[[
            skirtModels = {};
            ]]
        }

        instance.gun = {
            scale = 1.2;

            gunPosition = {
                hold = {
                    type = "NORMAL";

                    --[[
                    firstPersonPos = {
                        right = vectors.vec3();
                        left = vectors.vec3();
                    };
                    ]]

                    --[[
                    firstPersonRot = {
                        right = vectors.vec3();
                        left = vectors.vec3();
                    };
                    ]]

                    --[[
                    thirdPersonPos = {
                        right = vectors.vec3();
                        left = vectors.vec3();
                    };
                    ]]

                    --[[
                    thirdPersonRot = {
                        right = vectors.vec3();
                        left = vectors.vec3();
                    };
                    ]]
                };

                put = {
                    type = "BODY";

                    --[[
                    pos = {
                        right = vectors.vec3();
                        left = vectors.vec3();
                    };
                    ]]

                    --[[
                    put = {
                        right = vectors.vec3();
                        left = vectors.vec3();
                    };
                    ]]
                };
            };

            sound = {
                name = "minecraft:entity.iron_golem.hurt";
                pitch = 2;
            };

            --[[
            callbacks = {
                ---利き手が変更された時に呼び出される関数。
                ---利き手に応じた銃やアクセサリーの変更に利用できる。
                ---@param direction Gun.HandDirection 新たな利き手
                onMainHandChange = function (direction)
                end;
            };
            ]]
        }

        instance.placementObjects = {
            {
                model = models.models.placement_object.PlacementObject;

                boundingBox = {
                    size = vectors.vec3(8, 8, 8)
                };

                placementMode = "COPY";
            };
        }

        instance.exSkill = {
            {
                name = {
                    en_us = "Ex Skill name";
                    ja_jp = "Exスキル名";
                };

                formationType = "STRIKER";

                models = {};

                animations = {"main"};

                camera = {
                    start = {
                        rot = vectors.vec3(0, 180, 0);
                        pos = vectors.vec3(0, 28, -64);
                    };

                    fin = {
                        rot = vectors.vec3(0, 180, 0);
                        pos = vectors.vec3(0, 28, -64);
                    };
                };

                callbacks = {
                    --[[
                    --Exスキルアニメーションを任意のティックで停止させるスニペット。デバッグ用。
                    --"<>"内を適切な値で置換すること。
                    if tick == <tick_int> then
                        for _, animation in ipairs(BlueArchiveCharacter.EX_SKILL[<ex_skill_index>].animations) do
                            animations["models."..animation]["ex_skill_<ex_skill_index>""]:pause()
                        end
                    end
                    ]]
                }
            };
        }

        instance.costume = {
            costumes = {
                {
                    name = "default";

                    displayName = {
                        en_us = "Default";
                        ja_jp = "デフォルト";
                    };

                    exSkill = 1;
                };
            };

        }

        instance.bubble = {

        }

        instance.headBlock = {
            includeModels = {};
        }

        instance.portrait = {
            includeModels = {};
        }

        instance.deathAnimation = {

        }

        instance.actionWheel = {
            isVehicleOptionEnabled = false;
        }

        instance.physics = {
            physicData = {

            };
        }

        --生徒固有初期化処理
        --Player APIにアクセスする場合は、ENTITY_INIT後に実行されるようにする必要がある。

        return instance
    end;
}