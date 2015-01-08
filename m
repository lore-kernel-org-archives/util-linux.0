Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:62527 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756873AbbAHQ4Q (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 8 Jan 2015 11:56:16 -0500
Message-ID: <54AEB68B.8050601@gmx.com>
Date: Thu, 08 Jan 2015 11:55:39 -0500
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Peter Cordes <peter@cordes.ca>, Util-Linux <util-linux@vger.kernel.org>
Subject: Re: questions on util-linux translation
References: <CAO7R9g8opv3Z3aW73xJ-d3ZBwi5_f4td9Xeqk=QBUCqz13fGhw@mail.gmail.com> <1420490268.1408121.209893057.48A620D9@webmail.messagingengine.com> <CAO7R9g8aGM48RzU-ed-cYyAdUEPbX7B4QSsVTdLx90poPtKwhQ@mail.gmail.com> <1420577328.1786767.210387085.321E0759@webmail.messagingengine.com> <20150108040504.GT29504@cordes.ca>
In-Reply-To: <20150108040504.GT29504@cordes.ca>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 01/07/2015 11:05 PM, Peter Cordes wrote:
> On Tue, Jan 06, 2015 at 09:48:48PM +0100, Benno Schulenberg wrote:
>>
>> On Tue, Jan 6, 2015, at 11:34, Antonio Ceballos wrote:
>>> 2. My first suggestion is "too neutral" for that context. Your
>>> suggestion probably sounds better. I presume that something
>>> more explicit but longer is worse, such as:
>>>
>>> "partition #7 cannot be removed, as it doesn't exist"
>>
>> Yeah, that is rather oververbose.  The message is not a contextless
>> error message, but gets produced only when --verbose is used.  The
>> previously mentioned example of deleting partitions 5 to 9 (with 7
>> not existing), the command would be:
>>
>> partx --delete --verbose -n 5:9 /dev/sda
>>
>> and it currently would print the following progress messages:
>>
>> dev/sda: partition #5 removed
>> dev/sda: partition #6 removed
>> dev/sda: partition #7 already doesn't exist
>> dev/sda: partition #8 removed
>> dev/sda: partition #9 removed
>>
>> In fact I think the message for #7 is quite good,
>> and I don't think that my proposal is any better:
>>
>> dev/sda: partition #5 removed
>> dev/sda: partition #6 removed
>> dev/sda: skipping nonexistent partition #7
>> dev/sda: partition #8 removed
>> dev/sda: partition #9 removed
> 
>  As an unbiased observer (never used partx, so I'm the target audience
> for understanding its output), either of these two look fine.
> "already doesn't exist" mentally parses quickly.  That phrasing has
> the advantage that the partition number is at the same column as the
> messages for successful deletion, so you can scan down the column of
> numbers and see that's the only message about #7.
> 
>  With the 2nd phrasing, I found I took a sec of extra time for my eye
> to bounce from the column of #5, #6, <gap>, #8, #9 out to the #7.
> 
>  So I'd suggest keeping the "partition #%d already doesn't exist".  As
> a native English speaker, I agree it sounds slightly clumsy, but it
> gets the point across quickly and unambiguously.  You could maybe lose
> the word "already", and say
> "partition #%d doesn't exist"

dev/sda: partition #5 removed
dev/sda: partition #6 removed
dev/sda: partition #7 doesn't exist
dev/sda: partition #8 removed
dev/sda: partition #9 removed

That sounds the most correct to me; 'already' is the clumsy part.

