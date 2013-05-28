
import "Turbine";
import "Turbine.Debug";
import "Turbine.Gameplay";
import "Turbine.UI";

import "TurbinePlugins.Vitals";

VitalsWindow = class( Turbine.UI.Window );

function VitalsWindow:Constructor()
	Turbine.UI.Window.Constructor( self );
	
	self.layout = Turbine.UI.HorizontalLayout.LeftToRight;
	
	self.flashing = false;
	self.flashTime = 0;
	self.flashLimit = 0.33;
	
	self:SetPosition( 10, 10 );
	self:SetSize( 229, 96 );
	
	self.effectSize = 20;
	
	--self:SetBackColor( Turbine.UI.Color( 0.6, 0, 0, 0 ) );
	
	self.nameLabel = Turbine.UI.Label();
	self.nameLabel:SetParent( self );
	self.nameLabel:SetPosition( 60, 3 );
	self.nameLabel:SetSize( 160, 12 );
	self.nameLabel:SetFontStyle( Turbine.UI.FontStyle.Outline );
	self.nameLabel:SetOutlineColor( Turbine.UI.Color( 0, 0, 0 ) );
	self.nameLabel:SetMouseVisible( false );
	
	self.vitalsFrame = Turbine.UI.Control();
	self.vitalsFrame:SetParent( self );
	self.vitalsFrame:SetBackColor( Turbine.UI.Color( 1, 0, 0, 0 ) );
	self.vitalsFrame:SetPosition( 58, 17 );
	self.vitalsFrame:SetSize( 164, 28 );	
	self.vitalsFrame:SetMouseVisible( false );	
	
	-- Construct the morale bar.
	self.moraleBar = VitalsBar();
	self.moraleBar:SetParent( self );
	self.moraleBar:SetZOrder( 100 );
	self.moraleBar:SetColor( Turbine.UI.Color( 1, 0.1, 1, 0.1 ) );
	self.moraleBar:SetBuffColor( Turbine.UI.Color( 1, 0.3, 0.7, 1 ) );
	self.moraleBar:SetDebuffColor( Turbine.UI.Color( 1, 1.0, 0.4, 0 ) );
	self.moraleBar:SetPosition( 60, 19 );
	self.moraleBar:SetSize( 160, 12 );
	self.moraleBar:SetMouseVisible( false );
	--self.moraleBar:SetShowPercentage( true );
	--self.moraleBar:SetHorizontalLayout( Turbine.UI.HorizontalLayout.RightToLeft );
	
	--self.SetText( self.moraleBar, "This is a really bad thing to be doing. I'm passing the wrong type of control..." );
	
	-- Construct the power bar.
	self.powerBar = VitalsBar();
	self.powerBar:SetParent( self );
	self.powerBar:SetZOrder( 100 );
	self.powerBar:SetColor( Turbine.UI.Color( 1, 0.1, 0.5, 1 ) );
	self.powerBar:SetPosition( 60, 31 );
	self.powerBar:SetSize( 160, 12 );
	self.powerBar:SetMouseVisible( false );
	--self.powerBar:SetShowPercentage( true );
	--self.powerBar:SetHorizontalLayout( Turbine.UI.HorizontalLayout.RightToLeft );

	-- Construct the avatar display.
	self.avatar = Turbine.UI.Control();
	self.avatar:SetParent( self );
	self.avatar:SetPosition( 4, 4 );
	self.avatar:SetBackground( "TurbinePlugins/Vitals/Resources/Ring.tga" );
	self.avatar:SetBackColorBlendMode( Turbine.UI.BlendMode.Multiply );
	self.avatar:SetSize( 50, 50 );
	self.avatar:SetMouseVisible( false );
	
	self.levelFrame = Turbine.UI.Control();
	self.levelFrame:SetParent( self );
	self.levelFrame:SetBackColor( Turbine.UI.Color( 0.4, 0, 0, 0 ) );
	self.levelFrame:SetPosition( 1, 48 );
	self.levelFrame:SetSize( 24, 15 );
	self.levelFrame:SetZOrder( 100 );
	self.levelFrame:SetMouseVisible( false );
	
	self.levelLabel = Turbine.UI.Label();
	self.levelLabel:SetParent( self );
	self.levelLabel:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleCenter );
	self.levelLabel:SetForeColor( Turbine.UI.Color( 1, 1, 1, 1 ) );
	self.levelLabel:SetPosition( 0, 49 );
	self.levelLabel:SetSize( 24, 15 );
	self.levelLabel:SetZOrder( 201 );
	self.levelLabel:SetMouseVisible( false );
	
	self.buffsEffectsList = Turbine.UI.ListBox();
	self.buffsEffectsList:SetParent( self );
	self.buffsEffectsList:SetPosition( 60, 46 );
	self.buffsEffectsList:SetSize( 160, 80 );
	self.buffsEffectsList:SetOrientation( Turbine.UI.Orientation.Horizontal );
	self.buffsEffectsList:SetMaxItemsPerLine( 10 );
	self.buffsEffectsList:SetMouseVisible( false );
	
	self.debuffsEffectsList = Turbine.UI.ListBox();
	self.debuffsEffectsList:SetParent( self );
	self.debuffsEffectsList:SetPosition( 60, 46 );
	self.debuffsEffectsList:SetSize( 160, 80 );
	self.debuffsEffectsList:SetOrientation( Turbine.UI.Orientation.Horizontal );
	self.debuffsEffectsList:SetMaxItemsPerLine( 10 );
	self.debuffsEffectsList:SetMouseVisible( false );
	
	-- Hook into the player to receive updates about player morale and
	-- power.
	self.player = Turbine.Gameplay.LocalPlayer.GetInstance()
	
	self.nameLabel:SetText( self.player:GetName() );
	self.levelLabel:SetText( "" .. self.player:GetLevel() );
	
	local effects = self.player:GetEffects();

	local i;
	for i = 1, effects:GetCount() do
		self:AddEffect( i );
	end
	
	self.player.NameChanged = function( sender, args )
		self.nameLabel:SetText( "" .. self.player:GetName() );
	end
	
	self.player.LevelChanged = function( sender, args )
		self.levelLabel:SetText( "" .. self.player:GetLevel() );
	end
	
	self.player.MoraleChanged = function( sender, args )
		self:UpdateMorale()
	end
	
	self.player.MaxMoraleChanged = function( sender, args )
		self:UpdateMorale()
	end
	
	self.player.BaseMaxMoraleChanged = function( sender, args )
		self:UpdateMorale()
	end
	
	self.player.PowerChanged = function( sender, args )
		self:UpdatePower()
	end
	
	self.player.MaxPowerChanged = function( sender, args )
		self:UpdatePower()
	end
	
	self.player.BaseMaxPowerChanged = function( sender, args )
		self:UpdatePower()
	end
	
	effects.EffectAdded = function( sender, args )
		self:AddEffect( args.Index );
	end
	
	effects.EffectRemoved = function( sender, args )
		self:RemoveEffect( args.Effect );
	end
	
	effects.EffectsCleared = function( sender, args )
		self.effectsList:Clear();
	end
	
	self:UpdateVitals()
