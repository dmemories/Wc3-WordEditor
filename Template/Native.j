ative BlzGetTriggerPlayerMouseX                   takes nothing returns real
native BlzGetTriggerPlayerMouseY                   takes nothing returns real
native BlzGetTriggerPlayerMousePosition            takes nothing returns location
native BlzGetTriggerPlayerMouseButton              takes nothing returns mousebuttontype
native BlzSetAbilityTooltip                        takes integer abilCode, string tooltip, integer level returns nothing
native BlzSetAbilityActivatedTooltip               takes integer abilCode, string tooltip, integer level returns nothing
native BlzSetAbilityExtendedTooltip                takes integer abilCode, string extendedTooltip, integer level returns nothing
native BlzSetAbilityActivatedExtendedTooltip       takes integer abilCode, string extendedTooltip, integer level returns nothing
native BlzSetAbilityResearchTooltip                takes integer abilCode, string researchTooltip, integer level returns nothing
native BlzSetAbilityResearchExtendedTooltip        takes integer abilCode, string researchExtendedTooltip, integer level returns nothing
native BlzGetAbilityTooltip                        takes integer abilCode, integer level returns string
native BlzGetAbilityActivatedTooltip               takes integer abilCode, integer level returns string
native BlzGetAbilityExtendedTooltip                takes integer abilCode, integer level returns string
native BlzGetAbilityActivatedExtendedTooltip       takes integer abilCode, integer level returns string
native BlzGetAbilityResearchTooltip                takes integer abilCode, integer level returns string
native BlzGetAbilityResearchExtendedTooltip        takes integer abilCode, integer level returns string
native BlzSetAbilityIcon                           takes integer abilCode, string iconPath returns nothing
native BlzGetAbilityIcon                           takes integer abilCode returns string
native BlzSetAbilityActivatedIcon                  takes integer abilCode, string iconPath returns nothing
native BlzGetAbilityActivatedIcon                  takes integer abilCode returns string
native BlzGetAbilityPosX                           takes integer abilCode returns integer
native BlzGetAbilityPosY                           takes integer abilCode returns integer
native BlzSetAbilityPosX                           takes integer abilCode, integer x returns nothing
native BlzSetAbilityPosY                           takes integer abilCode, integer y returns nothing
native BlzGetAbilityActivatedPosX                  takes integer abilCode returns integer
native BlzGetAbilityActivatedPosY                  takes integer abilCode returns integer
native BlzSetAbilityActivatedPosX                  takes integer abilCode, integer x returns nothing
native BlzSetAbilityActivatedPosY                  takes integer abilCode, integer y returns nothing
native BlzGetUnitMaxHP                             takes unit whichUnit returns integer
native BlzSetUnitMaxHP                             takes unit whichUnit, integer hp returns nothing
native BlzGetUnitMaxMana                           takes unit whichUnit returns integer
native BlzSetUnitMaxMana                           takes unit whichUnit, integer mana returns nothing
native BlzSetItemName                              takes item whichItem, string name returns nothing
native BlzSetItemDescription                       takes item whichItem, string description returns nothing
native BlzGetItemDescription                       takes item whichItem returns string
native BlzSetItemTooltip                           takes item whichItem, string tooltip returns nothing
native BlzGetItemTooltip                           takes item whichItem returns string
native BlzSetItemExtendedTooltip                   takes item whichItem, string extendedTooltip returns nothing
native BlzGetItemExtendedTooltip                   takes item whichItem returns string
native BlzSetItemIconPath                          takes item whichItem, string iconPath returns nothing
native BlzGetItemIconPath                          takes item whichItem returns string
native BlzSetUnitName                              takes unit whichUnit, string name returns nothing
native BlzSetHeroProperName                        takes unit whichUnit, string heroProperName returns nothing
native BlzGetUnitBaseDamage                        takes unit whichUnit, integer weaponIndex returns integer
native BlzSetUnitBaseDamage                        takes unit whichUnit, integer baseDamage, integer weaponIndex returns nothing
native BlzGetUnitDiceNumber                        takes unit whichUnit, integer weaponIndex returns integer
native BlzSetUnitDiceNumber                        takes unit whichUnit, integer diceNumber, integer weaponIndex returns nothing
native BlzGetUnitDiceSides                         takes unit whichUnit, integer weaponIndex returns integer
native BlzSetUnitDiceSides                         takes unit whichUnit, integer diceSides, integer weaponIndex returns nothing
native BlzGetUnitAttackCooldown                    takes unit whichUnit, integer weaponIndex returns real
native BlzSetUnitAttackCooldown                    takes unit whichUnit, real cooldown, integer weaponIndex returns nothing
native BlzSetSpecialEffectColorByPlayer            takes effect whichEffect, player whichPlayer returns nothing
native BlzSetSpecialEffectColor                    takes effect whichEffect, integer r, integer g, integer b returns nothing
native BlzSetSpecialEffectAlpha                    takes effect whichEffect, integer alpha returns nothing
native BlzSetSpecialEffectScale                    takes effect whichEffect, real scale returns nothing
native BlzSetSpecialEffectPosition                 takes effect whichEffect, real x, real y, real z returns nothing
native BlzSetSpecialEffectHeight                   takes effect whichEffect, real height returns nothing
native BlzSetSpecialEffectTimeScale                takes effect whichEffect, real timeScale returns nothing
native BlzSetSpecialEffectTime                     takes effect whichEffect, real time returns nothing
native BlzSetSpecialEffectOrientation              takes effect whichEffect, real yaw, real pitch, real roll returns nothing
native BlzSetSpecialEffectYaw                      takes effect whichEffect, real yaw returns nothing
native BlzSetSpecialEffectPitch                    takes effect whichEffect, real pitch returns nothing
native BlzSetSpecialEffectRoll                     takes effect whichEffect, real roll returns nothing
native BlzSetSpecialEffectX                        takes effect whichEffect, real x returns nothing
native BlzSetSpecialEffectY                        takes effect whichEffect, real y returns nothing
native BlzSetSpecialEffectZ                        takes effect whichEffect, real z returns nothing
native BlzSetSpecialEffectPositionLoc              takes effect whichEffect, location loc returns nothing
native BlzGetLocalSpecialEffectX                   takes effect whichEffect returns real
native BlzGetLocalSpecialEffectY                   takes effect whichEffect returns real
native BlzGetLocalSpecialEffectZ                   takes effect whichEffect returns real
native BlzSpecialEffectClearSubAnimations          takes effect whichEffect returns nothing
native BlzSpecialEffectRemoveSubAnimation          takes effect whichEffect, subanimtype whichSubAnim returns nothing
native BlzSpecialEffectAddSubAnimation             takes effect whichEffect, subanimtype whichSubAnim returns nothing
native BlzPlaySpecialEffect                        takes effect whichEffect, animtype whichAnim returns nothing
native BlzPlaySpecialEffectWithTimeScale           takes effect whichEffect, animtype whichAnim, real timeScale returns nothing
native BlzGetAnimName                              takes animtype whichAnim returns string
native BlzGetUnitArmor                             takes unit whichUnit returns real
native BlzSetUnitArmor                             takes unit whichUnit, real armorAmount returns nothing
native BlzUnitHideAbility                          takes unit whichUnit, integer abilId, boolean flag returns nothing
native BlzUnitDisableAbility                       takes unit whichUnit, integer abilId, boolean flag, boolean hideUI returns nothing
native BlzUnitCancelTimedLife                      takes unit whichUnit returns nothing
native BlzIsUnitSelectable                         takes unit whichUnit returns boolean
native BlzIsUnitInvulnerable                       takes unit whichUnit returns boolean
native BlzUnitInterruptAttack                      takes unit whichUnit returns nothing
native BlzGetUnitCollisionSize                     takes unit whichUnit returns real
native BlzGetAbilityManaCost                       takes integer abilId, integer level returns integer
native BlzGetAbilityCooldown                       takes integer abilId, integer level returns real
native BlzSetUnitAbilityCooldown                   takes unit whichUnit, integer abilId, integer level, real cooldown returns nothing
native BlzGetUnitAbilityCooldown                   takes unit whichUnit, integer abilId, integer level returns real
native BlzGetUnitAbilityCooldownRemaining          takes unit whichUnit, integer abilId returns real
native BlzEndUnitAbilityCooldown                   takes unit whichUnit, integer abilCode returns nothing
native BlzGetUnitAbilityManaCost                   takes unit whichUnit, integer abilId, integer level returns integer
native BlzSetUnitAbilityManaCost                   takes unit whichUnit, integer abilId, integer level, integer manaCost returns nothing
native BlzGetLocalUnitZ                            takes unit whichUnit returns real    
native BlzDecPlayerTechResearched                  takes player whichPlayer, integer techid, integer levels returns nothing
native BlzSetEventDamage                           takes real damage returns nothing
native RequestExtraIntegerData                     takes integer dataType, player whichPlayer, string param1, string param2, boolean param3, integer param4, integer param5, integer param6 returns integer
native RequestExtraBooleanData                     takes integer dataType, player whichPlayer, string param1, string param2, boolean param3, integer param4, integer param5, integer param6 returns boolean
native RequestExtraStringData                      takes integer dataType, player whichPlayer, string param1, string param2, boolean param3, integer param4, integer param5, integer param6 returns string
native RequestExtraRealData                        takes integer dataType, player whichPlayer, string param1, string param2, boolean param3, integer param4, integer param5, integer param6 returns real
// Add this function to follow the style of GetUnitX and GetUnitY, it has the same result as BlzGetLocalUnitZ
native BlzGetUnitZ                                 takes unit whichUnit returns real