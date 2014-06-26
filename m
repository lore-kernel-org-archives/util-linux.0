Return-Path: mail@bernhard-voelker.de
Message-ID: <53AC0E89.4020300@bernhard-voelker.de>
Date: Thu, 26 Jun 2014 14:14:01 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>,
        =?ISO-8859-1?Q?P=E1draig_Brady?=
 <P@draigBrady.com>
CC: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: fallocate: --punch option parsing error diagnostics irritating
References: <53AB2E36.5060405@bernhard-voelker.de> <20140626101009.GD30418@x2.net.home> <53ABFB5A.9020005@draigBrady.com> <20140626110702.GA750@x2.net.home>
In-Reply-To: <20140626110702.GA750@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <util-linux.vger.kernel.org>

On 06/26/2014 01:07 PM, Karel Zak wrote:
>   Applied, thanks.

Thanks!

Now, the optind check is too late in those 2 invalid cases:

   $ ./fallocate
   fallocate: no length argument specified

   $ ./fallocate file1 file2
   fallocate: no length argument specified

The patch below fixes it.

BTW: I think fallocate(1) shouldn't open(...,O_CREAT)
with -d, -p, and maybe with -z, should it?

Have a nice day,
Berny

 From d4b880a188517e12aead021bcee01630e2893e03 Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Thu, 26 Jun 2014 14:09:47 +0200
Subject: [PATCH] fallocate: fix check of number of arguments

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
  sys-utils/fallocate.c | 18 +++++++++---------
  1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index 91dee41..5abe3eb 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -339,6 +339,15 @@ int main(int argc, char **argv)
  			break;
  		}
  	}
+
+	if (optind == argc)
+		errx(EXIT_FAILURE, _("no filename specified"));
+
+	filename = argv[optind++];
+
+	if (optind != argc)
+		errx(EXIT_FAILURE, _("unexpected number of arguments"));
+
  	if (dig) {
  		/* for --dig-holes the default is analyze all file */
  		if (length == -2LL)
@@ -354,15 +363,6 @@ int main(int argc, char **argv)
  	}
  	if (offset < 0)
  		errx(EXIT_FAILURE, _("invalid offset value specified"));
-	if (optind == argc)
-		errx(EXIT_FAILURE, _("no filename specified."));
-
-	filename = argv[optind++];
-
-	if (optind != argc) {
-		warnx(_("unexpected number of arguments"));
-		usage(stderr);
-	}

  	fd = open(filename, O_RDWR|O_CREAT, 0644);
  	if (fd < 0)
-- 
1.8.4.2
