% CSI 3120: LAB 7 - Group 43
% - Alex Clements (300237898)
% - Rina Osman (300222206)
% - Sameed Jafri (300253861)

% DCG for character descriptions
character_description --> 
    character_type(Type),
    character_subtype(Type, Subtype),  
    sequence_number,
    movement_direction(Type, Weapon),
    health_level,
    weapon(Type, Weapon),
    movement_style.

% DCG for character type
character_type(Type) --> 
    [Type],
    {member(Type, [hero, enemy])}.

% DCG for character subtype
character_subtype(enemy, Subtype) --> 
    [Subtype],
    {member(Subtype, [darkwizard, demon, basilisk])}.

character_subtype(hero, Subtype) -->
    [Subtype],
    {member(Subtype, [wizard, mage, elf])}.

% DCG for sequence number
sequence_number --> 
    [Number],
    { integer(Number), Number > 0 }.

% DCG for weapon
weapon(hero, has_weapon) --> 
    [has_weapon].

weapon(hero, no_weapon) -->
    [no_weapon].

weapon(enemy, no_weapon) -->
    [no_weapon].


% DCG for movement direction
movement_direction(enemy, _) --> 
    [towards].

movement_direction(hero, has_weapon) -->
    [towards].

movement_direction(hero, no_weapon) -->
    [away].

% DCG for health level
health_level --> 
    [Level],
    { member(Level, [very_weak, weak, normal, strong, very_strong]) }.

% DCG for movement style
movement_style --> 
    [Style],
    { member(Style, [jerky, stealthy, smoothly]) }.