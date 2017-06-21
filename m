Return-Path: elseifthen@gmx.com
Subject: Re: [PATCH 07/12] hwclock: update --help content and grammar
To: Karel Zak <kzak@redhat.com>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
 <bf8f26c6-c0d8-2190-38ed-456dfe0fe58a@gmx.com>
 <20170620085143.cu5dpcobcr3t254m@ws.net.home>
 <20170621150120.sfhs2ajixmam25ga@ws.net.home>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <571e5249-f97f-256a-057c-da7418020f4e@gmx.com>
Date: Wed, 21 Jun 2017 13:02:00 -0400
MIME-Version: 1.0
In-Reply-To: <20170621150120.sfhs2ajixmam25ga@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 06/21/2017 11:01 AM, Karel Zak wrote:
> On Tue, Jun 20, 2017 at 10:51:43AM +0200, Karel Zak wrote:
>> On Sun, Jun 18, 2017 at 08:45:09PM -0400, J William Piggott wrote:
>>>
>>> Signed-off-by: J William Piggott <elseifthen@gmx.com>
>>> ---
>>>  include/c.h         |  4 ++--
>>>  sys-utils/hwclock.c | 48 +++++++++++++++++++++---------------------------
>>>  2 files changed, 23 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/include/c.h b/include/c.h
>>> index 9c19965..bd073fc 100644
>>> --- a/include/c.h
>>> +++ b/include/c.h
>>> @@ -319,8 +319,8 @@ static inline int xusleep(useconds_t usec)
>>>  #define USAGE_OPTIONS    _("\nOptions:\n")
>>>  #define USAGE_FUNCTIONS  _("\nFunctions:\n")
>>>  #define USAGE_SEPARATOR    "\n"
>>> -#define USAGE_HELP       _(" -h, --help     display this help and exit\n")
>>> -#define USAGE_VERSION    _(" -V, --version  output version information and exit\n")
>>> +#define USAGE_HELP       _(" -h, --help     display this information and exit\n")
> 
> We can also add 
> 
>     #define USAGE_COLUMNS   _("Available columns:\n")
> 
> for -o,--output <columns>, and 
> 
>     #define USAGE_COMMANDS  _("\nCommands:\n")

Okay

> 
>     Karel
> 
> 
