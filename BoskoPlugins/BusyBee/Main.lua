--
-- Busy Bee Tasks plugin for Lord of The Rings Online
--
-- by Bosko
-- Patches:
-- Gardori
-- zonk
--
-- http://www.lotrointerface.com/downloads/fileinfo.php?id=733
--

import "Turbine"
import "Turbine.Gameplay"
import "BoskoPlugins.BusyBee.BusyBeeWindow";

BusyBeeWindow = BusyBeeWindow();
BusyBeeWindow:SetVisible(true);

--==============================================================================
-- BusyBeeCommand
--==============================================================================
BusyBeeCommand = Turbine.ShellCommand();

--------------------------------------------------------------------------------
function BusyBeeCommand:GetHelp()
    return "Busy Bee Tasks by Bosko (patch by Gardori). Usage: \n  /bzb help: Show this help\n  /bzb show/hide/toggle: Change visibility\n  /bzb [number from 1-100] Set text opacity (100 = always visible)\n  /bzb sort: Move all the task items to the bottom of the bags\n  /bzb junk: List trophies with no tasks or no rep tasks";
end

--------------------------------------------------------------------------------
function BusyBeeCommand:GetShortHelp()
    return "Manage Busy Bee window. Commands: help, show, hide, toggle, refresh, <opacity number>, sort, junk";
end

--------------------------------------------------------------------------------
function BusyBeeCommand:Execute(command, arguments)
    if (command == "bzb" or command == "busybee") then
        if (arguments == "" or arguments == "help") then
            -- Help
            Turbine.Shell.WriteLine(BusyBeeCommand:GetHelp());
        elseif (arguments == "" or arguments == "toggle") then
            -- Toggle
            BusyBeeWindow:SetVisible(not BusyBeeWindow:IsVisible());
        elseif (arguments == "hide") then
            -- Hide
            BusyBeeWindow:SetVisible(false);
        elseif (arguments == "show") then
            -- Toggle visibility
            BusyBeeWindow:SetVisible(true);
        elseif (arguments == "refresh") then
            -- Refresh
            BusyBeeWindow:Refresh();
        elseif (arguments == "sort") then
            BusyBeeWindow:Sort();
        elseif (arguments == "junk") then
            BusyBeeWindow:PrintJunkItems();
        elseif (arguments ~= nil) then
            -- Set opacity if number
            local opacity = tonumber(arguments)/100;
            if ((opacity ~= nil) and (opacity > 0)) then
                BusyBeeWindow:SetPassiveOpacity(opacity);
                BusyBeeWindow:SaveSettings();
            end
        end
    end
end

--------------------------------------------------------------------------------
-- Add the command
Turbine.Shell.AddCommand("bzb;busybee", BusyBeeCommand);
