# THIS IS STILL UNDER CONSTRUCTION

> Roles is a terrible name for it and I think "Parts" would be a better name.  But I cannot change the name.

# Ansible Roles

Ansible Roles allow to create reusable parts.  something like a parameterized include or something like a Macro.

Together with [Jinja2 templating](templates.md) and [descripting Playbook structures](playbooks.md) for loops or similar
Ansible Roles offer some very powerful and straight forward way to express what you want or need.

> Jinja2 has its downsides, mostly how wrong quoting, missing blank negatively affects everything,
> and complex expressions work, but I like it a lot more than the templating offered by Puppet.

## Role structure

The role structure is the most uncommon thing for them.  To create a Role you need to keep a strict directory path discipline and use a predefined set of names.

```
roles/$ROLENAME/
  tasks/main.yml          # can include other files from there 
  handlers/main.yml       # things which can be triggered
  templates/config.j2     # Jinja2 template files
        templates/        #  <-- files for use with the template resource
            ntp.conf.j2   #  <------- templates end in .j2
        files/            #
            bar.txt       #  <-- files for use with the copy resource
            foo.sh        #  <-- script files for use with the script resource
        vars/             #
            main.yml      #  <-- variables associated with this role
        defaults/         #
            main.yml      #  <-- default lower priority variables for this role
        meta/             #
            main.yml      #  <-- role dependencies
        library/          # roles can also include custom modules
        module_utils/     # roles can also include custom module_utils
        lookup_plugins/   # or other types of plugins, like lookup in this case

    webtier/              # same kind of structure as "common" was above, done for the webtier role
    monitoring/           # ""
    fooapp/               # ""
