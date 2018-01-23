Return-Path: lbukata@gmail.com
Subject: Re: Patch to add support for lz4hc and deflate optimization
 algorithms in zramctl.
To: Timofey Titovets <nefelim4ag@gmail.com>
Cc: util-linux <util-linux@vger.kernel.org>, Karel Zak <kzak@redhat.com>
References: <90fb3b4a-38b8-17fc-f1b6-03e8c23eb808@gmail.com>
 <CAGqmi75B7yzQp-EWBnbjXgSpbNZAsXah1WtQqPUOE6_NjZRwhA@mail.gmail.com>
 <CAGqmi75=cWbRBxU-DkxyXffQSjy8f5jxA_Hx6oVqUrLU_sU9GA@mail.gmail.com>
From: Libor Bukata <lbukata@gmail.com>
Message-ID: <47fb6e30-50a8-29a2-810e-5c872f76813d@gmail.com>
Date: Tue, 23 Jan 2018 18:57:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAGqmi75=cWbRBxU-DkxyXffQSjy8f5jxA_Hx6oVqUrLU_sU9GA@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------D9CB47BCD58FECC9D3F70B9F"
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.
--------------D9CB47BCD58FECC9D3F70B9F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Thank you for your comments. I added the support for 842 compression
algorithm. The included patch is signed and tested on the latest
versions of both Git repositories:

git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git
git://github.com/karelzak/util-linux.git

I am not sure what you meant by: "Also, use
https://github.com/karelzak/util-linux and PR, .."
If it is important, please do not hesitate to provide me more
information in order to fix it.

Have a nice day,
Libor.

Dne 23.1.2018 v 14:21 Timofey Titovets napsal(a):
> Also, use https://github.com/karelzak/util-linux and PR,
> also add comment + Signed-off-by to patch.
>
> 2018-01-23 11:08 GMT+03:00 Timofey Titovets <nefelim4ag@gmail.com>:
>> https://patchwork.kernel.org/patch/9144717/
>>
>> I think your patch miss support of 842 algo
>>
>> 2018-01-22 23:45 GMT+03:00 Libor Bukata <lbukata@gmail.com>:
>>> Dear developers of Linux utils,
>>>
>>> I extended the zramctl utility to handle also lz4hc and deflate formats.
>>> The patch is included in the attachment. Thank you in advance for your
>>> comments.
>>>
>>> Kind regards,
>>> Libor Bukata.
>>
>>
>> --
>> Have a nice day,
>> Timofey.
>
>


--------------D9CB47BCD58FECC9D3F70B9F
Content-Type: text/x-patch;
 name="0001-Added-the-support-for-lz4hc-deflate-and-842.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Added-the-support-for-lz4hc-deflate-and-842.patch"

>From 9b48fba08a630bd90c29078a621e2725fb0c940e Mon Sep 17 00:00:00 2001
From: Libor Bukata <lbukata@gmail.com>
Date: Tue, 23 Jan 2018 18:34:01 +0100
Subject: [PATCH] Added the support for lz4hc, deflate, and 842 compression
 algorithms in zramctl utility.

Signed-off-by: Libor Bukata <lbukata@gmail.com>
---
 sys-utils/zramctl.8 |  2 +-
 sys-utils/zramctl.c | 22 ++++++++++++++--------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/sys-utils/zramctl.8 b/sys-utils/zramctl.8
index 9ca2983b9..679a8a175 100644
--- a/sys-utils/zramctl.8
+++ b/sys-utils/zramctl.8
@@ -44,7 +44,7 @@ query the status of used zram devices.
 If no option is given, all non-zero size zram devices are shown.
 .SH OPTIONS
 .TP
-.BR \-a , " \-\-algorithm lzo" | lz4
+.BR \-a , " \-\-algorithm lzo" | lz4 | lz4hc | deflate | 842
 Set the compression algorithm to be used for compressing data in the zram device.
 .TP
 .BR \-f , " \-\-find"
diff --git a/sys-utils/zramctl.c b/sys-utils/zramctl.c
index fb64150d6..0331045c8 100644
--- a/sys-utils/zramctl.c
+++ b/sys-utils/zramctl.c
@@ -424,13 +424,18 @@ static void fill_table_row(struct libscols_table *tb, struct zram *z)
 			char *alg = sysfs_strdup(sysfs, "comp_algorithm");
 			if (!alg)
 				break;
-			if (strstr(alg, "[lzo]") == NULL) {
-				if (strstr(alg, "[lz4]") == NULL)
-					;
-				else
-					str = xstrdup("lz4");
-			} else
+
+			if (strstr(alg, "[lzo]") != NULL)
 				str = xstrdup("lzo");
+			else if (strstr(alg, "[lz4]") != NULL)
+				str = xstrdup("lz4");
+			else if (strstr(alg, "[lz4hc]") != NULL)
+				str = xstrdup("lz4hc");
+			else if (strstr(alg, "[deflate]") != NULL)
+				str = xstrdup("deflate");
+			else if (strstr(alg, "[842]") != NULL)
+				str = xstrdup("842");
+
 			free(alg);
 			break;
 		}
@@ -539,7 +544,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_("Set up and control zram devices.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -a, --algorithm lzo|lz4   compression algorithm to use\n"), out);
+	fputs(_(" -a, --algorithm lzo|lz4|lz4hc|deflate|842   compression algorithm to use\n"), out);
 	fputs(_(" -b, --bytes               print sizes in bytes rather than in human readable format\n"), out);
 	fputs(_(" -f, --find                find a free device\n"), out);
 	fputs(_(" -n, --noheadings          don't print headings\n"), out);
@@ -611,7 +616,8 @@ int main(int argc, char **argv)
 
 		switch (c) {
 		case 'a':
-			if (strcmp(optarg,"lzo") && strcmp(optarg,"lz4"))
+			if (strcmp(optarg,"lzo") && strcmp(optarg,"lz4") && strcmp(optarg,"lz4hc")
+					&& strcmp(optarg,"deflate") && strcmp(optarg,"842"))
 				errx(EXIT_FAILURE, _("unsupported algorithm: %s"),
 					     optarg);
 			algorithm = optarg;
-- 
2.13.6


--------------D9CB47BCD58FECC9D3F70B9F--
