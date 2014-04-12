Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f47.google.com ([209.85.220.47]:50503 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbaDLQfj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 12 Apr 2014 12:35:39 -0400
Received: by mail-pa0-f47.google.com with SMTP id lj1so6616983pab.34
        for <util-linux@vger.kernel.org>; Sat, 12 Apr 2014 09:35:39 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <53496267.80502@bernhard-voelker.de>
References: <1397298524-3364-1-git-send-email-kerolasa@iki.fi>
	<1397298524-3364-2-git-send-email-kerolasa@iki.fi>
	<53496267.80502@bernhard-voelker.de>
Date: Sat, 12 Apr 2014 17:35:39 +0100
Message-ID: <CAG27Bk1r5-2bRfn+t+jRZJ=CQKDoiAJEwP7RAGd84En+ZJ2r3A@mail.gmail.com>
Subject: Re: [PATCH 1/7] kill: make options --pid and --queue mutually exclusive
From: Sami Kerola <kerolasa@iki.fi>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 12 April 2014 16:57, Bernhard Voelker <mail@bernhard-voelker.de> wrote:
> On 04/12/2014 12:28 PM, Sami Kerola wrote:
>> +                     if (ctl->use_sigval)
>> +                             errx(EXIT_FAILURE, _("%s and %s are mutually exclusive"), "--pid", "--queue");
>
> Ain't this a good case for
>   err_exclusive_options(c, longopts, excl, excl_st);

Hello Berny,

Yes if kill would use getopts_long(). The kill should probably have
long options, but that is a different change than mutual option
exclusion.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
