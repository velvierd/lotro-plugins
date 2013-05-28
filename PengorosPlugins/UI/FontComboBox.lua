import "Turbine.UI";

FontComboBox = class(PengorosPlugins.UI.ComboBox);

function FontComboBox:Constructor()
    PengorosPlugins.UI.ComboBox.Constructor(self);
end

function FontComboBox:AddItem(text, value, size)
    local width, height = self.listBox:GetSize();

    local listItem = Turbine.UI.Label();
    listItem:SetSize(width, size);
    listItem:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    listItem:SetForeColor(control2LightColor);
    listItem:SetFont(value);
    listItem:SetOutlineColor(controlSelectedColor);
    listItem:SetText(text);
    
    listItem.MouseEnter = function(sender, args)
        sender:SetFontStyle(Turbine.UI.FontStyle.Outline);
        sender:SetForeColor(control2LightColor);
        sender:SetText(sender:GetText());
    end
    listItem.MouseLeave = function(sender, args)
        sender:SetFontStyle(Turbine.UI.FontStyle.None);
        if (self.listBox:IndexOfItem(sender) == self.selection) then
            sender:SetForeColor(yellowColor);
        end
        sender:SetText(sender:GetText());
    end
    listItem.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Left) then
            self:ItemSelected(self.listBox:GetSelectedIndex());
            self:FireEvent();
        end
    end
    listItem.value = value;
    self.listBox:AddItem(listItem);
end
