Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:63904 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752370AbdF0PMS (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 27 Jun 2017 11:12:18 -0400
Subject: Re: [PATCH 6/6] misc: update --help content again
To: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>,
        util-linux@vger.kernel.org
References: <20170626182952.15988-1-sweet_f_a@gmx.de>
 <20170626182952.15988-7-sweet_f_a@gmx.de>
 <965eb1e3-7439-809e-5d71-bb794997a950@gmx.com>
 <95e29533-5747-15de-79a8-681c726ec058@gmx.de>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <6e5ba694-ccd2-8175-c3f5-c0a3c85154d2@gmx.com>
Date: Tue, 27 Jun 2017 11:12:08 -0400
MIME-Version: 1.0
In-Reply-To: <95e29533-5747-15de-79a8-681c726ec058@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 06/27/2017 09:26 AM, Rüdiger Meier wrote:
> 
> 
> On 06/27/2017 02:42 PM, J William Piggott wrote:
>>
>>
>> On 06/26/2017 02:29 PM, Ruediger Meier wrote:
>>> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>>>
>>>
>>> We change
>>>
>>>   -h, --help    display this help and exit -V, --version output
>>>   version information and exit
>>>
>>> to
>>>
>>>   -h, --help    display this help -V, --version print version
>>>
>>>
>>> Some thoughts about this:
>>>
>>>    * use "display" for --help because it matches better if we
>>>     
>>> would add pager support (like git --help)
>>>
>>>    * "print" for --version to be different
>>>
>>
>> To be different why?
>>
> 
> Because AFAIR somewhere Karel or somebody else mentioned that we could
> add auto-pager support on terminal for long --help output (like
> findmnt) or otherwise colored help texts.  This would be a difference,
> doing more than printf only.
>

If I understand you correctly, using the word 'display' should imply
that a pager might be used?

When reading open source documentation, messages, etc., I make
absolutely no distinction between: show, to stdout, display, print, or
output; to me they are absolute synonyms unless there is additional
language stating otherwise; such as:

>  
> --version just print and exit
>  
> --help    display something and keep the display (pager) open.
> 

With this additional language it makes no difference for us whether we
use the same term, print or display, in both statements. But to a new
student of open source using different terms changes the meaning; or at
the very least is ambiguous. They may wonder: there must be a reason
they are using these different terms; what is it?

>> It makes it sound like help and version will not
>> have the same action.  Laymen think 'print' means send to the
>> printer.
>>
>> Translators will have to figure out which different words to use.
> 
> Hehe, I have never thought about printers.  But for my bad English
> "display" sounds more like TV show or graphical X-display.  ;)
> 
> Seriously IMO "print" is the right term for command-line and shell
> environment .  It's also more often used than "display" in POSIX and
> coreutils manpages.
>

Using the term 'print' is residue from the days when a printer was the
only human readable output. I think it is unfortunate that it has now
become synonymous with sending output to the terminal display monitor.

However, whatever the consensus is for the best term, all I'm hoping for
is to use it consistently instead of all the other synonyms.

>> What is broken by:
>>
>>   -h, --help    display this help
>>   -V, --version display version
>>
>> I really think it is a good idea to use consistent language for
> 
> Consistent language is not always human-friendly

 For comprehension of technical material, consistency is not only more
 human-friendly, it is imperative.

> and can also be more hard or boring to read.  See

We are not talking about a novel. Technical material by necessity is
boring to read (unless you are enthusiastic about learning). Think
textbooks.

> 
> $ man bash | tr ' ' '\n'| grep display | wc -l 67 $ man bash | tr ' '
> '\n'| grep print | wc -l 70
> 
> Try to imagine this manpage if they would always use the same word.

>From a comprehension standpoint, I imagine it would be an improvement.
I have more that once been confused by bash(1) using ambiguous terms.

> 
>> comparable actions.  It is easier to comprehend, especially for
>> non-native speakers. Once they understand the meaning of a term,
>> possibly from a context that they the understand well, then that
>> knowledge is transferable to other contexts. Why add confusion by
>> constantly interchanging term synonyms?
> 
> Anyways, I'm also fine with display.  This was just my favorite
> proposal.

I know when it comes to docs and strings that there is a long tradition
for hackers interjecting humor, wisecracks and generally not taking
things to seriously. I'm generally of that mindset myself. However, it
wasn't so long ago when I began using Linux that I cannot remember being
confused by all of the interchanging of synonyms. Promoting this idea of
using consistent language doesn't matter that much to me personally, I'm
trying to help new students.

I also have the impression that many of us are working to make open
source polished and professional. I believe that technical writing
should be focused on comprehension and that using consistent language,
especially for terms, is imperative to that end.

> 
> cu, Rudi
> 

>>
>>>    * "this" for --help is important to make clear that running
>>>
>>>     
>>> --help would not give you any better information than the
>>>     
>>> one you see already
>>>
>>>    * remove "information and exit" because it's bloat for the
>>>
>>>     
>>> short-help, everybody knows what it does if it exists
>>>
>>> In the manpages we should use the old, longer but more correct
>>>
>>> descriptions, inclusive a reminder if --help/--version are only
>>> working when used as the only option.  Note the term "version
>>> information" indicates that we don't only print a single version
>>>
>>> number.
>>>
>>>
>>> CC: J William Piggott <elseifthen@gmx.com>
>>>
>>> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
>>>
>>> ---
>>>  
>>> include/c.h | 4 ++-- 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>>
>>> diff --git a/include/c.h b/include/c.h
>>>
>>> index ce5551535..be7e6fd53 100644 --- a/include/c.h
>>>
>>> +++ b/include/c.h
>>>
>>> @@ -316,8 +316,8 @@ static inline int xusleep(useconds_t usec)
>>>  
>>> #define USAGE_COLUMNS   _("\nAvailable output columns:\n")
>>>
>>>  
>>> #define USAGE_SEPARATOR   "\n"
>>>  
>>> -#define USAGE_HELP_TXT   _("display this help and exit") -#define
>>> USAGE_VERSION_TXT _("output version information and exit") +#define
>>> USAGE_HELP_TXT   _("display this help") +#define USAGE_VERSION_TXT
>>> _("print version")
>>>
>>>    
>>> #define PRINT_USAGE_HELP(marg_dsc) \
>>>      
>>> printf( \
>>>
> -- To unsubscribe from this list: send the line "unsubscribe
> util-linux" in
> 
> the body of a message to majordomo@vger.kernel.org
> 
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> 
> 
