# monster_basicneeds
This script implements hunger and thirst status, they can be increased when eating bread or drinking water.

## Requirements
- [monster_status](https://github.com/ESX-Org/monster_status)

## Download & Installation

### Using [fvm](https://github.com/qlaffont/fvm-installer)
```
fvm install --save --folder=esx esx-org/monster_basicneeds
```

### Using Git
```
cd resources
git clone https://github.com/ESX-Org/monster_basicneeds [esx]/monster_basicneeds
```

### Manually
- Download https://github.com/ESX-Org/monster_basicneeds/archive/master.zip
- Put it in the `[esx]` directory


## Installation
- Import `monster_basicneeds.sql` in your database
- Add this in your server.cfg :

```
start monster_basicneeds
```

# Legal
### License
monster_basicneeds - thirst and hunger system

Copyright (C) 2015-2020 Jérémie N'gadi

This program Is free software: you can redistribute it And/Or modify it under the terms Of the GNU General Public License As published by the Free Software Foundation, either version 3 Of the License, Or (at your option) any later version.

This program Is distributed In the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty Of MERCHANTABILITY Or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License For more details.

You should have received a copy Of the GNU General Public License along with this program. If Not, see http://www.gnu.org/licenses/.