end

function EffectsSorter( first, second )
	if ( first == nil or first.GetEffect == nil ) then
		return true;
	end

	if ( second == nil or second.GetEffect == nil ) then
		return false;
	end

	local firstEffect = first:GetEffect();
	local secondEffect = second:GetEffect();

	if ( firstEffect == nil ) then
		return true;
	end
	
	if ( secondEffect == nil ) then
		return false;
	end

	local firstDuration = firstEffect:GetDuration();
	local secondDuration = secondEffect:GetDuration();

	Turbine.Shell.WriteLine( "  First Duration: " .. firstDuration .. ", Second Duration: " .. secondDuration );

	return ( firstDuration > secondDuration );
end

function VitalsWindow:AddEffect( effectIndex )
	local effect = self.player:GetEffects():Get( effectIndex );

	--local effectDisplay = Turbine.UI.Lotro.EffectDisplay()
	local effectDisplay = SmallEffectDisplay()
	effectDisplay:SetEffect( effect );
	effectDisplay:SetSize( self.effectSize, self.effectSize );

	local insertionList = nil;
	local effectEndTime = effect:GetStartTime() + effect:GetDuration();

	if ( effectDisplay:GetEffect():IsDebuff() ) then
		insertionList = self.debuffsEffectsList;
	else
		insertionList = self.buffsEffectsList;
	end

	local i = 0;
	local insertAt = -1;

	for i = 1, insertionList:GetItemCount() do
		local testEffect = insertionList:GetItem( i ):GetEffect();
		local testEffectEndTime = testEffect:GetStartTime() + testEffect:GetDuration();

		if ( effectEndTime > testEffectEndTime ) then
			insertAt = i;
			break;
		end
	end

	if ( insertAt == -1 ) then
		insertionList:AddItem( effectDisplay );
	else
		insertionList:InsertItem( insertAt, effectDisplay );
	end

	self:UpdateEffectsLayout();
