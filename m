Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:64274 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750815AbdBKRKu (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 11 Feb 2017 12:10:50 -0500
From: J William Piggott <elseifthen@gmx.com>
Subject: Re: [ping] Karel: Re: pull: hwclock 27 changes
To: Karel Zak <kzak@redhat.com>
References: <alpine.LNX.2.20.1701072212010.9096@imuri>
 <a9d7f37b-3607-70d4-843a-7d934bd305d5@gmx.com>
 <alpine.LNX.2.20.1701112055190.2589@imuri>
 <ede34a46-7290-c68b-1dd8-e4fc356e5caf@gmx.com>
 <alpine.LNX.2.20.1701140930380.2049@imuri>
 <f723104e-d23b-f8fd-e9ee-b9fc82c86fd3@gmx.com>
 <c88dc7ee-3e18-19ec-612e-3788551517bb@gmx.com>
 <alpine.LNX.2.20.1701252136160.492@imuri>
 <5feac9a5-e3e3-5148-60a0-fb3197a1caa8@gmx.com>
 <9798a869-fb09-77e7-a13a-bca002617672@gmx.com>
 <20170209110942.woeapxeeahnd3mnd@ws.net.home>
Cc: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Message-ID: <e7f31c07-4040-ac7c-9a78-52526baccbfd@gmx.com>
Date: Sat, 11 Feb 2017 12:10:25 -0500
MIME-Version: 1.0
In-Reply-To: <20170209110942.woeapxeeahnd3mnd@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 02/09/2017 06:09 AM, Karel Zak wrote:
> On Thu, Feb 02, 2017 at 10:04:13AM -0500, J William Piggott wrote:
>> Outside of our ongoing discussion below regarding a 'technically
>> unnecessary' cast, I think Sami's work is ready for you to consider it
>> for committing. I would be interested in your thoughts on the cast.
> 
> I have no strong opinion about it, for the reader it could be really
> nice to follow code author ideas, but personally I think it's better
> to not use it too often :-)

At the beginning of this discussion I did not have a strong opinion
either ... but now I seem to have found one:)

> 
> BTW, often bug in libblkid/fdisk is math without casts, something
> like:
> 
>     uint64_t x;
>     uint32_t a, b;
> 
>     x = a + b
> 
> here it's better to be explicit and use (uint64) a + b. The same
> problem if you write macros to hide some operations (we had this
> problem in include/bitops.h).

This is a good tip to remember, and a good example of why using
these noop symbolic casts merely as a reminder that an assignment
operator is making an automatic type conversion is, IMO, harmful.

This 'x = (uint64) a + b' looks very much like one of those noop
symbolic casts; when in fact it is functional and important. I believe
that loading up code with these noop symbolic casts will condition
readers to gloss over them as: 'this is just one of those assignment
conversion reminders.'

In your example the cast has nothing to do with the assignment operator,
it is telling the (+) addition operator we need a different result from
it. It would be better to remove this ambiguity by placing the cast near
the operator that it is associated with. Like this:

x = a + (uint64) b

I think the technique of applying a noop cast has an important use, but
that it is only effective when use judiciously.

I will use Sami's first patch to remove the FLOOR macro as an example.

-	tdrift_p->tv_sec = FLOOR(exact_adjustment);
+	tdrift_p->tv_sec = (int) exact_adjustment;
+	if (exact_adjustment < 0)
+		tdrift_p->tv_sec--;
 
Here is where I think these noop symbolic casts shine, it is not a
yellow flag reminder, but a red flag telling the reader that this
automatic type conversion by the assignment operator /is/ changing the
value /and/ this change is imperative for the application to work
properly. It is saying: you need to understand what is happening here.

If this technique is ever used as merely a cautionary flag, then it will
always be viewed that way, trivially; then when we really need it to
forcefully grab the readers attention ... it will not.

For myself the rule to use this technique would be:

Use a noop symbolic type cast to draw attention to an automatic type
conversion by an assignment operator when:

* the stored value is being changed by the conversion
AND
* the change is imperative to the application's operation.

One final comment with regard to the cast being discussed.

The origin of the floor(3) argument is a time_t, so we know the integer
part that it returns will fit in a time_t. There is no reason to add a
distracting cautionary sign. If the reader follows that sign it will
lead them to a dead end. After they have jumped down a few of these
rabbit holes they will begin to ignore these casts and anything
that looks like one, IMO.





> 
>     Karel
> 
