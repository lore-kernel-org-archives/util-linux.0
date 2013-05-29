Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:65197 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965239Ab3E2JkZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 29 May 2013 05:40:25 -0400
Date: Wed, 29 May 2013 11:40:10 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        10317@debbugs.gnu.org
Subject: Re: su: -l and -p should not be used together
Message-ID: <20130529094010.GF30341@x2.net.home>
References: <519DF601.4090700@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <519DF601.4090700@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 23, 2013 at 12:57:05PM +0200, Bernhard Voelker wrote:
> A while ago, there has been a bug report to coreutils regarding
> the unlucky use of the -p and the -l option (or a bare "-") with su:
>   http://bugs.gnu.org/10317
> 
> As su is not part of coreutils anymore, I'm hereby closing the bug
> there, and forward this issue to util-linux where su is now maintained.
> 
> @Karel:
> do you think it's worth a warning/error?
> However, the agreement was that the behaviour should at least
> be documented.

Thanks for the report, I have added note to the man page as well as
warning to the code.

    Karel

>From 3e5c0a2db233b726ca80d37aad9eeca8bae144d4 Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Wed, 29 May 2013 11:32:58 +0200
Subject: [PATCH] su: ignore --preserve-environment, it's mutually exclusive to
 --login

Addresses: http://bugs.gnu.org/10317
Reported-by: Bernhard Voelker <mail@bernhard-voelker.de>
Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/su-common.c | 5 +++++
 login-utils/su.1        | 1 +
 2 files changed, 6 insertions(+)

diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index ba2a616..a41d015 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -810,6 +810,11 @@ su_main (int argc, char **argv, int mode)
       ++optind;
     }
 
+  if (simulate_login && !change_environment) {
+    warnx(_("ignore --preserve-environment, it's mutually exclusive to --login."));
+    change_environment = true;
+  }
+
   switch (su_mode) {
   case RUNUSER_MODE:
     if (runuser_user) {
diff --git a/login-utils/su.1 b/login-utils/su.1
index c82b941..eab1a6f 100644
--- a/login-utils/su.1
+++ b/login-utils/su.1
@@ -98,6 +98,7 @@ Preserves the whole environment, ie does not set
 .B USER
 nor
 .BR LOGNAME .
+The option is ignored if the option \fB\-\-login\fR is specified.
 .TP
 \fB\-s\fR \fISHELL\fR, \fB\-\-shell\fR=\fISHELL\fR
 Runs the specified shell instead of the default.  The shell to run is
-- 
1.8.1.4


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
