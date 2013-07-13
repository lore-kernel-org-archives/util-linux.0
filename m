Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f49.google.com ([209.85.220.49]:45829 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab3GMWLA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Jul 2013 18:11:00 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld11so9971166pab.8
        for <util-linux@vger.kernel.org>; Sat, 13 Jul 2013 15:10:59 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <CAPXgP103fWSyeM9Ph12yUhTZiuvbjHniG6GRwNVS2LSJVn-BUQ@mail.gmail.com>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
	<1373226889-3451-4-git-send-email-kerolasa@iki.fi>
	<CAPXgP11cHR9HzB9_pSERb9i=V0dpXUzcGY40BRbb37Lycpe3sQ@mail.gmail.com>
	<CAG27Bk2cVyNPuwD8usX6zH1_GdwHH6sA6-QB4vvZOB8bn1nVAw@mail.gmail.com>
	<CAPXgP103fWSyeM9Ph12yUhTZiuvbjHniG6GRwNVS2LSJVn-BUQ@mail.gmail.com>
Date: Sat, 13 Jul 2013 23:10:59 +0100
Message-ID: <CAG27Bk2Oh+D9=H06a-L_4AccUqOsFPRpd9nfAEcXZkavzZM36Q@mail.gmail.com>
Subject: Re: [PATCH 03/34] include: copy unlocked-io.h from gnulib
From: Sami Kerola <kerolasa@iki.fi>
To: Kay Sievers <kay@vrfy.org>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 9 July 2013 10:16, Kay Sievers <kay@vrfy.org> wrote:
> On Tue, Jul 9, 2013 at 8:37 AM, Sami Kerola <kerolasa@iki.fi> wrote:
>> On 8 July 2013 21:21, Kay Sievers <kay@vrfy.org> wrote:
>>> On Sun, Jul 7, 2013 at 9:54 PM, Sami Kerola <kerolasa@iki.fi> wrote:
>>>> At the moment util-linux command are not threading, which means they can
>>>> safely use thread-unsafe IO system calls which should make printing
>>>> quicker.
>>>
>>> Do you have numbers about the assumption that this will produce better
>>> results on Linux?
>>>
>>> Uncontended mutexes/futexes on Linux probably might not really show
>>> up. Maybe in inner loops, not sure. Would be nice to know ...
>>
>> I did not do much testing, and to be honest results were slightly
>> disappointing. With simple 'time command < big_file' most of the
>> commands did not show measurable difference, but as a junior
>> programmer I thought the _unlocked would be beneficial for single
>> thread programs. As such assumptions are not preferred I will set up
>> some sort of test, which will try to accomplish what is the difference
>> of each locked vs _unlocked function call with various output sizes.
>> Assuming I get the test right it should not be a big deal to run it on
>> various systems I have access.
>
> Here is a bit of the background, which explains a bit why uncontended
> futexes (which is always the case in single-threaded programs) might
> not really make a difference on common Linux architectures. They will
> not even involve the kernel, just a simple instruction:
>   http://lwn.net/Articles/360699/

Hello Kay, Karel, and others who like statistics,

This is how I created numbers, and analysed them.

http://www.iki.fi/kerolasa/locked_vs_unlocked_io.tar.xz

Replicating results should be easy enough.  Other than the usual
developer tools I used R to visualize the numbers.  I have doubts my test
is measuring something else than what I hope it to measure, if so
comments about bias are welcome.

When I look the measurement

http://www.iki.fi/kerolasa/locked_vs_unlocked_io.png

it does, and doesn't, make sense.  As one could expect unlocked IO is
slightly quicker, when comparing mean run time.  But locked IO has much
more predictable run time, although some requests form quite long tail of
slow runs.  When looking slow runs the unlocked tail is heavier.

Conclusion.  Maybe my test is broken, or performance characteristics of
these two functions are dissimilar enough that comparison is a bit like
with apples and oranges.

--
Sami Kerola
http://www.iki.fi/kerolasa/
