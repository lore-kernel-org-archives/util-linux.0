Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35248 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933644AbdAHJjl (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 8 Jan 2017 04:39:41 -0500
Received: by mail-qt0-f193.google.com with SMTP id f4so7825647qte.2
        for <util-linux@vger.kernel.org>; Sun, 08 Jan 2017 01:39:41 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <alpine.LNX.2.20.1701072212010.9096@imuri>
References: <20161231214107.8658-1-kerolasa@iki.fi> <05e4405f-8096-9261-f9f2-d2c6b84675bc@gmx.com>
 <070fc458-ed69-a09c-11cc-42bb50fec888@gmx.com> <alpine.LNX.2.20.1701072212010.9096@imuri>
From: Sami Kerola <kerolasa@iki.fi>
Date: Sun, 8 Jan 2017 09:39:40 +0000
Message-ID: <CAG27Bk2Kg4MQFKSDwAxM849HJ7AxZWLX1vGL21qO042za=V1pw@mail.gmail.com>
Subject: Re: pull: hwclock 27 changes
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 7 January 2017 at 23:06, Sami Kerola <kerolasa@iki.fi> wrote:
> On Sat, 7 Jan 2017, J William Piggott wrote:
>   git://github.com/kerolasa/lelux-utiliteetit.git hwclock-jwp-reviewed
>
> that has in almost all changes 'Reviewed-by: J William Piggott
> <elseifthen@gmx.com>'. Notice also that the latest update is not 100%
> ready. We have question of --compare open, and 'hwclock: move command-line
> options to control structure' has issue that is not yet corrected yet.

hwclock-jwp-reviewed got update:

-- snip
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index b41acd450..c3bcc2fa0 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1245,11 +1245,6 @@ manipulate_clock(const struct hwclock_control
*ctl, const time_t set_time,
  adjtime->dirty = TRUE;
  }

- if (ctl->noadjfile || (ctl->systz && (ctl->utc || ctl->local_opt))) {
- /* A little trick to avoid writing the file if we don't have to */
- adjtime->dirty = FALSE;
- }
-
  if (ctl->show || ctl->get || ctl->adjust || ctl->hctosys
     || (!ctl->noadjfile && !ctl->systz && !ctl->predict)) {
  /* data from HW-clock are required */
@@ -1558,7 +1553,7 @@ int main(int argc, char **argv)
 {
  struct hwclock_control ctl = { 0 };
  struct timeval startup_time;
- struct adjtime adjtime;
+ struct adjtime adjtime = { 0 };
  /*
  * The time we started up, in seconds into the epoch, including
  * fractions.
@@ -1839,8 +1834,12 @@ int main(int argc, char **argv)
  }
  }

- if ((rc = read_adjtime(&ctl, &adjtime)) != 0)
- hwclock_exit(&ctl, rc);
+ if (!ctl.noadjfile && !(ctl.systz && (ctl.utc || ctl.local_opt))) {
+ if ((rc = read_adjtime(&ctl, &adjtime)) != 0)
+ hwclock_exit(&ctl, rc);
+ } else
+ /* avoid writing adjtime file if we don't have to */
+ adjtime.dirty = FALSE;
  ctl.universal = hw_clock_is_utc(&ctl, adjtime);
  if (ctl.compare) {
  if (compare_clock(&ctl))
-- snip

that should fix:

>> commit 59aff057349335cd089c34bb0eaa972cf60ff96a
>> Author: Sami Kerola <kerolasa@iki.fi>
>> Date:   Sat Jul 16 16:45:07 2016 +0100
>>
>>     hwclock: move command-line options to control structure
>>
>>     The control structure is read-only everywhere else but in main().  Almost
>>     all changes are about how variables are referred, with one exception.  Calls
>>     to read_adjtime() from manipulate_clock() and compare_clock() are moved to
>>     main().  This way it is possible to keep variable that tells if hwclock is
>>     using UTC-0 be part of control structure.
>>
>>     Changes within #ifdef __alpha__ segments were tested by flipping the
>>     preprocessor directivive otherway around and getting good compilaton all the
>>     way to the point where linking on none-alpha system failed.
>>
>>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
>>
>>  8< -------
>>
>> @@ -1255,32 +1233,27 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
>>       /* local return code */
>>       int rc = 0;
>>
>> -     if (!systz && !predict) {
>> +     if (!ctl->systz && !ctl->predict) {
>>               no_auth = ur->get_permissions();
>>               if (no_auth)
>>                       return EX_NOPERM;
>>       }
>>
>> -     if (!noadjfile && !(systz && (utc || local_opt))) {
>> -             rc = read_adjtime(&adjtime);
>> -             if (rc)
>> -                     return rc;
>> -     } else {
>> -             /* A little trick to avoid writing the file if we don't have to */
>> -             adjtime.dirty = FALSE;
>>
>> >
>> > You have to move the above to where you read_adjtime in main. The
>> > concept behind --systz is speed, so we don't want to read the file
>> > then unless they also are changing timescales from the command line.
>> > It is not intended to use --systz for changing timescales, so that
>> > shouldn't happen. More importantly, hwclock depends on *adjtime having
>> > default values when using --noadjfile. For example comparing the
>> > patched version to master using the --get function:
>>
>> ./hwclock-master --get --debug --noadjfile --utc | grep -E 'Calculated|2017\-'; ./hwclock-sami --get --debug --noadjfile --utc | grep -E 'Calculated|2017\-'
>> Calculated Hardware Clock drift is 0.000000 seconds
>> 2017-01-06 10:11:32.294942-0500
>> Calculated Hardware Clock drift is 1.325654 seconds
>> 2017-01-06 10:11:34.339980-0500
>>
>> >
>> >
>> >
>>
>> +     if ((ctl->set || ctl->systohc || ctl->adjust) &&
>> +         (adjtime->local_utc == UTC) != ctl->universal) {
>> +             adjtime->local_utc = ctl->universal ? UTC : LOCAL;
>> +             adjtime->dirty = TRUE;
>>       }
>>
>> -     universal = hw_clock_is_utc(utc, local_opt, adjtime);
>> -
>> -     if ((set || systohc || adjust) &&
>> -         (adjtime.local_utc == UTC) != universal) {
>> -             adjtime.local_utc = universal ? UTC : LOCAL;
>> -             adjtime.dirty = TRUE;
>> +     if (ctl->noadjfile || (ctl->systz && (ctl->utc || ctl->local_opt))) {
>> +             /* A little trick to avoid writing the file if we don't have to */
>> +             adjtime->dirty = FALSE;
>>
>> >
>> > So the above addition won't be here.
>> >
>
> This issue is not corrected yet. It's getting a bit too late in my
> timezone to do change that requires concentration. I will send notify to
> email list when necessary update is done.


-- 
Sami Kerola
http://www.iki.fi/kerolasa/
