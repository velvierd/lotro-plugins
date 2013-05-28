import "Turbine.UI";

CheckBox = class(Turbine.UI.Control);

function CheckBox:Constructor()
    Turbine.UI.Control.Constructor(self);

    -- state
    self.checked = false;
    
    -- text label
    self.label = Turbine.UI.Label();
    self.label:SetParent(self);
    self.label:SetPosition(0, 0);
    self.label:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    self.label:SetForeColor(control2LightColor);
    self.label:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleRight);
    self.label:SetMouseVisible(false);
    
    -- check
    self.check = Turbine.UI.Control();
    self.check:SetParent(self);
    self.check:SetSize(16, 16);
    self.check:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.check:SetBackground(checkBoxEmpty);
    
    -- listeners
    self.check.MouseClick = function(sender, args)
        if (not self:IsEnabled()) then
            return;
        end
        
        if (args.Button == Turbine.UI.MouseButton.Left) then
            self:SetChecked(not self.checked);
        end
    end
end

function CheckBox:IsChecked()
    return self.checked;
end

function CheckBox:SetChecked(checked)
    self.checked = checked;
    self:UpdateState();
    PengorosPlugins.Utils.ExecuteListener(self, "CheckedChanged", {checked=self:IsChecked()});
end

function CheckBox:SetEnabled(enabled)
    Turbine.UI.Control.SetEnabled(self, enabled);
    self:UpdateState();
end

function CheckBox:SetText(text)
    self.label:SetText(text);
end

function CheckBox:SetSize(width, height)
    Turbine.UI.Control.SetSize(self, width, height);
    self:Layout();
end

function CheckBox:Layout()
    local width, height = self:GetSize();
    self.label:SetSize(width - 22, height);
    self.check:SetPosition(width - 16, ((height - 16) / 2));
end

function CheckBox:UpdateState()
    local enabled = self:IsEnabled();
    self.label:SetForeColor(enabled and control2LightColor or controlDisabledColor);
    if (self.checked) then
        self.check:SetBackground(enabled and checkBox or checkBoxDisabled);
    else
        self.check:SetBackground(enabled and checkBoxEmpty or checkBoxEmptyDisabled);
    end
end
