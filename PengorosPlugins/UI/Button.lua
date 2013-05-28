import "Turbine.UI";

Button = class(Turbine.UI.Control);

-- Deprecated, this class should go away :)

-- colors
Button.ItemColor = Turbine.UI.Color(180/255, 150/255, 0/255);
Button.DisabledColor = Turbine.UI.Color(162/255, 162/255, 162/255);
Button.HighlightColor = Turbine.UI.Color(255/255, 255/255, 0/255);

function Button:Constructor()
    Turbine.UI.Control.Constructor(self);

    -- state
    self.selected = false;
    self.pressed = false;
    self.mouse = false;
    
    -- text label
    self.label = Turbine.UI.Label();
    self.label:SetParent(self);
    self.label:SetPosition(0, 0);
    self.label:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    self.label:SetForeColor(Button.ItemColor);
    self.label:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self.label:SetMouseVisible(false);
    self.label:SetZOrder(5);
    
    -- left
    self.left = Turbine.UI.Control();
    self.left:SetParent(self);
    self.left:SetSize(20, 20);
    self.left:SetMouseVisible(false);
    self.left:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.left:SetBackground("PengorosPlugins/UI/Resources/textbutton_left_normal.tga");

    -- mid
    self.mid = Turbine.UI.Control();
    self.mid:SetParent(self);
    self.mid:SetSize(20, 20);
    self.mid:SetMouseVisible(false);
    self.mid:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.mid:SetBackground("PengorosPlugins/UI/Resources/textbutton_mid_normal.tga");
    
    -- right
    self.right = Turbine.UI.Control();
    self.right:SetParent(self);
    self.right:SetSize(20, 20);
    self.right:SetMouseVisible(false);
    self.right:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.right:SetBackground("PengorosPlugins/UI/Resources/textbutton_right_normal.tga");
end

function Button:MouseClick(args)
    if (not self:IsEnabled()) then
        return;
    end
    
    if (args.Button == Turbine.UI.MouseButton.Left) then
        PengorosPlugins.Utils.ExecuteListener(self, "Click", {});
    end
end

function Button:MouseEnter(args)
    self.mouse = true;
    self:UpdateState();
end

function Button:MouseLeave(args)
    self.mouse = false;
    self:UpdateState();
end

function Button:MouseDown(args)
    self.pressed = true;
    self:UpdateState();
end

function Button:MouseUp(args)
    self.pressed = false;
    self:UpdateState();
end

function Button:IsSelected()
    return self.selected;
end

function Button:SetSelected(selected)
    self.selected = selected;
    self:UpdateState();
end

function Button:SetEnabled(enabled)
    Turbine.UI.Control.SetEnabled(self, enabled);
    self:UpdateState();
end

function Button:SetText(text)
    self.label:SetText(text);
end

function Button:SetSize(width, height)
    Turbine.UI.Control.SetSize(self, width, height);
    self:Layout();
end

function Button:Layout()
    local width = self:GetWidth();
    if (width < 40) then
        width = 40;
    end
    
    self.label:SetPosition(5, 0);
    self.left:SetPosition(0, 0);
    self.mid:SetPosition(20, 0);
    self.right:SetPosition(width-20, 0);
    
    self.label:SetSize(width - 10, 20);
    self.left:SetSize(20, 20);
    self.mid:SetSize(width - 40, 20);
    self.right:SetSize(20, 20);
end

function Button:UpdateState()
    local enabled = self:IsEnabled();
    local state = self.selected and "highlighted_" or "";
    local color = self.selected and Button.HighlightColor or Button.ItemColor;
    if (not enabled) then
        state = "ghosted";
        color = Button.DisabledColor;
    elseif (self.pressed) then
        state = state .. "pressed";
        color = Button.DisabledColor;
    elseif (self.mouse) then
        state = state .. "mouseover";
        color = Button.HighlightColor;
    else
        state = state .. "normal";
    end

    self.label:SetForeColor(color);
    self.left:SetBackground("PengorosPlugins/UI/Resources/textbutton_left_"..state..".tga");
    self.mid:SetBackground("PengorosPlugins/UI/Resources/textbutton_mid_"..state..".tga");
    self.right:SetBackground("PengorosPlugins/UI/Resources/textbutton_right_"..state..".tga");
end
