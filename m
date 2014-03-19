Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f47.google.com ([209.85.220.47]:53208 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbaCSTfI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 19 Mar 2014 15:35:08 -0400
Received: by mail-pa0-f47.google.com with SMTP id lj1so9380173pab.34
        for <util-linux@vger.kernel.org>; Wed, 19 Mar 2014 12:35:07 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1395232368.7652.96330753.426A8F05@webmail.messagingengine.com>
References: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
	<1394397023-7050-3-git-send-email-kerolasa@iki.fi>
	<1395232368.7652.96330753.426A8F05@webmail.messagingengine.com>
Date: Wed, 19 Mar 2014 19:35:07 +0000
Message-ID: <CAG27Bk1x0VMKcyEiR0spenReM2EDDfiUsMpe6aLv5TArRm=gwQ@mail.gmail.com>
Subject: Re: [PATCH 03/10] kill: flip all comparions to be in smaller -
 greater order
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 19 March 2014 12:32, Benno Schulenberg <bensberg@justemail.net> wrote:
> On Sun, Mar 9, 2014, at 21:30, Sami Kerola wrote:
>> This makes code more readable.
>
> Hmm, I don't agree with that.
>
>> -                     if (argc > 2)
>> +                     if (2 < argc)
>
>> -     if (num < SIGRTMIN || num > SIGRTMAX)
>> +     if (num < SIGRTMIN || SIGRTMAX < num)
>
> I like to see always the variable on the left and the fixed value on
> the right.

Hi Benno,

Once up on time I also thought

if (value > constant)

is better, but then I read coreutils/HACKING file and found

http://thread.gmane.org/gmane.comp.version-control.git/3903/focus=4126

which made me to change my mind.  Now I believe it is best to write
comparisions in order the numerical values, something like this:

1 < 2  && 3 < 4

There are couple reasons.  First of all C, as many other programming
languages, are read from left to right.  When counting smaller to greater
order somehow feels correct for most of the people.  To be more concrete;
lets assume a value is expected to be within range 2 - 3, in this case

if (1 < value && value < 4)
	do_something();

is how I would write the comparison.  When the value must not be within
that range

if (value < 2 || 3 < value)
	error();

With multiple operators sticking to only one way of comparing is, IMHO,
quite much more readable than using both operators.  Notice that the
alternative would look, when wrote with constants, the following.

2 > 1 && 3 < 4

Since I like to get my eyes to read code without thinking too hard I like
to see all comparision operations in numeric order, including the cases
when there is exactly one comparison, such as

if (value < 0)

That said I am aware style is matter of taste, and things of that nature
are easy to disagree.  Even if that would be the case I hope you don't
recard numeric order completely loonie.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
