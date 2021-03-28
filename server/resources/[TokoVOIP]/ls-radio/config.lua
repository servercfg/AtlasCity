Config = {}

Config.RestrictedChannels = 7 -- channels that are encrypted (EMS, Fire and police can be included there) if we give eg 10, channels from 1 - 10 will be encrypted
Config.enableCmd = false --  /radio command should be active or not (if not you have to carry the item "radio") true / false

Config.messages = {

  ['not_on_radio'] = 'Du er ikke forbundet til nogen radio',
  ['on_radio'] = 'Du er forbundet til radio: <b>',
  ['joined_to_radio'] = 'Du har joined radio: <b>',
  ['restricted_channel_error'] = 'Du har ikke adgang til denne radio!',
  ['you_on_radio'] = 'Du er allerede forbundet til radio: <b>',
  ['you_leave'] = 'Du afbrudte forbindelsen til radio: <b>'

}