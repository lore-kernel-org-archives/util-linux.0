Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f42.google.com ([209.85.160.42]:56015 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727Ab3GIGh1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 9 Jul 2013 02:37:27 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so5173954pbc.29
        for <util-linux@vger.kernel.org>; Mon, 08 Jul 2013 23:37:26 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <CAPXgP11cHR9HzB9_pSERb9i=V0dpXUzcGY40BRbb37Lycpe3sQ@mail.gmail.com>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
	<1373226889-3451-4-git-send-email-kerolasa@iki.fi>
	<CAPXgP11cHR9HzB9_pSERb9i=V0dpXUzcGY40BRbb37Lycpe3sQ@mail.gmail.com>
Date: Tue, 9 Jul 2013 07:37:26 +0100
Message-ID: <CAG27Bk2cVyNPuwD8usX6zH1_GdwHH6sA6-QB4vvZOB8bn1nVAw@mail.gmail.com>
Subject: Re: [PATCH 03/34] include: copy unlocked-io.h from gnulib
From: Sami Kerola <kerolasa@iki.fi>
To: Kay Sievers <kay@vrfy.org>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 8 July 2013 21:21, Kay Sievers <kay@vrfy.org> wrote:
> On Sun, Jul 7, 2013 at 9:54 PM, Sami Kerola <kerolasa@iki.fi> wrote:
>> At the moment util-linux command are not threading, which means they can
>> safely use thread-unsafe IO system calls which should make printing
>> quicker.
>
> Do you have numbers about the assumption that this will produce better
> results on Linux?
>
> Uncontended mutexes/futexes on Linux probably might not really show
> up. Maybe in inner loops, not sure. Would be nice to know ...

I did not do much testing, and to be honest results were slightly
disappointing. With simple 'time command < big_file' most of the
commands did not show measurable difference, but as a junior
programmer I thought the _unlocked would be beneficial for single
thread programs. As such assumptions are not preferred I will set up
some sort of test, which will try to accomplish what is the difference
of each locked vs _unlocked function call with various output sizes.
Assuming I get the test right it should not be a big deal to run it on
various systems I have access.

Karel could you hold these patches until there is more substance to
justify merge or reject.

--
Sami Kerola
http://www.iki.fi/kerolasa/
