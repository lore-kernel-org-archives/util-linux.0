Return-Path: elseifthen@gmx.com
Subject: Re: [PATCH 11/12] hwclock: remove unused usage() FILE argument
To: Karel Zak <kzak@redhat.com>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
 <ce8ce9d6-d266-12da-8e7e-c41e6a185714@gmx.com>
 <20170621092647.b7zgmeeqflfmc2mt@ws.net.home>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <68c377a2-191e-43f5-34aa-c5a69d049c24@gmx.com>
Date: Wed, 21 Jun 2017 11:48:47 -0400
MIME-Version: 1.0
In-Reply-To: <20170621092647.b7zgmeeqflfmc2mt@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 06/21/2017 05:26 AM, Karel Zak wrote:
> On Sun, Jun 18, 2017 at 08:49:49PM -0400, J William Piggott wrote:
>>
>> Signed-off-by: J William Piggott <elseifthen@gmx.com>
>> ---
>>  sys-utils/hwclock.c | 74 ++++++++++++++++++++++++++---------------------------
>>  1 file changed, 37 insertions(+), 37 deletions(-)
>>
>> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
>> index 7d69b7a..636d36a 100644
>> --- a/sys-utils/hwclock.c
>> +++ b/sys-utils/hwclock.c
>> @@ -1200,49 +1200,49 @@ static void out_version(void)
>>  }
>>  
>>  static void __attribute__((__noreturn__))
>> -usage(const struct hwclock_control *ctl, FILE *out)
>> +usage(const struct hwclock_control *ctl)
>>  {
>> -	fputs(USAGE_HEADER, out);
>> -	fputs(_(" hwclock [function] [option...]\n"), out);
>> -
>> -	fputs(USAGE_SEPARATOR, out);
>> -	fputs(_(" Query or set the RTC (Real Time Clock / Hardware Clock)\n"), out);
>> -
>> -	fputs(USAGE_FUNCTIONS, out);
>> -	fputs(_(" -r, --show           display the RTC time\n"), out);
>> -	fputs(_("     --get            display drift corrected RTC time\n"), out);
>> -	fputs(_("     --set            set the RTC according to --date\n"), out);
>> -	fputs(_(" -s, --hctosys        set the system time from the RTC\n"), out);
>> -	fputs(_(" -w, --systohc        set the RTC from the system time\n"), out);
>> -	fputs(_("     --systz          send timescale configurations to the kernel\n"), out);
>> -	fputs(_("     --adjust         adjust the RTC to account for systematic drift\n"), out);
>> +	fputs(USAGE_HEADER, stdout);
>> +	puts(_(" hwclock [function] [option...]"));
>> +
>> +	fputs(USAGE_SEPARATOR, stdout);
>> +	puts(_(" Query or set the RTC (Real Time Clock / Hardware Clock)"));
>             ^
> We don't use this space here. Fixed.

Ah, I miss read this in howto-usage-function.txt:

> The usage output begins with an empty line, followed by 'Usage:', and
> then the synopsis on the line after that.  The synopsis and option-
> description lines are all indented by one space (0x40).

I read 'synopsis and description', not 'option-description'. Also, it's
the entire option line, not the option-description that is indented. 

There is not an example in boilerplate.c for a command description,
there probably should be.

> 
>     Karel
> 
