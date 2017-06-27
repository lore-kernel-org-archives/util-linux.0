Return-Path: sweet_f_a@gmx.de
Subject: Re: [PATCH 2/6] misc: introduce PRINT_USAGE_HELP()
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <20170626182952.15988-1-sweet_f_a@gmx.de>
 <20170626182952.15988-3-sweet_f_a@gmx.de>
 <20170627094652.fz3grdtj5qe5cmhi@ws.net.home>
From: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>
Message-ID: <e39a60ec-8aaf-de01-1d22-0064b1b2b2ed@gmx.de>
Date: Tue, 27 Jun 2017 12:48:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170627094652.fz3grdtj5qe5cmhi@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <util-linux.vger.kernel.org>



On 06/27/2017 11:46 AM, Karel Zak wrote:
> On Mon, Jun 26, 2017 at 08:29:48PM +0200, Ruediger Meier wrote:
>> --- a/include/c.h
>> +++ b/include/c.h
>> @@ -315,8 +315,18 @@ static inline int xusleep(useconds_t usec)
>>   #define USAGE_COMMANDS   _("\nCommands:\n")
>>   #define USAGE_COLUMNS    _("\nAvailable output columns:\n")
>>   #define USAGE_SEPARATOR    "\n"
>> -#define USAGE_HELP       _(" -h, --help     display this help and exit\n")
>> -#define USAGE_VERSION    _(" -V, --version  output version information and exit\n")
>> +
>> +#define USAGE_HELP_TXT    _("display this help and exit")
>> +#define USAGE_VERSION_TXT _("output version information and exit")
>> +
>> +#define PRINT_USAGE_HELP(marg_dsc) \
>> +	printf( \
>> +		"%-" #marg_dsc "s%s\n" \
>> +		"%-" #marg_dsc "s%s\n" \
>> +		, " -h, --help",    USAGE_HELP_TXT \
>> +		, " -V, --version", USAGE_VERSION_TXT \
>> +	)
> 
> Would be possible to use lowercase for the macro name?
> 
> For example USAGE_HELP_TXT is fine, but for something like function I
> would prefer
> 
>   #define print_usage_help(marg_dsc)

I've updated on github to

#define USAGE_OPTSTR_HELP     _("display this help")
#define USAGE_OPTSTR_VERSION  _("print version")

#define print_usage_help_options(marg_dsc) \
	[...]

> and what about USAGE_SEPARATOR that we have always before --help?
> Maybe we can add \n to  the print_usage_help() too.

No, because

1. There are commands with help options only:

$ ctrlaltdel --help
  [...]
  Options:
  -h, --help     display this help
  -V, --version  print version

2. Since we have we help descriptions now aligned we do not need
    the separator always IMO. ipcs(1) and also others which
    still don't have separators are looking ok:

$ ipcs --help
Usage:
  ipcs [resource-option...] [output-option]
  ipcs -m|-q|-s -i <id>

Show information on IPC facilities.

Options:
  -i, --id <id>  print details on resource identified by <id>
  -h, --help     display this help
  -V, --version  print version

Resource options:
  -m, --shmems      shared memory segments
[...]

cu,
Rudi

>> --- a/login-utils/last.c
>> +++ b/login-utils/last.c
>> @@ -589,8 +589,7 @@ static void __attribute__((__noreturn__)) usage(const struct last_control *ctl)
>>   		"                               notime|short|full|iso\n"), out);
>>   
>>   	fputs(USAGE_SEPARATOR, out);
>> -	fputs(USAGE_HELP, out);
>> -	fputs(USAGE_VERSION, out);
>> +	PRINT_USAGE_HELP(22);
>>   	fprintf(out, USAGE_MAN_TAIL("last(1)"));
> 
> 
>   Karel
> 
