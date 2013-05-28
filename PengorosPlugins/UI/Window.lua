import "Turbine.UI";

Window = class(Turbine.UI.Window);

-- Deprecated, this class should go away :)

-- colors
Window.TitleColor = Turbine.UI.Color(245/255, 222/255, 147/255);

function Window:Constructor()
    Turbine.UI.Window.Constructor(self);
    
    -- hidden window to get the movement arrows
    self.hidden = Turbine.UI.Lotro.Window();
    self.hidden:SetOpacity(0);
    self.hidden.PositionChanged = function(sender, args)
        PengorosPlugins.Utils.ExecuteListener(self, "PositionChanged", args);
    end
    
    self.titleWidth = 250;
    self:SetParent(self.hidden);
    self:SetMouseVisible(false);
    Turbine.UI.Window.SetPosition(self, 0, 0);

    -- title label
    self.title = Turbine.UI.Label();
    self.title:SetParent(self);
    self.title:SetPosition(0, 0);
    self.title:SetSize(0, 20);
    self.title:SetOutlineColor(Turbine.UI.Color(1, 0, 0, 0));
    self.title:SetFontStyle(Turbine.UI.FontStyle.Outline);
    self.title:SetFont(Turbine.UI.Lotro.Font.TrajanPro18);
    self.title:SetForeColor(Window.TitleColor);
    self.title:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self.title:SetMouseVisible(false);
    self.title:SetZOrder(5);

    -- top left corner
    self.topLeft = Turbine.UI.Control();
    self.topLeft:SetParent(self);
    self.topLeft:SetSize(36, 36);
    self.topLeft:SetMouseVisible(false);
    self.topLeft:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.topLeft:SetBackground("PengorosPlugins/UI/Resources/box_silver_top_left.tga");

    -- topRight
    self.topRight = Turbine.UI.Control();
    self.topRight:SetParent(self);
    self.topRight:SetSize(36, 36);
    self.topRight:SetMouseVisible(false);
    self.topRight:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.topRight:SetBackground("PengorosPlugins/UI/Resources/box_silver_top_right.tga");
    
    -- bottomLeft
    self.bottomLeft = Turbine.UI.Control();
    self.bottomLeft:SetParent(self);
    self.bottomLeft:SetSize(36, 36);
    self.bottomLeft:SetMouseVisible(false);
    self.bottomLeft:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.bottomLeft:SetBackground("PengorosPlugins/UI/Resources/box_silver_bottom_left.tga");

    -- bottomRight
    self.bottomRight = Turbine.UI.Control();
    self.bottomRight:SetParent(self);
    self.bottomRight:SetSize(36, 36);
    self.bottomRight:SetMouseVisible(false);
    self.bottomRight:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.bottomRight:SetBackground("PengorosPlugins/UI/Resources/box_silver_bottom_right.tga");

    -- top side
    self.top = Turbine.UI.Control();
    self.top:SetParent(self);
    self.top:SetSize(36, 36);
    self.top:SetMouseVisible(false);
    self.top:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.top:SetBackground("PengorosPlugins/UI/Resources/box_silver_top.tga");

    -- left side
    self.left = Turbine.UI.Control();
    self.left:SetParent(self);
    self.left:SetSize(36, 36);
    self.left:SetMouseVisible(false);
    self.left:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.left:SetBackground("PengorosPlugins/UI/Resources/box_silver_left.tga");

    -- right side
    self.right = Turbine.UI.Control();
    self.right:SetParent(self);
    self.right:SetSize(36, 36);
    self.right:SetMouseVisible(false);
    self.right:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.right:SetBackground("PengorosPlugins/UI/Resources/box_silver_right.tga");
    
    -- bottom side
    self.bottom = Turbine.UI.Control();
    self.bottom:SetParent(self);
    self.bottom:SetSize(36, 36);
    self.bottom:SetMouseVisible(false);
    self.bottom:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.bottom:SetBackground("PengorosPlugins/UI/Resources/box_silver_bottom.tga");
    
    -- center
    self.center = Turbine.UI.Control();
    self.center:SetParent(self);
    --self.center:SetMouseVisible(false);
    self.center:SetBackColor(Turbine.UI.Color(.925, 0, 0, 0));
    --self.center:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    --self.center:SetBackground("PengorosPlugins/UI/Resources/base_box_center_silver.tga");
    
    -- title left
    self.titleLeft = Turbine.UI.Control();
    self.titleLeft:SetParent(self);
    self.titleLeft:SetSize(35, 42);
    self.titleLeft:SetMouseVisible(false);
    self.titleLeft:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.titleLeft:SetBackground("PengorosPlugins/UI/Resources/base_box_titlebar_left.tga");

    -- title mid
    self.titleMid = Turbine.UI.Control();
    self.titleMid:SetParent(self);
    self.titleMid:SetSize(20, 42);
    self.titleMid:SetMouseVisible(false);
    self.titleMid:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.titleMid:SetBackground("PengorosPlugins/UI/Resources/base_box_titlebar_top.tga");
    
    -- title right
    self.titleRight = Turbine.UI.Control();
    self.titleRight:SetParent(self);
    self.titleRight:SetSize(35, 42);
    self.titleRight:SetMouseVisible(false);
    self.titleRight:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.titleRight:SetBackground("PengorosPlugins/UI/Resources/base_box_titlebar_right.tga");
    
    -- close button
    self.close = Turbine.UI.Control();
    self.close:SetParent(self);
    self.close:SetSize(16, 16);
    --self.close:SetMouseVisible(false);
    self.close:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.close:SetBackground("PengorosPlugins/UI/Resources/titlebar_X_2.tga");
    self.close.pressed = false;
    self.close.MouseEnter = function(sender, args)
        self.close:SetBackground("PengorosPlugins/UI/Resources/titlebar_X_2_"..(self.close.pressed and "pressed" or "mouseover")..".tga");
    end
    self.close.MouseLeave = function(sender, args)
        self.close:SetBackground("PengorosPlugins/UI/Resources/titlebar_X_2"..(self.close.pressed and "_mouseover" or "")..".tga");
    end
    self.close.MouseDown = function(sender, args)
        self.close.pressed = true;
        self.close:SetBackground("PengorosPlugins/UI/Resources/titlebar_X_2_pressed.tga");
    end
    self.close.MouseUp = function(sender, args)
        self.close.pressed = false;
        self.close:SetBackground("PengorosPlugins/UI/Resources/titlebar_X_2.tga");
    end
    self.close.MouseClick = function(sender, args)
        self:Close();
    end
