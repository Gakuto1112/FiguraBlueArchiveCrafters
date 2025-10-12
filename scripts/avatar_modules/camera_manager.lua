---@class (exact) CameraManager : AvatarModule カメラ制御全般を管理するクラス
---@field package COLLISION_DENIAL_DISABLED boolean カメラの当たり判定打ち消し機能を無効にする。撮影用。
---@field package thirdPersonCameraDistance number 三人称視点でのカメラと回転軸の距離
---@field package isCameraCollisionDenialEnabled boolean 三人称視点でのカメラの当たり判定打ち消し機能が有効かどうか
---@field public setCameraManagerRender fun(self: CameraManager, enabled: boolean) CameraManagerのレンダー関数を設定する
---@field public setCameraPivot fun(newPivot?: Vector3) カメラの回転軸のオフセット位置を変更する
---@field public setCameraRot fun(newRot?: Vector3) カメラ方向を変更する
---@field public setThirdPersonCameraDistance fun(self: CameraManager, distance: number) 三人称視点でのカメラと回転軸の距離を設定する
---@field public setCameraCollisionDenial fun(self: CameraManager, enabled: boolean) カメラの当たり判定打ち消し機能を設定する

CameraManager = {
    ---コンストラクタ
    ---@param parent Avatar アバターのメインクラスへの参照
    ---@return CameraManager
    new = function (parent)
        ---@type CameraManager
        local instance = Avatar.instantiate(CameraManager, AvatarModule, parent)

        instance.COLLISION_DENIAL_DISABLED = false
        instance.thirdPersonCameraDistance = 4
        instance.isCameraCollisionDenialEnabled = false

        return instance
    end;

    ---CameraManagerのレンダー関数を設定する。
    ---@param self CameraManager
    ---@param enabled boolean CameraManagerのレンダー関数を有効化するかどうか
    setCameraManagerRender = function (self, enabled)
        if enabled and events.RENDER:getRegisteredCount("camera_manager_render") == 0 then
            events.RENDER:register(function ()
                if renderer:isFirstPerson() then
                    renderer:setCameraPos()
                else
                    local rawOffsetCameraPivot = renderer:getCameraOffsetPivot()
                    rawOffsetCameraPivot = rawOffsetCameraPivot == nil and vectors.vec3() or rawOffsetCameraPivot
                    local cameraPivot = player:getPos():add(0, 1.62, 0):add(rawOffsetCameraPivot)
                    local cameraDir = client:getCameraDir()
                    local baseVector = vectors.rotateAroundAxis(math.deg(math.asin(cameraDir.y)), 0, 0.15, 0, vectors.rotateAroundAxis(math.deg(math.atan2(cameraDir.z, cameraDir.x)) * -1 - 90, 1, 0, 0, 0, 1, 0))
                    local minDistance = math.max(self.thirdPersonCameraDistance, 4)
                    if not self.COLLISION_DENIAL_DISABLED then
                        for i = 0, 3 do
                            local startPos = vectors.rotateAroundAxis(i * 90 + 45, baseVector:copy(), cameraDir):add(cameraPivot)
                            local _, collisionPos, _ = raycast:block(startPos, startPos:copy():add(cameraDir:copy():scale(-4)), "VISUAL", "NONE")
                            minDistance = math.min(collisionPos:copy():sub(startPos):length(), minDistance)
                        end
                    end
                    renderer:setCameraPos(0, 0, (minDistance > self.thirdPersonCameraDistance or self.isCameraCollisionDenialEnabled) and self.thirdPersonCameraDistance - minDistance or 0)
                end
            end, "camera_manager_render")
        elseif not enabled then
            events.RENDER:remove("camera_manager_render")
            renderer:setCameraPos()
        end
    end;

    ---カメラの回転軸のオフセット位置を変更する。
    ---@param newPivot? Vector3 設定する新しいカメラ回転軸のオフセット位置。nilの場合は設定値がリセットされる。
    setCameraPivot = function (newPivot)
        if host:isHost() then
            renderer:setOffsetCameraPivot(newPivot)
        end
    end;

    ---カメラ方向を変更する。
    ---@param newRot? Vector3 設定する新しいカメラのオフセット方向。nilの場合は設定値がリセットされる。
    setCameraRot = function (newRot)
        if host:isHost() then
            renderer:setCameraRot(newRot)
        end
    end;

    ---三人称視点でのカメラと回転軸の距離を設定する。
    ---@param self CameraManager
    ---@param distance number 設定する新しい距離（ブロック単位）。デフォルトは4ブロック。
    setThirdPersonCameraDistance = function (self, distance)
        if host:isHost() then
            if distance ~= 4 then
                self:setCameraManagerRender(true)
            elseif not self.isCameraCollisionDenialEnabled then
                self:setCameraManagerRender(false)
            end
            self.thirdPersonCameraDistance = distance
        end
    end;

    ---カメラの当たり判定打ち消し機能を設定する。
    ---@param enabled boolean カメラの当たり判定打ち消し機能を有効にするかどうか。有効にするとカメラがブロックの中にめり込むようになる。
    setCameraCollisionDenial = function (self, enabled)
        if host:isHost() then
            if enabled then
                self:setCameraManagerRender(true)
            elseif self.thirdPersonCameraDistance == 4 then
                self:setCameraManagerRender(false)
            end
            self.isCameraCollisionDenialEnabled = enabled
        end
    end;
}