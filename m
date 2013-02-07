Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ie0-f178.google.com ([209.85.223.178]:42065 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab3BGGWj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 7 Feb 2013 01:22:39 -0500
Received: by mail-ie0-f178.google.com with SMTP id c13so3001114ieb.23
        for <util-linux@vger.kernel.org>; Wed, 06 Feb 2013 22:22:37 -0800 (PST)
From: Cody Maloney <cmaloney@theoreticalchaos.com>
To: util-linux@vger.kernel.org
Cc: mitr@redhat.com, Cody Maloney <cmaloney@theoreticalchaos.com>
Subject: [PATCH v3 0/4] Add support for using libuser to chsh and chfn
Date: Wed,  6 Feb 2013 23:22:17 -0700
Message-Id: <1360218141-4463-1-git-send-email-cmaloney@theoreticalchaos.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I believe these are finally ready for merging. Freshly rebased.
Patches 3 and 4 could be merged, but I think it's a little 
cleaner to read/review with the changes seperate.

Version 3 of the patches, incorporating all changes suggested to 
this point. Only changes from v2 are fixing the error string and
dropping initgroups in patch 3/4.

Tested:
Building and running both with and without libuser support enabled,
with a valid password, invalid password, and running as root.

Cody Maloney (4):
  chsh-chfn: Add flag for enabling/disabling libuser support.
  chsh-chfn: Move pam auth to its own function, factoring out common
    code
  chsh: Add libuser support
  chfn: Add libuser support

 configure.ac              | 17 ++++++++++
 login-utils/Makemodule.am | 10 ++++++
 login-utils/auth.c        | 47 ++++++++++++++++++++++++++++
 login-utils/auth.h        | 13 ++++++++
 login-utils/chfn.c        | 58 +++++++++++++++-------------------
 login-utils/chsh.c        | 53 ++++++++++++++-----------------
 login-utils/libuser.c     | 80 +++++++++++++++++++++++++++++++++++++++++++++++
 login-utils/libuser.h     | 14 +++++++++
 8 files changed, 229 insertions(+), 63 deletions(-)
 create mode 100644 login-utils/auth.c
 create mode 100644 login-utils/auth.h
 create mode 100644 login-utils/libuser.c
 create mode 100644 login-utils/libuser.h

-- 
1.8.1

