Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f176.google.com ([209.85.192.176]:46142 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933AbaKKWvl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 11 Nov 2014 17:51:41 -0500
Received: by mail-pd0-f176.google.com with SMTP id ft15so10884866pdb.7
        for <util-linux@vger.kernel.org>; Tue, 11 Nov 2014 14:51:41 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20141111021033.GF3652@vapier.wh0rd.info>
References: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
	<1415656195-20458-2-git-send-email-kerolasa@iki.fi>
	<20141111021033.GF3652@vapier.wh0rd.info>
Date: Tue, 11 Nov 2014 22:51:41 +0000
Message-ID: <CAG27Bk1i9rcU+c26YumioUHWmSL+AZqT=mop+rwEpErQaDDmgw@mail.gmail.com>
Subject: Re: [PATCH 1/6] build-sys: make scanf_cv_alloc_modifier to work [AddressSanitizer]
From: Sami Kerola <kerolasa@iki.fi>
To: Sami Kerola <kerolasa@iki.fi>, util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 11 November 2014 02:10, Mike Frysinger <vapier@gentoo.org> wrote:
> On 10 Nov 2014 21:49, Sami Kerola wrote:
>> The tests failed with following message in config.log
>>
>> ERROR: LeakSanitizer: detected memory leaks
>
> nit: the subject says ASAN but this is fixing an LSAN bug ;)

Thanks Mike,

Message is reworded, and I added you as Reviewed-by.

https://github.com/kerolasa/lelux-utiliteetit/commit/b29fbfdb3a83d6dd1215280c24422150baa8b477

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
