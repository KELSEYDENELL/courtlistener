# Generated by Django 3.1.7 on 2021-05-26 21:56

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Webhook',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('date_created', models.DateTimeField(auto_now_add=True, db_index=True, help_text='The moment when the item was created.')),
                ('date_modified', models.DateTimeField(auto_now=True, db_index=True, help_text='The last moment when the item was modified. A value in year 1750 indicates the value is unknown')),
                ('event_type', models.IntegerField(choices=[(1, 'RECAP email received'), (2, 'Alert triggered')], help_text='The event type that triggers the webhook.')),
                ('url', models.URLField(help_text='The URL that receives a POST request from the webhook.', max_length=2000)),
                ('enabled', models.BooleanField(default=False, help_text='An on/off switch for the webhook.')),
                ('version', models.IntegerField(default=1, help_text='The specific version of the webhook provisioned.')),
                ('failure_count', models.IntegerField(default=0, help_text='The number of failures (400+ status) responses the webhook has received.')),
                ('user', models.ForeignKey(help_text='The user that has provisioned the webhook.', on_delete=django.db.models.deletion.CASCADE, related_name='webhooks', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='WebhookEvent',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('date_created', models.DateTimeField(auto_now_add=True, db_index=True, help_text='The moment when the item was created.')),
                ('date_modified', models.DateTimeField(auto_now=True, db_index=True, help_text='The last moment when the item was modified. A value in year 1750 indicates the value is unknown')),
                ('status_code', models.IntegerField(choices=[(100, 'Continue'), (101, 'Switching Protocols'), (102, 'Processing'), (200, 'Ok'), (201, 'Created'), (202, 'Accepted'), (203, 'Non Authoritative Information'), (204, 'No Content'), (205, 'Reset Content'), (206, 'Partial Content'), (207, 'Multi Status'), (208, 'Already Reported'), (226, 'Im Used'), (300, 'Multiple Choices'), (301, 'Moved Permanently'), (302, 'Found'), (303, 'See Other'), (304, 'Not Modified'), (305, 'Use Proxy'), (307, 'Temporary Redirect'), (308, 'Permanent Redirect'), (400, 'Bad Request'), (401, 'Unauthorized'), (402, 'Payment Required'), (403, 'Forbidden'), (404, 'Not Found'), (405, 'Method Not Allowed'), (406, 'Not Acceptable'), (407, 'Proxy Authentication Required'), (408, 'Request Timeout'), (409, 'Conflict'), (410, 'Gone'), (411, 'Length Required'), (412, 'Precondition Failed'), (413, 'Request Entity Too Large'), (414, 'Request Uri Too Long'), (415, 'Unsupported Media Type'), (416, 'Requested Range Not Satisfiable'), (417, 'Expectation Failed'), (421, 'Misdirected Request'), (422, 'Unprocessable Entity'), (423, 'Locked'), (424, 'Failed Dependency'), (426, 'Upgrade Required'), (428, 'Precondition Required'), (429, 'Too Many Requests'), (431, 'Request Header Fields Too Large'), (451, 'Unavailable For Legal Reasons'), (500, 'Internal Server Error'), (501, 'Not Implemented'), (502, 'Bad Gateway'), (503, 'Service Unavailable'), (504, 'Gateway Timeout'), (505, 'Http Version Not Supported'), (506, 'Variant Also Negotiates'), (507, 'Insufficient Storage'), (508, 'Loop Detected'), (510, 'Not Extended'), (511, 'Network Authentication Required')], help_text='The HTTP status code received when the webhook event was created.')),
                ('content', models.JSONField(help_text='The content of the outgoing body in the POST request.')),
                ('response', models.TextField(help_text='The response received from the POST request.')),
                ('webhook', models.ForeignKey(help_text='The Webhook this event is associated with.', on_delete=django.db.models.deletion.CASCADE, related_name='webhook_events', to='api.webhook')),
            ],
            options={
                'abstract': False,
            },
        ),
    ]
