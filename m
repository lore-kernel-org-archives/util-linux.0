Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.186]:53301 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410Ab2FFNb5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 6 Jun 2012 09:31:57 -0400
Message-ID: <4FCF5BB9.4070602@bernhard-voelker.de>
Date: Wed, 06 Jun 2012 15:31:37 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: kerolasa@gmail.com
CC: Sami Kerola <kerolasa@iki.fi>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] su: remove unimplemented options -u and -v
References: <4FCF4D1E.5020909@bernhard-voelker.de> <CAG27Bk0DupeHs8+OFAPnXuuJi7oJyw-xCVHRvxsXDDFwSwqbGw@mail.gmail.com>
In-Reply-To: <CAG27Bk0DupeHs8+OFAPnXuuJi7oJyw-xCVHRvxsXDDFwSwqbGw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 06/06/2012 02:47 PM, Sami Kerola wrote:
> On Wed, Jun 6, 2012 at 2:29 PM, Bernhard Voelker
> <mail@bernhard-voelker.de> wrote:
>> From 3e7fedef769fe0cfb71833ec51c3f897e99b0f7c Mon Sep 17 00:00:00 2001
>> From: Bernhard Voelker <mail@bernhard-voelker.de>
>> Date: Wed, 6 Jun 2012 14:26:59 +0200
>> Subject: [PATCH] su: remove unimplemented options -u and -v
> 
> Hi Berny,
> 
> If you want to remove short options I recommend to assign greater than
> character value to switch. See term-utils/agetty.c and search for
> _OPTION as an example.

Hi Sami,

thank you for the review. I was searching for similar cases in U-L,
but --help and --version don't seem to be handled very consistently.

Here's a new patch.

Have a nice day,
Berny

>From 2fdc309659a91343da451bf9d6e17edd4830d895 Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Wed, 6 Jun 2012 15:30:52 +0200
Subject: [PATCH] su: remove unimplemented options -u and -v

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 login-utils/su.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/login-utils/su.c b/login-utils/su.c
index 0f535b9..20cc929 100644
--- a/login-utils/su.c
+++ b/login-utils/su.c
@@ -100,6 +100,10 @@ static bool _pam_cred_established;
 static sig_atomic_t volatile caught_signal = false;
 static pam_handle_t *pamh = NULL;

+enum {
+  VERSION_OPTION = CHAR_MAX + 1,
+  HELP_OPTION
+};

 static struct option const longopts[] =
 {
@@ -109,8 +113,8 @@ static struct option const longopts[] =
   {"login", no_argument, NULL, 'l'},
   {"preserve-environment", no_argument, NULL, 'p'},
   {"shell", required_argument, NULL, 's'},
-  {"help", no_argument, 0, 'u'},
-  {"version", no_argument, 0, 'v'},
+  {"help", no_argument, 0, HELP_OPTION},
+  {"version", no_argument, 0, VERSION_OPTION},
   {NULL, 0, NULL, 0}
 };

@@ -661,10 +665,8 @@ Change the effective user id and group id to that of USER.\n\
   -m, --preserve-environment   do not reset environment variables\n\
   -p                           same as -m\n\
   -s, --shell=SHELL            run SHELL if /etc/shells allows it\n\
-"), stdout);
-      fputs (_(" -u, --help     display this help and exit\n"), stdout);
-      fputs (_(" -v, --version  output version information and exit\n"), stdout);
-      fputs (_("\
+      --help     display this help and exit\n\
+      --version  output version information and exit\n\
 \n\
 A mere - implies -l.   If USER not given, assume root.\n\
 "), stdout);
@@ -727,10 +729,10 @@ main (int argc, char **argv)
 	  shell = optarg;
 	  break;

-	case 'u':
+	case HELP_OPTION:
 	  usage(0);

-	case 'v':
+	case VERSION_OPTION:
 	  printf(UTIL_LINUX_VERSION);
 	  exit(EXIT_SUCCESS);

-- 
1.7.7

