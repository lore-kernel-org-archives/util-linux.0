Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:63848 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbaLSJa0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 19 Dec 2014 04:30:26 -0500
Received: by mail-wg0-f43.google.com with SMTP id l18so801330wgh.2
        for <util-linux@vger.kernel.org>; Fri, 19 Dec 2014 01:30:24 -0800 (PST)
Date: Fri, 19 Dec 2014 09:30:23 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 05/16] lslogins: reject unknown time format arguments
In-Reply-To: <20141215092852.GX19904@x2.net.home>
Message-ID: <alpine.LNX.2.03.1412190927340.8955@iki.fi>
References: <1418579052-29386-1-git-send-email-kerolasa@iki.fi> <1418579052-29386-6-git-send-email-kerolasa@iki.fi> <20141215092852.GX19904@x2.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 15 Dec 2014, Karel Zak wrote:

> On Sun, Dec 14, 2014 at 05:44:01PM +0000, Sami Kerola wrote:
>> @@ -1398,8 +1388,18 @@ int main(int argc, char *argv[])
>>  			break;
>>  		case OPT_TIME_FMT:
>>  			{
>> +				struct lslogins_timefmt {
>> +					const char *name;
>> +					const int val;
>> +				};
>> +				const struct lslogins_timefmt timefmts[] = {
>
> static const ....

Corrected.

>> +					{ "iso", TIME_ISO },
>> +					{ "full", TIME_FULL },
>> +					{ "short", TIME_SHORT },
>> +				};
>>  				size_t i;
>>
>> +				ctl->time_mode = TIME_INVALID;
>>  				for (i = 0; i < ARRAY_SIZE(timefmts); i++) {
>>  					if (strcmp(timefmts[i].name, optarg) == 0) {
>>  						ctl->time_mode = timefmts[i].val;
>> @@ -1407,7 +1407,7 @@ int main(int argc, char *argv[])
>>  					}
>>  				}
>>  				if (ctl->time_mode == TIME_INVALID)
>> -					usage(stderr);
>> +					errx(EXIT_FAILURE, _("unknown time format: %s"), optarg);
>
> This is not elegant solution, it would be better to move all the code
> to small function parse_time_mode() and keep the main() less "crowded".

Good idea. Here is updated version of the change.

https://github.com/kerolasa/lelux-utiliteetit/commit/cdf3896a0502b2773323ec293ccb4dfdbfc87cf8

--->8----
From: Sami Kerola <kerolasa@iki.fi>
Date: Sat, 13 Dec 2014 17:11:04 +0000
Subject: [PATCH 05/18] lslogins: reject unknown time format arguments

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
  login-utils/lslogins.c | 40 +++++++++++++++++++---------------------
  1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index cacf83c..5e1ef17 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -1180,16 +1180,25 @@ static void free_user(void *f)
  	free(u);
  }

-struct lslogins_timefmt {
-	const char *name;
-	int val;
-};
+static int parse_time_mode(const char *optarg)
+{
+	struct lslogins_timefmt {
+		const char *name;
+		const int val;
+	};
+	static const struct lslogins_timefmt timefmts[] = {
+		{"iso", TIME_ISO},
+		{"full", TIME_FULL},
+		{"short", TIME_SHORT},
+	};
+	size_t i;

-static struct lslogins_timefmt timefmts[] = {
-	{ "short", TIME_SHORT },
-	{ "full", TIME_FULL },
-	{ "iso", TIME_ISO },
-};
+	for (i = 0; i < ARRAY_SIZE(timefmts); i++) {
+		if (strcmp(timefmts[i].name, optarg) == 0)
+			return timefmts[i].val;
+	}
+	errx(EXIT_FAILURE, _("unknown time format: %s"), optarg);
+}

  static void __attribute__((__noreturn__)) usage(FILE *out)
  {
@@ -1397,18 +1406,7 @@ int main(int argc, char *argv[])
  			ctl->noheadings = 1;
  			break;
  		case OPT_TIME_FMT:
-			{
-				size_t i;
-
-				for (i = 0; i < ARRAY_SIZE(timefmts); i++) {
-					if (strcmp(timefmts[i].name, optarg) == 0) {
-						ctl->time_mode = timefmts[i].val;
-						break;
-					}
-				}
-				if (ctl->time_mode == TIME_INVALID)
-					usage(stderr);
-			}
+			ctl->time_mode = parse_time_mode(optarg);
  			break;
  		case 'V':
  			printf(UTIL_LINUX_VERSION);
-- 
2.2.0

