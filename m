Return-Path: elseifthen@gmx.com
Subject: Re: [PATCH 2/2] hwclock: fix regression from c3ae785
To: Ruediger Meier <sweet_f_a@gmx.de>
References: <b8d24f10-1bea-aa80-0a28-9f573dd81d2a@gmx.com>
 <13448500-dbe1-b7f8-3514-651d448f00d1@gmx.com>
 <201707182233.42270.sweet_f_a@gmx.de>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <b13f5e0a-368c-8c8f-6abc-b5d60d6f48b1@gmx.com>
Date: Tue, 18 Jul 2017 21:20:56 -0400
MIME-Version: 1.0
In-Reply-To: <201707182233.42270.sweet_f_a@gmx.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 07/18/2017 04:33 PM, Ruediger Meier wrote:
> On Tuesday 18 July 2017, J William Piggott wrote:
>> hwclock --get foobar
>> hwclock: 3 too many arguments given
>>
>> Fixed:
>>
>> hwclock --get foobar
>> hwclock: 1 too many arguments given
>>
>> Signed-off-by: J William Piggott <elseifthen@gmx.com>
>> ---
>>  sys-utils/hwclock.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
>> index 9745158..9b313cf 100644
>> --- a/sys-utils/hwclock.c
>> +++ b/sys-utils/hwclock.c
>> @@ -1448,9 +1448,10 @@ int main(int argc, char **argv)
>>  		}
>>  	}
>>
>> -	if (argc > optind) {
>> +	argc -= optind;
>> +	if (argc > 0) {
>>  		warnx(_("%d too many arguments given"), argc);
> 
> Oops, sorry for this regression ;)
> 
> Anyways, at least for me "1 too many arguments given" does not sound 
> really understandable.  Maybe we don't need that number at all!?
>

I don't how it would be misunderstood, it's pretty straight forward
language.

I think the number could be helpful for complex commands like:

hwclock --predict --date jan 10 2017 --utc foo --noadjfile
hwclock: 3 too many arguments given


> 
>> -		errtryhelp(EXIT_FAILURE);
>> +		errtryhelp(EX_USAGE);
> 
> What about changing also the last other errtryhelp(EXIT_FAILURE) to 
> EX_USAGE, 5 lines above?

Good point. Pushed the change.

> 
> 
>>  	}
>>
>>  	if (!ctl.adj_file_name)
>> --
>> To unsubscribe from this list: send the line "unsubscribe util-linux"
>> in the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
