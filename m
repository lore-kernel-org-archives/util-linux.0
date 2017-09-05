Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20170905110154.s3ld4ziq2fifprj2@ws>
References: <20170903223407.5459-1-kerolasa@iki.fi> <20170905110154.s3ld4ziq2fifprj2@ws>
From: Sami Kerola <kerolasa@iki.fi>
Date: Tue, 5 Sep 2017 13:01:08 +0100
Message-ID: <CAG27Bk3HmcYA6FQqKS-Q5y4cd88MVeawb3b5O9nOBG3fGWqXrw@mail.gmail.com>
Subject: Re: [PATCH] hwclock: add -a that is short of --adjust to manual page
 and usage
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <util-linux.vger.kernel.org>

On 5 September 2017 at 12:01, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Sep 03, 2017 at 11:34:07PM +0100, Sami Kerola wrote:
>> In same go use -V as return value of --version from getopts_long().
>>
>> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
>> ---
>>  sys-utils/hwclock.8.in | 2 +-
>>  sys-utils/hwclock.c    | 4 ++--
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
>> index 107e3f196..2be7147e2 100644
>> --- a/sys-utils/hwclock.8.in
>> +++ b/sys-utils/hwclock.8.in
>> @@ -34,7 +34,7 @@ was added.  See their respective descriptions below.
>>  The following functions are mutually exclusive, only one can be given at
>>  a time.  If none is given, the default is \fB\-\-show\fR.
>>  .TP
>> -.B \-\-adjust
>> +.B \-a, \-\-adjust
>
> Good idea.
>
>>  Add or subtract time from the Hardware Clock to account for systematic
>>  drift since the last time the clock was set or adjusted.  See the
>>  discussion below, under
>> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
>> index 0b8444156..0da053617 100644
>> --- a/sys-utils/hwclock.c
>> +++ b/sys-utils/hwclock.c
>> @@ -1089,7 +1089,7 @@ usage(const struct hwclock_control *ctl)
>>       puts(_(" -s, --hctosys        set the system time from the RTC"));
>>       puts(_(" -w, --systohc        set the RTC from the system time"));
>>       puts(_("     --systz          send timescale configurations to the kernel"));
>> -     puts(_("     --adjust         adjust the RTC to account for systematic drift"));
>> +     puts(_(" -a, --adjust         adjust the RTC to account for systematic drift"));
>>  #if defined(__linux__) && defined(__alpha__)
>>       puts(_("     --getepoch       display the RTC epoch"));
>>       puts(_("     --setepoch       set the RTC epoch according to --epoch"));
>> @@ -1167,7 +1167,7 @@ int main(int argc, char **argv)
>>               { "show",         no_argument,       NULL, 'r'            },
>>               { "hctosys",      no_argument,       NULL, 's'            },
>>               { "utc",          no_argument,       NULL, 'u'            },
>> -             { "version",      no_argument,       NULL, 'v'            },
>> +             { "version",      no_argument,       NULL, 'V'            },
>
> What about backward compatibility? I can imagine script with "hwclock -v".

I should have been more clear in commit message. Sorry about that.

Backward compatibility is taken care by getops_long() optstring and
later case match:

https://github.com/karelzak/util-linux/blob/master/sys-utils/hwclock.c#L1212
https://github.com/karelzak/util-linux/blob/master/sys-utils/hwclock.c#L1299

I just wanted to sync long option conversion to short option to use
'V' rather than the
legacy 'v'. That is purely internal thing, and should not be
observable in any manner.
You might ask why bother - and my explanation is that sticking to 'V'
as 'version'
short hand everywhere is most obvious.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