end

function VitalsWindow:RemoveEffect( effect )
	local i;

	if ( effect:IsDebuff() ) then
		for i = 1, self.debuffsEffectsList:GetItemCount() do
			local effectListItem = self.debuffsEffectsList:GetItem( i ):GetEffect();
			
			if ( effect == effectListItem ) then
				local effectElement = self.debuffsEffectsList:GetItem( i );
				effectElement:SetVisible( false );
				self.debuffsEffectsList:RemoveItemAt( i );
				break;
			end
		end
	else
		for i = 1, self.buffsEffectsList:GetItemCount() do
			local effectListItem = self.buffsEffectsList:GetItem( i ):GetEffect();
			
			if ( effect == effectListItem ) then
				local effectElement = self.buffsEffectsList:GetItem( i );
				effectElement:SetVisible( false );
				self.buffsEffectsList:RemoveItemAt( i );
				break;
			end
		end
	end
	
	self:UpdateEffectsLayout();
end

function VitalsWindow:UpdateEffectsLayout()
	local debuffsCount = self.debuffsEffectsList:GetItemCount();
	local rows = math.ceil( debuffsCount / self.debuffsEffectsList:GetMaxItemsPerLine() );
	local debuffsHeight = ( rows * self.effectSize );
	local buffsTop = ( self.debuffsEffectsList:GetTop() ) + debuffsHeight;
	self.debuffsEffectsList:SetSize( self.debuffsEffectsList:GetWidth(), debuffsHeight );
	self.buffsEffectsList:SetPosition( 60, buffsTop );
end

function VitalsWindow:GetLayout()
	return self.layout;
end

function VitalsWindow:SetLayout( value )
	self.layout = value;

	if ( value == Turbine.UI.HorizontalLayout.LeftToRight ) then
		self.nameLabel:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
	else
		self.nameLabel:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleRight );
	end

	self.moraleBar:SetHorizontalLayout( value );
	self.powerBar:SetHorizontalLayout( value );

	self:Layout();
end

function VitalsWindow:MouseDown( args )
	if ( args.Button == Turbine.UI.MouseButton.Left ) then
		self.dragStartX = args.X;
		self.dragStartY = args.Y;
		self.dragging = true;
	end
	
	if ( args.Button == Turbine.UI.MouseButton.Right ) then
		local contextMenu = Turbine.UI.ContextMenu();
		local contextMenuItems = contextMenu:GetItems();

		local layoutMenuItem = Turbine.UI.MenuItem( "Layout" );
		local layoutMenuItems = layoutMenuItem:GetItems();

		local leftToRightMenuItem = Turbine.UI.MenuItem( "Left to Right" );

		leftToRightMenuItem.Click = function( sender, args )
			self:SetLayout( Turbine.UI.HorizontalLayout.LeftToRight );
		end

		local rightToLeftMenuItem = Turbine.UI.MenuItem( "Right to Left" );

		rightToLeftMenuItem.Click = function( sender, args )
			self:SetLayout( Turbine.UI.HorizontalLayout.RightToLeft );
		end

		if ( self.layout == Turbine.UI.HorizontalLayout.LeftToRight ) then
			leftToRightMenuItem:SetChecked( true );
		else
			rightToLeftMenuItem:SetChecked( true );
		end

		layoutMenuItems:Add( leftToRightMenuItem );
		layoutMenuItems:Add( rightToLeftMenuItem );
		contextMenuItems:Add( layoutMenuItem );
		contextMenu:ShowMenu();
	end
end

function VitalsWindow:MouseMove( args )
	local left, top = self:GetPosition();
	
	if ( self.dragging ) then
		self:SetPosition( left + ( args.X - self.dragStartX ), top + ( args.Y - self.dragStartY ) );
	end
