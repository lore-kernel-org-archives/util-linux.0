Return-Path: elseifthen@gmx.com
Subject: Re: [PATCH 04/12] hwclock: add usage() functions heading
To: Karel Zak <kzak@redhat.com>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
 <68a54120-d8ad-59c2-89b6-4ccdd961300b@gmx.com>
 <20170620083649.qunrwp7dsxcaspot@ws.net.home>
From: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Message-ID: <9f28d294-f05c-2f98-ccc0-bc968c062416@gmx.com>
Date: Tue, 20 Jun 2017 20:59:20 -0400
MIME-Version: 1.0
In-Reply-To: <20170620083649.qunrwp7dsxcaspot@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 06/20/2017 04:36 AM, Karel Zak wrote:
> On Sun, Jun 18, 2017 at 08:41:45PM -0400, J William Piggott wrote:
>> -#define USAGE_MAN_TAIL(_man)   _("\nFor more details see %s.\n"), _man
>> +#define USAGE_MAN_TAIL(_man)   _("\nFor more details see %s\n"), _man
> 
> What's wrong with the period?

_I put it back_, but here is my opinion why it shouldn't be there:

* the rest of usage() doesn't use line-ending periods

* the super class grammar rule is 'be consistent'

* usage() is a vertical list so line-ending periods are not required

* the \n at the beginning and end of this string means it is standalone
   sentence (vertical list) so a line-ending period is not required.

* the main purpose (perhaps the only purpose) of a line-ending period is
  to improve readability in paragraphs of text. That is, when one
  sentence ends and another begins in the middle of a line.

* a passage of text with mixed use of line-ending punctuation for
  sentences degrades readability. Long term readers are conditioned to
  recognize properly delimited text and will parse it with less
  scrutiny; only to find out part way through that the burden of
  separating sentences is (sometimes) on them.

* it just looks wrong to have a screen full of usage() text without a
  period in sight, only to have one show up at EOF.

Pretty much the same reasons that I advocate that message strings should
not use periods. They are vertical lists and do not require it; we have
some message strings that cannot have line-ending periods, so to follow
the 'be consistent' grammar rule, none of them should. An added benefit
would be that simple rules are easy document, easy to remember, and easy
to enforce. Easier than: with warn() don't use. Otherwise use. Except if
it is not a sentence. Well, maybe use it on fragments that the author
intended to be a complete sentence ... a simple 'don't use them' is much
easier, yes? What to do if a message string has two sentences on one
line? Put them on separate lines, otherwise rewrite them as a single
sentence.


> 
>     Karel
> 
