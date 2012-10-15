Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:51243 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab2JOIgo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 15 Oct 2012 04:36:44 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so1751514wib.1
        for <util-linux@vger.kernel.org>; Mon, 15 Oct 2012 01:36:43 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <201210142217.37008.vapier@gentoo.org>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
	<1350246070-10544-20-git-send-email-kerolasa@iki.fi>
	<201210142217.37008.vapier@gentoo.org>
Date: Mon, 15 Oct 2012 09:36:43 +0100
Message-ID: <CAG27Bk2aX0wDQ1NzMrtS1kCvWFto9hF-H8aLoXy-0Q+wTVN=sQ@mail.gmail.com>
Subject: Re: [PATCH 19/19] fsck.cramfs: replace utime() with utimensat()
From: Sami Kerola <kerolasa@iki.fi>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 15, 2012 at 3:17 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Sunday 14 October 2012 16:21:10 Sami Kerola wrote:
>> +     if (utimensat(path, &epoch, 0) < 0)
>
> err, did you test this at all ?  utimensat() takes 4 args one of which is a
> reference file descriptor.

Hi Mike and others,

I thought I did, but what ever I did where partly unsuccessful. Thank
you for all the feedback so far, I will adjust my branches
accordingly. This will probably take few evenings.

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
