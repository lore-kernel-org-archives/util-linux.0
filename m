Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20141208114231.GE19904@x2.net.home>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
	<1417355862-16935-4-git-send-email-kerolasa@iki.fi>
	<20141208114231.GE19904@x2.net.home>
Date: Mon, 8 Dec 2014 12:56:54 +0000
Message-ID: <CAG27Bk3aBD+aC0rD3ufYm3e-794WkLPR-aaDCe7cSAbPCCFoFQ@mail.gmail.com>
Subject: Re: [PATCH 03/10] more: fix unsigned integer overflow [AddressSanitizer]
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 8 December 2014 at 11:42, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Nov 30, 2014 at 01:57:35PM +0000, Sami Kerola wrote:
>> text-utils/more.c:1137:20: runtime error: unsigned integer overflow: 0 -
>> 1 cannot be represented in type 'size_t' (aka 'unsigned long')
>> text-utils/more.c:1139:7: runtime error: unsigned integer overflow: 2 +
>> 18446744073709551615 cannot be represented in type 'unsigned long'
>>
>> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
>> ---
>>  text-utils/more.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/text-utils/more.c b/text-utils/more.c
>> index a489953..4b03e0d 100644
>> --- a/text-utils/more.c
>> +++ b/text-utils/more.c
>> @@ -1125,14 +1125,14 @@ void prbuf(register char *s, register int n)
>>  #ifdef HAVE_WIDECHAR
>>                       {
>>                               wchar_t wc;
>> -                             size_t mblength;
>> +                             ssize_t mblength;
>>                               mbstate_t mbstate;
>>                               memset(&mbstate, '\0', sizeof(mbstate_t));
>>                               s--;
>>                               n++;
>>                               mblength = mbrtowc(&wc, s, n, &mbstate);
>> -                             if (mblength == (size_t)-2
>> -                                 || mblength == (size_t)-1)
>> +                             if (mblength == -2
>> +                                 || mblength == -1)
>
> Really? (size_t) -1 and (size_t) -2 are by libc API defined return
> codes. It would be better to keep it in code.

In that case moving the mbrtowc() to a small function that is ASAN
blacklisted sounds like a right thing to do.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