end

function VitalsWindow:MouseUp( args )
	if ( args.Button == Turbine.UI.MouseButton.Left ) then
		self.dragging = false;
	end
end

function VitalsWindow:UpdateMorale()
	local morale        = self.player:GetMorale();
	local maxMorale     = self.player:GetMaxMorale();
	local baseMaxMorale = self.player:GetBaseMaxMorale();

	self.moraleBar:SetValue( morale );
	self.moraleBar:SetMax( maxMorale );
	self.moraleBar:SetBaseMax( baseMaxMorale );

	local moraleRatio = ( morale / maxMorale );

	local newR = 1 - moraleRatio
	local newG = moraleRatio
	local scaleFactor = 1

	if ( newR < newG ) then
		scaleFactor = 1 / newG
	else
		scaleFactor = 1 / newR
	end

	newR = newR * scaleFactor;
	newG = newG * scaleFactor;

	self.moraleBar:SetColor( Turbine.UI.Color( 1.0, newR, newG, 0.0 ) );
	self.avatar:SetBackColor( Turbine.UI.Color( 0.5, 1, moraleRatio, moraleRatio ) );

	if ( ( not self.flashing ) and ( moraleRatio < self.flashLimit ) ) then
		self.flashing = true;
		self.flashTime = Turbine.Engine.GetGameTime();
		self:SetWantsUpdates( true );
	end
end

function VitalsWindow:UpdatePower()
	local power = self.player:GetPower()
	self.powerBar:SetValue( power );

	local maxPower = self.player:GetMaxPower()
	self.powerBar:SetMax( maxPower );

	local baseMaxPower = self.player:GetBaseMaxPower()
	self.powerBar:SetBaseMax( baseMaxPower );
end

function VitalsWindow:UpdateVitals()
	self:UpdateMorale();
	self:UpdatePower();
end

function VitalsWindow:Update( args )
	local morale    = self.player:GetMorale();
	local maxMorale = self.player:GetMaxMorale();

	local moraleRatio = ( morale / maxMorale );
	local flashAmount = 0;

	if ( moraleRatio >= self.flashLimit ) then
		self.flashing = false;
		self:SetWantsUpdates( false );
	else
		flashAmount = ( math.sin( 12 * ( Turbine.Engine.GetGameTime() - self.flashTime ) ) + 1 ) / 2;
	end

	local newR = 1 - moraleRatio;
	local newG = moraleRatio;
	local scaleFactor = 1;

	if ( newR < newG ) then
		scaleFactor = 1 / newG
	else
		scaleFactor = 1 / newR
	end

	newR = newR * scaleFactor;
	newG = newG * scaleFactor;

	newR = newR + flashAmount * ( 1 - newR );
	newG = newG + flashAmount * ( 1 - newG );

	self.moraleBar:SetColor( Turbine.UI.Color( 1.0, newR, newG, 0.0 ) );
	self.avatar:SetBackColor( Turbine.UI.Color( 0.5, 1, newG, newG ) );
end

function VitalsWindow:Layout()
	if ( self.layout == Turbine.UI.HorizontalLayout.LeftToRight ) then
		self.nameLabel:SetPosition( 60, 3 );
		self.vitalsFrame:SetPosition( 58, 17 );
		self.moraleBar:SetPosition( 60, 19 );
		self.powerBar:SetPosition( 60, 31 );
		self.avatar:SetPosition( 4, 4 );
		self.levelFrame:SetPosition( 1, 48 );
		self.levelLabel:SetPosition( 0, 49 );
		self.buffsEffectsList:SetPosition( 60, 46 );
		self.debuffsEffectsList:SetPosition( 60, 46 );
	else
		self.nameLabel:SetPosition( 2, 3 );
		self.vitalsFrame:SetPosition( 0, 17 );
		self.moraleBar:SetPosition( 2, 19 );
		self.powerBar:SetPosition( 2, 31 );
		self.avatar:SetPosition( 168, 4 );
		self.levelFrame:SetPosition( 194, 48 );
		self.levelLabel:SetPosition( 193, 49 );
		self.buffsEffectsList:SetPosition( 2, 46 );
		self.debuffsEffectsList:SetPosition( 2, 46 );
	end
	
	self:SetVisible( false );
	self:SetVisible( true );
end
