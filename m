Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:59773 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754866AbaGVWBI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jul 2014 18:01:08 -0400
Received: by mail-wg0-f43.google.com with SMTP id l18so275127wgh.26
        for <util-linux@vger.kernel.org>; Tue, 22 Jul 2014 15:01:06 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi, Kodiak Firesmith <ksf@sei.cmu.edu>
Subject: [PATCH 00/10] pull: logger changes
Date: Tue, 22 Jul 2014 23:00:49 +0100
Message-Id: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Couple weeks I wrote few logger(1) changes that has been lying in my git
repo waiting release to happen.  Now when the v2.25 is out it's time to
consider these changes.

Some of the changes are inspired by request from Kodiak, who is CC'd with
them.  He approached me after rc1 release that could I add fully
qualified hostname to logger's remote server logging.  When I looked
syslog related RFC's I realized the old BSD syslog protocol (rfc 3164)
does not seem to cover the fqdn case.  So supporting more recent protocol
(rfc 5424) felt like a good idea.  Here is a example of rfc 5424 logger
line after syslog-ng received it.

Jun 28 14:41:02 127.0.0.1 1 2014-06-28T14:41:02.762100+0100 kerolasa.example.com tag - [timeQuality tzKnown="1" isSynced="1" syncAccuracy="506435"] message

The additional ISO-8601 style time stamp and time quality markups are
enabled by default.  Plus I am proposing to use the new format as default
when logging to remote server, with an option --rfc3164 to revert to old
format when needed.  Maybe that is a step too far, or maybe not.  Either
way comments, opinions, request for further changes, and such would be
nice to hear.

Sami Kerola (10):
  logger: ensure program writes everything to syslog file descriptor
  logger: fix indentation issues
  logger: do not rely only getlogin(3) telling who ran the command
  logger: refactor long if clause
  docs: make logger.1 facilities and levels easier to read
  logger: add function pointer to choose how logging is done
  logger: add rfc5424 support
  docs: add logger protocol notes to manual page
  logger: add process --id=parent optional argument
  logger: make --stderr print remote server messages

 audit_getloginuid      |   0
 bash-completion/logger |   2 +-
 misc-utils/logger.1    |  98 ++++++++++++----
 misc-utils/logger.c    | 300 ++++++++++++++++++++++++++++++++++++-------------
 4 files changed, 295 insertions(+), 105 deletions(-)
 create mode 100644 audit_getloginuid

The following changes since commit a3c74d88e126552b457e964bfa288f39df8dd81a:

  swapon: don't print errors as data in smartcols table (2014-07-22 12:29:38 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git

for you to fetch changes up to c1f7a32499b162a33433160cb5778a3b59840757:

  logger: make --stderr print remote server messages (2014-07-22 22:29:04 +0100)

-- 
2.0.2

