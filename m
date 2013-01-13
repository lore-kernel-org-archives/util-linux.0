Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ia0-f173.google.com ([209.85.210.173]:50017 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab3AMJMx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Jan 2013 04:12:53 -0500
Received: by mail-ia0-f173.google.com with SMTP id l29so88461iag.4
        for <util-linux@vger.kernel.org>; Sun, 13 Jan 2013 01:12:53 -0800 (PST)
From: Cody Maloney <cmaloney@theoreticalchaos.com>
To: util-linux@vger.kernel.org
Cc: mitr@redhat.com, Cody Maloney <cmaloney@theoreticalchaos.com>
Subject: [PATCH v2 0/4]  Add support for using libuser to chsh and chfn
Date: Sun, 13 Jan 2013 02:12:20 -0700
Message-Id: <1358068345-773-1-git-send-email-cmaloney@theoreticalchaos.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Builds on v1 addressing comments. Factors out some of the common code
between chsh and chfn (auth.c, libuser.c), hides almost all of the
libuser interaction in libuser.c

The last two patches can/should probably be squashed into one commit
for committing to the repository.

Cody Maloney (4):
  chsh-chfn: Add flag for enabling/disabling libuser support.
  chsh-chfn: Move pam auth to its own function, factoring out common
    code
  chsh: Add libuser support
  chfn: Add libuser support

 configure.ac              | 17 ++++++++++
 login-utils/Makemodule.am | 10 ++++++
 login-utils/auth.c        | 47 ++++++++++++++++++++++++++
 login-utils/auth.h        | 13 ++++++++
 login-utils/chfn.c        | 58 ++++++++++++++------------------
 login-utils/chsh.c        | 55 ++++++++++++++-----------------
 login-utils/libuser.c     | 84 +++++++++++++++++++++++++++++++++++++++++++++++
 login-utils/libuser.h     | 14 ++++++++
 8 files changed, 234 insertions(+), 64 deletions(-)
 create mode 100644 login-utils/auth.c
 create mode 100644 login-utils/auth.h
 create mode 100644 login-utils/libuser.c
 create mode 100644 login-utils/libuser.h

-- 
1.8.1

