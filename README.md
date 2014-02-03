corsis_create_users Cookbook
============================
This cookbook creates accounts for your favorite sysadmins.

Requirements
------------
#### packages
- `s3` - `corsis_create_users` needs s3 to download ssh public keys.

Attributes
----------
```
    "meta-bucket": "fhqwhgads-meta",
    "corsis_create_users": {
        "corsis": {
            "gid": 2001,
            "users": {
                "atonns": {
                    "fullname": "Anthony Tonns",
                    "uid": 2001
                },
                "lherold": {
                    "fullname": "Leonard Herold",
                    "uid": 2002
                },
                "jkaplan": {
                    "fullname": "Jeffrey Kaplan",
                    "uid": 2003
                }
            }
        }
    },
```

Usage
-----
#### corsis_create_users::default

1. upload ssh public keys to `s3://fhqwhgads-meta/common/ssh-public-keys/#{username}.pub`
2. include `corsis_create_users` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[corsis_create_users]"
  ]
}
```


Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your changes
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Anthony Tonns <atonns@corsis.com>

Copyright 2014 Corsis
http://www.corsis.com/

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

