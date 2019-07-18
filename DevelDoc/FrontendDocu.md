# Carme Frontend
The *Carme* Frontend Server is build on the [Django](https://www.djangoproject.com/) framework.

## Structure
```
.
├── carme-base
│   ├── admin.py
│   ├── apps.py
│   ├── dbrouters.py
│   ├── forms.py
│   ├── __init__.py
│   ├── migrations
│   ├── models.py
│   ├── templatetags
│   │   ├── __init__.py
│   ├── tests.py
│   ├── urls.py
│   └── views.py
├── manage.py
├── media
│   └── wiki
├── SSL
│   ├── frontend.crt
│   ├── frontend.csr
│   └── frontend.key
├── static
├── templates
│   ├── 404.html
│   ├── 503.html
│   ├── admin
│   │   ├── base_site.html
│   │   └── base_site.html~
│   ├── admin_cluster_status.html
│   ├── admin_job_table.html
│   ├── base.html
│   ├── blocks
│   │   ├── admin_footer.html
│   │   ├── footer.html
│   │   ├── java_scripts.html
│   │   ├── java_scripts.html!
│   │   ├── java_scripts_v2.html
│   │   ├── maintenance.html
│   │   ├── messages.html
│   │   ├── start_job.html
│   │   ├── system_messages.html
│   │   └── test.html
│   ├── change_password.html
│   ├── home.html
│   ├── imagetable.html
│   ├── job_hist.html
│   ├── job_info.html
│   ├── jobs.html
│   ├── jobtable.html
│   ├── line_chart.html
│   ├── logged_out.html
│   ├── login.html
│   ├── message.html
│   ├── name.html
│   ├── nohup.out
│   ├── time_out.html
│   └── wiki
│       └── base.html
└── webfrontend
    ├── __init__.py
    ├── maintenance_mode_state.tx
    ├── settings.py
    ├── urls.py
    └── wsgi.py

```

## Key Components
The main functionality of the *Carme* frontend is implemented in the ***carme-base*** app,

