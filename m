Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:64822 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbaLSJUb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 19 Dec 2014 04:20:31 -0500
Received: by mail-wi0-f172.google.com with SMTP id n3so1200048wiv.17
        for <util-linux@vger.kernel.org>; Fri, 19 Dec 2014 01:20:29 -0800 (PST)
Date: Fri, 19 Dec 2014 09:20:23 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: kerolasa@gmail.com
cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 03/10] more: fix unsigned integer overflow
 [AddressSanitizer]
In-Reply-To: <CAG27Bk3aBD+aC0rD3ufYm3e-794WkLPR-aaDCe7cSAbPCCFoFQ@mail.gmail.com>
Message-ID: <alpine.LNX.2.03.1412190915560.8955@iki.fi>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi> <1417355862-16935-4-git-send-email-kerolasa@iki.fi> <20141208114231.GE19904@x2.net.home> <CAG27Bk3aBD+aC0rD3ufYm3e-794WkLPR-aaDCe7cSAbPCCFoFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 8 Dec 2014, Sami Kerola wrote:

> On 8 December 2014 at 11:42, Karel Zak <kzak@redhat.com> wrote:
>> On Sun, Nov 30, 2014 at 01:57:35PM +0000, Sami Kerola wrote:
>>> text-utils/more.c:1137:20: runtime error: unsigned integer overflow: 0 -
>>> 1 cannot be represented in type 'size_t' (aka 'unsigned long')
>>> text-utils/more.c:1139:7: runtime error: unsigned integer overflow: 2 +
>>> 18446744073709551615 cannot be represented in type 'unsigned long'
>>>
>>> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
>>> ---
>>>  text-utils/more.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/text-utils/more.c b/text-utils/more.c
>>> index a489953..4b03e0d 100644
>>> --- a/text-utils/more.c
>>> +++ b/text-utils/more.c
>>> @@ -1125,14 +1125,14 @@ void prbuf(register char *s, register int n)
>>>  #ifdef HAVE_WIDECHAR
>>>                       {
>>>                               wchar_t wc;
>>> -                             size_t mblength;
>>> +                             ssize_t mblength;
>>>                               mbstate_t mbstate;
>>>                               memset(&mbstate, '\0', sizeof(mbstate_t));
>>>                               s--;
>>>                               n++;
>>>                               mblength = mbrtowc(&wc, s, n, &mbstate);
>>> -                             if (mblength == (size_t)-2
>>> -                                 || mblength == (size_t)-1)
>>> +                             if (mblength == -2
>>> +                                 || mblength == -1)
>>
>> Really? (size_t) -1 and (size_t) -2 are by libc API defined return
>> codes. It would be better to keep it in code.
>
> In that case moving the mbrtowc() to a small function that is ASAN
> blacklisted sounds like a right thing to do.

Old more(1) change is replaced with

https://github.com/kerolasa/lelux-utiliteetit/commit/e8e72e378a29072781cd4de250570ae07ad88477

Here is the change for review purpose. Karel, I think it is easier to get 
these changes from my github than from mail list, but of course it's your.

--->8----
From: Sami Kerola <kerolasa@iki.fi>
Date: Wed, 17 Dec 2014 22:57:02 +0000
Subject: [PATCH 10/10] more: blacklist unsigned integer overflow [AddressSanitizer]

The mbrtowc() return values are overflowing by design.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
  text-utils/more.c | 15 +++++++++++----
  1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 8c0853c..a75cd7a 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -1091,6 +1091,16 @@ void clreos(void)
  	my_putstring(EodClr);
  }

+
+static UL_ASAN_BLACKLIST xmbrtowc(wchar_t *wc, const char *s, size_t n,
+				  mbstate_t *mbstate)
+{
+	const size_t mblength = mbrtowc(&wc, s, n, &mbstate);
+	if (mblength == (size_t)-2 || mblength == (size_t)-1)
+		return 1;
+	return mblength;
+}
+
  /* Print a buffer of n characters */
  void prbuf(register char *s, register int n)
  {
@@ -1130,10 +1140,7 @@ void prbuf(register char *s, register int n)
  				memset(&mbstate, '\0', sizeof(mbstate_t));
  				s--;
  				n++;
-				mblength = mbrtowc(&wc, s, n, &mbstate);
-				if (mblength == (size_t)-2
-				    || mblength == (size_t)-1)
-					mblength = 1;
+				mblength = xmbrtowc(&wc, s, n, &mbstate);
  				while (mblength--)
  					putchar(*s++);
  				n += mblength;
-- 
2.2.0

