import "PengorosPlugins.UI.ComboBox";
import "PengorosPlugins.UI.ListBox";
import "PengorosPlugins.UI.CheckBox";
import "PengorosPlugins.UI.Slider";
import "PengorosPlugins.UI.Label";
import "PengorosPlugins.UI.Button";
import "PengorosPlugins.UI.FontComboBox";
import "PengorosPlugins.UI.PanelDivider";
import "PengorosPlugins.UI.DragBar";
import "PengorosPlugins.UI.Window";
import "PengorosPlugins.UI.Tooltip";
import "PengorosPlugins.UI.Tab";
import "PengorosPlugins.UI.TabbedPane";

-- setup the default colors the UI elements use
PengorosPlugins.UI.blueBorderColor = Turbine.UI.Color(0.15, 0.2, 0.3);                  -- blue inner border
PengorosPlugins.UI.controlColor = Turbine.UI.Color(.83, .69, .28);                      -- gold,  slightly yellow
PengorosPlugins.UI.control2Color = Turbine.UI.Color(0.88, 0.77, 0.1);                   -- gold,  almost yellow
PengorosPlugins.UI.controlSelectedColor = Turbine.UI.Color(0.9, 0.85, 0.65);            -- light gold
PengorosPlugins.UI.control2LightColor = Turbine.UI.Color(0.95, 0.85, 0.55);             -- light gold,  somewhat white
PengorosPlugins.UI.controlDisabledColor = Turbine.UI.Color(.79, .79, .79);              -- grey
PengorosPlugins.UI.control2DisabledColor = Turbine.UI.Color(162/255, 162/255, 162/255); -- lighter grey
PengorosPlugins.UI.whiteColor = Turbine.UI.Color(1, 1, 1);                              -- white
PengorosPlugins.UI.blackColor = Turbine.UI.Color(0, 0, 0);                              -- black
PengorosPlugins.UI.yellowColor = Turbine.UI.Color(1, 1, 0);                             -- yellow
PengorosPlugins.UI.dialogBackgroundColor = Turbine.UI.Color(0.92, 0, 0, 0);             -- default black dialog background, slightly transparent
PengorosPlugins.UI.highlightColor = Turbine.UI.Color(.92, 40/255, 67/255, 122/255);     -- bluish highlight color, slightly transparent
PengorosPlugins.UI.yellowGoldColor = Turbine.UI.Color(244/255, 255/255, 51/255);        -- yellow gold color

-- slider assets
PengorosPlugins.UI.sliderWidget = Turbine.UI.Graphic(0x41007e0c);
PengorosPlugins.UI.sliderWidgetDisabled = Turbine.UI.Graphic("PengorosPlugins/UI/Resources/slider_widget_ghosted.tga");
PengorosPlugins.UI.sliderBackground = Turbine.UI.Graphic(0x41007e0b);
PengorosPlugins.UI.sliderLeftArrow = Turbine.UI.Graphic(0x41007e0e);
PengorosPlugins.UI.sliderLeftArrowPressed = Turbine.UI.Graphic(0x41007e0d);
PengorosPlugins.UI.sliderRightArrow = Turbine.UI.Graphic(0x41007e11);
PengorosPlugins.UI.sliderRightArrowPressed = Turbine.UI.Graphic(0x41007e10);

-- checkbox assets
PengorosPlugins.UI.checkBox = Turbine.UI.Graphic(0x410001a3);
PengorosPlugins.UI.checkBoxDisabled = Turbine.UI.Graphic("PengorosPlugins/UI/Resources/checkbox_02_ghosted.tga");
PengorosPlugins.UI.checkBoxEmpty = Turbine.UI.Graphic(0x410001a4);
PengorosPlugins.UI.checkBoxEmptyDisabled = Turbine.UI.Graphic("PengorosPlugins/UI/Resources/checkbox_02_empty_ghosted.tga");