end

function Window:SetText(text)
    self.title:SetText(text);
end

function Window:SetSize(width, height)
    Turbine.UI.Window.SetSize(self, width, height);
    self.hidden:SetSize(width, height);
    self:Layout();
end

function Window:SetPosition(x, y)
    self.hidden:SetPosition(x, y);
end

function Window:GetPosition()
    return self.hidden:GetPosition();
end

function Window:SetVisible(visible)
    Turbine.UI.Window.SetVisible(self, visible);
    self.hidden:SetVisible(visible);
end

function Window:Close()
    Turbine.UI.Window.Close(self);
    self.hidden:Close();
end

function Window:Layout()
    local width, height = self:GetSize();
    if (width < 142) then
        width = 142;
    end
    if (height < 102) then
        height = 102;
    end
    
    local titleWidth = math.min(self.titleWidth, width - 72);
    local spacer = (width - titleWidth) / 2;
    self.titleLeft:SetPosition(spacer, -7);
    self.titleMid:SetPosition(spacer + 35, -7);
    self.titleMid:SetWidth(titleWidth - 70);
    self.titleRight:SetPosition(width - spacer - 35, -7);
    self.title:SetPosition(spacer + 25, 8);
    self.title:SetWidth(titleWidth - 50);
    
    local offset = 20;
    self.close:SetPosition(width - 22, offset + 5);
    self.topLeft:SetPosition(0, offset);
    self.top:SetPosition(36, offset);
    self.topRight:SetPosition(width - 36, offset);
    self.bottomLeft:SetPosition(0, height - 36);
    self.bottom:SetPosition(36, height - 36);
    self.bottomRight:SetPosition(width - 36, height - 36);
    self.left:SetPosition(0, 36 + offset);
    self.right:SetPosition(width - 36, 36 + offset);
    self.center:SetPosition(36, 36 + offset);
    
    self.top:SetWidth(width - 72);
    self.bottom:SetWidth(width - 72);
    self.left:SetHeight(height - 72 - offset);
    self.right:SetHeight(height - 72 - offset);
    self.center:SetSize(width - 72, height - 72 - offset)
end
