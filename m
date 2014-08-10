Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:33125 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbaHJL4Q (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Aug 2014 07:56:16 -0400
Received: by mail-wg0-f43.google.com with SMTP id l18so7274385wgh.26
        for <util-linux@vger.kernel.org>; Sun, 10 Aug 2014 04:56:15 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 0/5] logger: remove use of libc openlog and other small changes
Date: Sun, 10 Aug 2014 12:56:06 +0100
Message-Id: <1407671771-29745-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

In commit eea331abd7159432d8f45f978b2fbac19330ce48 I added an option to
use ppid instead of pid in logger message.  That change worked only when
logging remotely, because the libc syslog(3) call does not support ppid
printing.  For a moment I thought it might be possible to change libc to
have such feature, before realizing there are more than one libc
implementation and making all of them work is hopeless.  So I decided to
avoid the syslog(3) all together, and make syslog_local() to be as close
copy of glibc syslog(3) format as possible with support for ppid
printing.

Rest of the changes in this series are not technically that interesting,
and only remaining thing worth to mention is a small write out, requested
by Karel, about logger changes.

http://www.iki.fi/kerolasa/logger.html


The following changes since commit cd8414f7a13aca0b3ea150b473b83f00819b312f:

  cfdisk: move curs_set(1) to ui_end() (2014-08-06 15:39:27 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git logger

for you to fetch changes up to f0757ac355b42baab1e477345690260db651e693:

  docs: mentintion default udp and tcp ports logger is using (2014-08-09 09:13:25 +0100)

----------------------------------------------------------------
Sami Kerola (5):
      logger: allow use of --id=ppid when logging locally
      logger: remove openlog(3) options
      logger: optimize string initializations
      logger: set function arguments read-only when possible
      docs: mentintion default udp and tcp ports logger is using

 misc-utils/logger.1 |  7 +++++
 misc-utils/logger.c | 84 +++++++++++++++++++++++++++++++++--------------------
 2 files changed, 60 insertions(+), 31 deletions(-)

-- 
2.0.4

