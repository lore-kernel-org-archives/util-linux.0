Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f41.google.com ([74.125.82.41]:33353 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbaIPUdL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 16 Sep 2014 16:33:11 -0400
Received: by mail-wg0-f41.google.com with SMTP id k14so409248wgh.12
        for <util-linux@vger.kernel.org>; Tue, 16 Sep 2014 13:33:10 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
Date: Tue, 16 Sep 2014 21:33:07 +0100 (BST)
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 05/17] newgrp: use xgetpass() and memset_s() to group
 password validation
In-Reply-To: <20140912084451.GT21325@x2.net.home>
Message-ID: <alpine.LNX.2.03.1409162127010.3712@kerolasa-home>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi> <1410093785-17537-6-git-send-email-kerolasa@iki.fi> <20140912084451.GT21325@x2.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, 12 Sep 2014, Karel Zak wrote:

> On Sun, Sep 07, 2014 at 01:42:53PM +0100, Sami Kerola wrote:
>> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
>> ---
>>  login-utils/newgrp.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> If we really want to support passwords for groups then it would be
> better to add support for this to PAM. But it seems it's so crazy and
> unnecessary that nobody has been motivated to do this change in last
> 20 years.
>
> It would be better to remove support for /etc/gshadow from newgrp at
> all.

Either PAM does not support group passwords, or I misread docs & git 
checkout.  What comes to gshadow itself I do agree finding an example when 
using them would be useful is hard. Then again the support for group 
passwords has been around for long time and even opengroup mentions 
authorizations.

http://pubs.opengroup.org/onlinepubs/009695299/utilities/newgrp.html

So that in mind I changed the newgrp change somewhat. Here is first 
alteration.

--->8----
From: Sami Kerola <kerolasa@iki.fi>
Date: Sun, 14 Sep 2014 17:29:54 +0100
Subject: [PATCH 15/17] newgrp: use libc function to read gshadow if it is available

The glib versionf of getsgnam() is using /etc/nsswitch.conf, allowing the
group passwords to come from external database.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
  configure.ac         |  1 +
  login-utils/newgrp.c | 11 +++++++++++
  2 files changed, 12 insertions(+)

diff --git a/configure.ac b/configure.ac
index 5b558ec..c84814f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -302,6 +302,7 @@ AC_CHECK_FUNCS([ \
  	getexecname \
  	getmntinfo \
  	getrlimit \
+	getsgnam \
  	inotify_init \
  	inotify_init1 \
  	jrand48 \
diff --git a/login-utils/newgrp.c b/login-utils/newgrp.c
index 55dad1b..d492f23 100644
--- a/login-utils/newgrp.c
+++ b/login-utils/newgrp.c
@@ -28,6 +28,10 @@
  # include <crypt.h>
  #endif

+#ifdef HAVE_GETSGNAM
+# include <gshadow.h>
+#endif
+
  #include "c.h"
  #include "closestream.h"
  #include "nls.h"
@@ -37,6 +41,12 @@
  /* try to read password from gshadow */
  static char *get_gshadow_pwd(char *groupname)
  {
+#ifdef HAVE_GETSGNAM
+	struct sgrp *sgrp;
+
+	sgrp = getsgnam(groupname);
+	return sgrp ? xstrdup(sgrp->sg_passwd) : NULL;
+#else
  	char buf[BUFSIZ];
  	char *pwd = NULL;
  	FILE *f;
@@ -69,6 +79,7 @@ static char *get_gshadow_pwd(char *groupname)
  	}
  	fclose(f);
  	return pwd ? xstrdup(pwd) : NULL;
+#endif	/* HAVE_GETSGNAM */
  }

  static int allow_setgid(struct passwd *pe, struct group *ge)
-- 
2.1.0

