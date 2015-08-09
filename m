Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35549 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933105AbbHIR6Q (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Aug 2015 13:58:16 -0400
Received: by wibxm9 with SMTP id xm9so114399547wib.0
        for <util-linux@vger.kernel.org>; Sun, 09 Aug 2015 10:58:15 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20150809171906.GA27138@cantor.unex.es>
References: <alpine.DEB.2.11.1508091638320.23243@cantor.unex.es>
	<7302EB7B-64A1-44E7-B2C2-E28D22FDED7D@staff.uni-marburg.de>
	<20150809171906.GA27138@cantor.unex.es>
Date: Sun, 9 Aug 2015 18:58:15 +0100
Message-ID: <CAG27Bk2LoBzp122dkL7npkMSa0iEEVajE3EqMVFYnPbn5zDBHA@mail.gmail.com>
Subject: Re: "mesg n" exits with error, even if the command is successful
From: Sami Kerola <kerolasa@iki.fi>
To: Santiago Vila <sanvila@unex.es>
Cc: Reuti <reuti@staff.uni-marburg.de>,
        util-linux <util-linux@vger.kernel.org>, ah-util-linux@debian.org,
        794727@bugs.debian.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 9 August 2015 at 18:19, Santiago Vila <sanvila@unex.es> wrote:
> On Sun, Aug 09, 2015 at 07:14:30PM +0200, Reuti wrote:
>> The profile is usually sourced. How does the error show up at the login prompt on Debian?
>
> The problem only happens in Debian testing and unstable, which I am not using yet.
> This is the original report which I received against base-files:
>
> https://bugs.debian.org/794727

Please notice the mesg(1) exit behavior is defined in POSIX

http://pubs.opengroup.org/onlinepubs/9699919799/utilities/mesg.html

Unfortunately the standard does not appear to be explicit whether the
exit value should be set only when requesting write permissions
(running without arguments), or if also when setting the permissions.
IMHO the reasonable thing to do is to leave the return codes as they
are to avoid breakage in existing usage. If someone needs messaging
setting not to report exit codes then this functionality is safest to
introduce with new option, such as --no-exit-code-status

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
