Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f180.google.com ([74.125.82.180]:43626 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804Ab3GIJQa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 9 Jul 2013 05:16:30 -0400
Received: by mail-we0-f180.google.com with SMTP id w56so4401904wes.25
        for <util-linux@vger.kernel.org>; Tue, 09 Jul 2013 02:16:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAG27Bk2cVyNPuwD8usX6zH1_GdwHH6sA6-QB4vvZOB8bn1nVAw@mail.gmail.com>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
 <1373226889-3451-4-git-send-email-kerolasa@iki.fi> <CAPXgP11cHR9HzB9_pSERb9i=V0dpXUzcGY40BRbb37Lycpe3sQ@mail.gmail.com>
 <CAG27Bk2cVyNPuwD8usX6zH1_GdwHH6sA6-QB4vvZOB8bn1nVAw@mail.gmail.com>
From: Kay Sievers <kay@vrfy.org>
Date: Tue, 9 Jul 2013 11:16:08 +0200
Message-ID: <CAPXgP103fWSyeM9Ph12yUhTZiuvbjHniG6GRwNVS2LSJVn-BUQ@mail.gmail.com>
Subject: Re: [PATCH 03/34] include: copy unlocked-io.h from gnulib
To: kerolasa@gmail.com
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 9, 2013 at 8:37 AM, Sami Kerola <kerolasa@iki.fi> wrote:
> On 8 July 2013 21:21, Kay Sievers <kay@vrfy.org> wrote:
>> On Sun, Jul 7, 2013 at 9:54 PM, Sami Kerola <kerolasa@iki.fi> wrote:
>>> At the moment util-linux command are not threading, which means they can
>>> safely use thread-unsafe IO system calls which should make printing
>>> quicker.
>>
>> Do you have numbers about the assumption that this will produce better
>> results on Linux?
>>
>> Uncontended mutexes/futexes on Linux probably might not really show
>> up. Maybe in inner loops, not sure. Would be nice to know ...
>
> I did not do much testing, and to be honest results were slightly
> disappointing. With simple 'time command < big_file' most of the
> commands did not show measurable difference, but as a junior
> programmer I thought the _unlocked would be beneficial for single
> thread programs. As such assumptions are not preferred I will set up
> some sort of test, which will try to accomplish what is the difference
> of each locked vs _unlocked function call with various output sizes.
> Assuming I get the test right it should not be a big deal to run it on
> various systems I have access.

Here is a bit of the background, which explains a bit why uncontended
futexes (which is always the case in single-threaded programs) might
not really make a difference on common Linux architectures. They will
not even involve the kernel, just a simple instruction:
  http://lwn.net/Articles/360699/

Kay
