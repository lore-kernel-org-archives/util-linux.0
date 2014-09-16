Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38670 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755111AbaIPUR6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 16 Sep 2014 16:17:58 -0400
Received: by mail-wi0-f178.google.com with SMTP id ho1so34183wib.11
        for <util-linux@vger.kernel.org>; Tue, 16 Sep 2014 13:17:57 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
Date: Tue, 16 Sep 2014 21:17:54 +0100 (BST)
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 5/6] renice: fix numeric uid argument parsing
In-Reply-To: <20140912080354.GR21325@x2.net.home>
Message-ID: <alpine.LNX.2.03.1409162114110.3712@kerolasa-home>
References: <1410002693-16540-1-git-send-email-kerolasa@iki.fi> <1410002693-16540-6-git-send-email-kerolasa@iki.fi> <20140912080354.GR21325@x2.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, 12 Sep 2014, Karel Zak wrote:

> On Sat, Sep 06, 2014 at 12:24:52PM +0100, Sami Kerola wrote:
>>  		if (which == PRIO_USER) {
>> -			register struct passwd *pwd = getpwnam(*argv);
>> +			struct passwd *pwd = getpwnam(*argv);
>>
>> -			if (pwd == NULL) {
>> -				warnx(_("unknown user %s"), *argv);
>> -				errs = 1;
>> -				continue;
>> +			if (pwd != NULL)
>> +				who = pwd->pw_uid;
>> +			else {
>> +				error_msg = _("unknown user %s");
>> +				goto numeric_pid;
>>  			}
>> -			who = pwd->pw_uid;
>>  		} else {
>> +			error_msg = _("bad value %s");
>> + numeric_pid:
>>  			who = strtol(*argv, &endptr, 10);
>>  			if (who < 0 || *endptr) {
>> -				warnx(_("bad value %s"), *argv);
>> +				warnx(error_msg, *argv);
>>  				errs = 1;
>>  				continue;
>>  			}
>
> The goto is unnecessary. Just set who = -1 by default.
>
>  who = -1;
>  if (which == PRIO_USER) {
>        ...
>        who = pwd->pw_uid;
>  }
>
>  if (who < 0) {
>        who = strtol(*argv, &endptr, 10);
>        ...
>        if (who < 0 || *endptr)
>            warnx(_("failed to parse %s argument"), idtype[which]);
>  }

Hi Karel,

Oh yes, I clearly over complicated the previous version. This ought to be 
a bit closer what one could consider acceptable.

--->8----
From: Sami Kerola <kerolasa@iki.fi>
Date: Fri, 5 Sep 2014 23:54:17 +0100
Subject: [PATCH 5/7] renice: fix numeric uid argument parsing

The following was inconflict with what usage() tells are valid option
arguments.

$ renice 1 -u 1000
renice: unknown user 1000
$ id
uid=1000(kerolasa) ...

Reviewed-by: Karel Zak <kzak@redhat.com>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
  sys-utils/renice.c | 10 ++++++----
  1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sys-utils/renice.c b/sys-utils/renice.c
index d83fc4a..a123ed1 100644
--- a/sys-utils/renice.c
+++ b/sys-utils/renice.c
@@ -160,14 +160,17 @@ int main(int argc, char **argv)
  			continue;
  		}
  		if (which == PRIO_USER) {
-			register struct passwd *pwd = getpwnam(*argv);
+			struct passwd *pwd = getpwnam(*argv);

-			if (pwd == NULL) {
+			if (pwd != NULL)
+				who = pwd->pw_uid;
+			else
+				who = strtol(*argv, &endptr, 10);
+			if (who < 0 || *endptr) {
  				warnx(_("unknown user %s"), *argv);
  				errs = 1;
  				continue;
  			}
-			who = pwd->pw_uid;
  		} else {
  			who = strtol(*argv, &endptr, 10);
  			if (who < 0 || *endptr) {
@@ -180,4 +183,3 @@ int main(int argc, char **argv)
  	}
  	return errs != 0 ? EXIT_FAILURE : EXIT_SUCCESS;
  }
-
-- 
2.1.0

