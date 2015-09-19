Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vk0-f52.google.com ([209.85.213.52]:33006 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753778AbbISIug (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 19 Sep 2015 04:50:36 -0400
Received: by vkgd64 with SMTP id d64so42271952vkg.0
        for <util-linux@vger.kernel.org>; Sat, 19 Sep 2015 01:50:35 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <CAGQyBevyqMbq6KuRi5=E_QnXmjE4BK7P=sK4awostLf5uNiYuA@mail.gmail.com>
References: <CAGQyBevyqMbq6KuRi5=E_QnXmjE4BK7P=sK4awostLf5uNiYuA@mail.gmail.com>
Date: Sat, 19 Sep 2015 09:50:35 +0100
Message-ID: <CAG27Bk1+WHUEpyn53pGeSyE0bCVgRFnZ0sD17M3MS0p11P8-Pw@mail.gmail.com>
Subject: Re: Custom structured data from logger utility
From: Sami Kerola <kerolasa@iki.fi>
To: Priya Ahuja <priahuja321@gmail.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 19 September 2015 at 00:25, Priya Ahuja <priahuja321@gmail.com> wrote:
> I am using version 2.20.1 logger utility to send logs to rsyslogd from
> bash scripts. I want to send logs in RFC5424 format with custom
> structured data fields, example: [sdid@enterprise-number level=INFO
> id=1234]. I understand 2.20.1 does not support 5424 format but I
> looked at the logger.c code in the latest version and seems structured
> data fields are set to [timeQuality tzKnown=\"1\" isSynced=\"1\"
> syncAccuracy=\"%ld\"]. Is there a way/plan to format custom structured
> data?

Hi Priya,

I am in favor of more control for structured data items.

I guess custom data could be implemented the same way as it's done with
journal, e.g., with io vectors.  I have not had a look of the code what sort
of changes would be needed in order to achieve that nice way.  Quite frankly
my time has been lately taken by various other things than contributions.
Perhaps someone else could take the lead doing in writing these changes,
would you for example fancy doing that?

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