-- drop down assets
PengorosPlugins.UI.dropDownArrow = Turbine.UI.Graphic(0x41007e1a);
PengorosPlugins.UI.dropDownArrowDisabled = Turbine.UI.Graphic("PengorosPlugins/UI/Resources/dropdown_arrow_closed_ghosted.tga");
PengorosPlugins.UI.dropDownArrowHighlight = Turbine.UI.Graphic(0x41007e1b);
PengorosPlugins.UI.dropDownArrowPressed = Turbine.UI.Graphic(0x41007e18);
PengorosPlugins.UI.dropDownArrowPressedHighlight = Turbine.UI.Graphic(0x41007e19);

-- drag bar assets
PengorosPlugins.UI.dragBar = Turbine.UI.Graphic("PengorosPlugins/UI/Resources/drag_bar.tga");
PengorosPlugins.UI.dragBarPressed = Turbine.UI.Graphic("PengorosPlugins/UI/Resources/drag_bar_click.tga");
PengorosPlugins.UI.dragBarGem = Turbine.UI.Graphic("PengorosPlugins/UI/Resources/drag_gem.tga");
PengorosPlugins.UI.dragBarGemPressed = Turbine.UI.Graphic("PengorosPlugins/UI/Resources/drag_gem_click.tga");
PengorosPlugins.UI.dragBarTopLeft = Turbine.UI.Graphic("PengorosPlugins/UI/Resources/drag_topleft.tga");
PengorosPlugins.UI.dragBarTopRight = Turbine.UI.Graphic("PengorosPlugins/UI/Resources/drag_topright.tga");
PengorosPlugins.UI.dragBarBottomLeft = Turbine.UI.Graphic("PengorosPlugins/UI/Resources/drag_bottomleft.tga");
PengorosPlugins.UI.dragBarBottomRight = Turbine.UI.Graphic("PengorosPlugins/UI/Resources/drag_bottomright.tga");
PengorosPlugins.UI.dragBarMidTop = Turbine.UI.Graphic("PengorosPlugins/UI/Resources/drag_topmid.tga");
PengorosPlugins.UI.dragBarMidLeft = Turbine.UI.Graphic("PengorosPlugins/UI/Resources/drag_midleft.tga");
PengorosPlugins.UI.dragBarMidRight = Turbine.UI.Graphic("PengorosPlugins/UI/Resources/drag_midright.tga");
PengorosPlugins.UI.dragBarMidBottom = Turbine.UI.Graphic("PengorosPlugins/UI/Resources/drag_bottommid.tga");

-- panel divider assets
PengorosPlugins.UI.panelDivider = Turbine.UI.Graphic("PengorosPlugins/UI/Resources/options_panel_divider.tga");

-- tab assets
PengorosPlugins.UI.tabRight = Turbine.UI.Graphic("PengorosPlugins/UI/Resources/tab_tier1_middle_back_e.tga");
PengorosPlugins.UI.tabLeft = Turbine.UI.Graphic("PengorosPlugins/UI/Resources/tab_tier1_middle_back_w.tga");
PengorosPlugins.UI.tabRightSelected = Turbine.UI.Graphic("PengorosPlugins/UI/Resources/tab_tier1_middle_front_e.tga");
PengorosPlugins.UI.tabLeftSelected = Turbine.UI.Graphic("PengorosPlugins/UI/Resources/tab_tier1_middle_front_w.tga");

-- tooltip assets
PengorosPlugins.UI.tooltipTopLeft = Turbine.UI.Graphic(0x41000133);
PengorosPlugins.UI.tooltipTopRight = Turbine.UI.Graphic(0x41000139);
PengorosPlugins.UI.tooltipBottomLeft = Turbine.UI.Graphic(0x41000135);
PengorosPlugins.UI.tooltipBottomRight = Turbine.UI.Graphic(0x41000137);
PengorosPlugins.UI.tooltipMidTop = Turbine.UI.Graphic(0x4100013a);
PengorosPlugins.UI.tooltipMidLeft = Turbine.UI.Graphic(0x41000134);
PengorosPlugins.UI.tooltipMidRight = Turbine.UI.Graphic(0x41000138);
PengorosPlugins.UI.tooltipMidBottom = Turbine.UI.Graphic(0x41000136);
