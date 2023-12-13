# What is a project

A project is a group, where members share the same compute resources and have access to common files and folders. 

By default, all users have one project called `My Project`. A Project on its own has no meaning unless a template is assigned to it. The template assigned to `My Project` has the same name as the user Linux group. Resources assigned to this template are set by the carme-administrator. In your dashboard (home page), you Jobs card shows the project information in the header, see Fig. 1.

![images/project-definition-1.png](images/project-definition1.png)


Users can create projects and request specific templates (resources) for their projects. When you set a project, a project folder is assigned to it. Only members of the project can access it.

## Characteristics
* Projects should be bound to specific tasks or groups in your organization. There should not be a generic project for all tasks.
* Projects have to approved by the administrator in order to be active
* Projects have an expiration date set by the administrator.
* Projects can have multiple templates
* Projects have fixed compute resources (i.e, number of jobs/nodes and accelerator types)
* Projects can have multiple users and a user can be a member of multiple projects.
* Projects have three levels of membership: owner, admins, and users.
    * The owner creates the project, and is the only one that can delete it
    * The admin adds / removes users.  A project can have multiple admins
    * The user is a member of the project with no admin rights 



