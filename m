Return-Path: kerolasa@gmail.com
Sender: Sami Kerola <kerolasa@gmail.com>
From: Sami Kerola <kerolasa@iki.fi>
Date: Tue, 16 Sep 2014 21:13:12 +0100 (BST)
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/6] renice: avoid having same lines of code twice
In-Reply-To: <20140912073504.GQ21325@x2.net.home>
Message-ID: <alpine.LNX.2.03.1409162106330.3712@kerolasa-home>
References: <1410002693-16540-1-git-send-email-kerolasa@iki.fi> <1410002693-16540-5-git-send-email-kerolasa@iki.fi> <20140912073504.GQ21325@x2.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <util-linux.vger.kernel.org>

On Fri, 12 Sep 2014, Karel Zak wrote:

> On Sat, Sep 06, 2014 at 12:24:51PM +0100, Sami Kerola wrote:
>> +static int getprio(const int which, const int who, const char *idtype)
>> +{
>> +	int ret;
>> +
>> +	errno = 0;
>> +	ret = getpriority(which, who);
>> +	if (ret == -1 && errno) {
>> +		warn(_("failed to get priority for %d (%s)"), who, idtype);
>> +		return PRIO_MAX + 1;
>> +	}
>> +	return ret;
>> +}
>
> This is exactly the situation when you want to use "return" only for 
> function status rather than for any data.
>
> static int getprio(const int which,
>                   const int who,
>                   const char *idtype,
>                   int *prio)                       <--------!
> {
>    errno = 0;
>    *prio = getpriority(which, who);
>    if (*prio == -1 && errno) {
>        warn(_("failed to get priority for %d (%s)"), who, idtype);
>        return -errno;
>    }
>    return 0;
> }
>
>
>> -	errno = 0;
>> -	newprio = getpriority(which, who);
>> -	if (newprio == -1 && errno) {
>> -		warn(_("failed to get priority for %d (%s)"), who, idtype);
>> +	if ((newprio = getprio(which, who, idtype)) == PRIO_MAX + 1)
>>  		return 1;
>> -	}
>
>   if (getprio(which, who, idtype, &newprio) != 0)
>        return 1;
>
> .. so you don't need complicated things like PRIO_MAX + 1.

Hi Karel,

That is a great improvement. Here is updated version of the change.

-->8---
From: Sami Kerola <kerolasa@iki.fi>
Date: Fri, 5 Sep 2014 23:33:16 +0100
Subject: [PATCH 4/7] renice: avoid having same lines of code twice

Add getprio() function to avoid duplication of a simple task.

Reviewed-by: Karel Zak <kzak@redhat.com>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
  sys-utils/renice.c | 32 ++++++++++++++++----------------
  1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sys-utils/renice.c b/sys-utils/renice.c
index 2075d40..d83fc4a 100644
--- a/sys-utils/renice.c
+++ b/sys-utils/renice.c
@@ -67,8 +67,19 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
  	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
  }

-static int
-donice(int which, int who, int prio) {
+static int getprio(const int which, const int who, const char *idtype, int *prio)
+{
+	errno = 0;
+	*prio = getpriority(which, who);
+	if (*prio == -1 && errno) {
+		warn(_("failed to get priority for %d (%s)"), who, idtype);
+		return -errno;
+	}
+	return 0;
+}
+
+static int donice(int which, int who, int prio)
+{
  	int oldprio, newprio;
  	const char *idtype = _("process ID");

@@ -76,24 +87,14 @@ donice(int which, int who, int prio) {
  		idtype = _("user ID");
  	else if (which == PRIO_PGRP)
  		idtype = _("process group ID");
-
-	errno = 0;
-	oldprio = getpriority(which, who);
-	if (oldprio == -1 && errno) {
-		warn(_("failed to get priority for %d (%s)"), who, idtype);
+	if (getprio(which, who, idtype, &oldprio) != 0)
  		return 1;
-	}
  	if (setpriority(which, who, prio) < 0) {
  		warn(_("failed to set priority for %d (%s)"), who, idtype);
  		return 1;
  	}
-	errno = 0;
-	newprio = getpriority(which, who);
-	if (newprio == -1 && errno) {
-		warn(_("failed to get priority for %d (%s)"), who, idtype);
+	if (getprio(which, who, idtype, &newprio) != 0)
  		return 1;
-	}
-
  	printf(_("%d (%s) old priority %d, new priority %d\n"),
  	       who, idtype, oldprio, newprio);
  	return 0;
@@ -103,8 +104,7 @@ donice(int which, int who, int prio) {
   * Change the priority (the nice value) of processes
   * or groups of processes which are already running.
   */
-int
-main(int argc, char **argv)
+int main(int argc, char **argv)
  {
  	int which = PRIO_PROCESS;
  	int who = 0, prio, errs = 0;
-- 
2.1.0
