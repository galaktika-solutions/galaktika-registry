#!/usr/bin/env python3

import logging
import os
import signal

from periodtask import TaskList, Task, SKIP
from periodtask.mailsender import MailSender


logging.basicConfig(level=logging.DEBUG)

# we send STDOUT and STDERR to these loggers
stdout_logger = logging.getLogger('periodtask.stdout')
stderr_logger = logging.getLogger('periodtask.stderr')

for line in open('/.secret', 'r'):
    if "EMAIL_USER" in line:
        user = line.replace('EMAIL_USER=', '').replace('\n', '')
    elif "EMAIL_PASSWORD" in line:
        password = line.replace('EMAIL_PASSWORD=', '').replace('\n', '')


send_success = MailSender(
    os.environ.get('EMAIL_HOST'),
    int(os.environ.get('EMAIL_PORT')),
    os.environ.get('EMAIL_FROM'),
    os.environ.get('EMAIL_RECIPIENT'),
    timeout=10,
    use_ssl=True,
    use_tls=False,
    username=user,
    password=password
).send_mail


tasks = TaskList(
    Task(
        'curator',
        ('./registry.sh', '-curator'),
        ['0 0 0 * * * UTC'],
        mail_success=None,
        mail_failure=send_success,
        mail_skipped=send_success,
        mail_delayed=None,
        wait_timeout=5,
        stop_signal=signal.SIGTERM,
        max_lines=10,
        run_on_start=True,
        policy=SKIP,
        template_dir='/tmp',
        stdout_logger=stdout_logger,
        stdout_level=logging.DEBUG,
        stderr_logger=stderr_logger,
        stderr_level=logging.WARNING,
        cwd=None
    ),
)

tasks.start()
