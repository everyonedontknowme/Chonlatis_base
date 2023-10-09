# monster_identity

## Requirements
* Dependencies For Full Functionality
  * [monster_skin](https://github.com/ESX-Org/monster_skin)
  * [monster_policejob](https://github.com/ESX-Org/monster_policejob)
  * [monster_society](https://github.com/ESX-Org/monster_society)

## Download & Installation

### Using [fvm](https://github.com/qlaffont/fvm-installer)
```
fvm install --save --folder=esx esx-org/monster_identity
```

### Using Git
```
cd resources
git clone https://github.com/ESX-Org/monster_identity [esx]/monster_identity
```

### Manually
- Download https://github.com/ESX-Org/monster_identity/archive/master.zip
- Put it in the `[esx]` directory

## Installation
- Import `monster_identity.sql` in your database
- Add this to your `server.cfg`:

```
start monster_identity
```

- If you are using monster_policejob or monster_society, you need to enable the following in the scripts' `config.lua`:
```Config.EnableESXIdentity          = true```

### Commands
```
/register
/charlist
/charselect
/chardel
```

# Legal
### License
monster_identity - rp characters

Copyright (C) 2015-2020 Jérémie N'gadi

This program Is free software: you can redistribute it And/Or modify it under the terms Of the GNU General Public License As published by the Free Software Foundation, either version 3 Of the License, Or (at your option) any later version.

This program Is distributed In the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty Of MERCHANTABILITY Or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License For more details.

You should have received a copy Of the GNU General Public License along with this program. If Not, see http://www.gnu.org/licenses/.
