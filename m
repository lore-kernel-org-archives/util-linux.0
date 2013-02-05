Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34800 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844Ab3BEJFf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 5 Feb 2013 04:05:35 -0500
Date: Tue, 5 Feb 2013 10:05:24 +0100
From: Karel Zak <kzak@redhat.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH] setpriv: run a program with different Linux privilege
 settings
Message-ID: <20130205090524.GA5047@x2.net.home>
References: <868c8e8b2adbb687bcb6862a7efbab68449c7d5c.1358178937.git.luto@amacapital.net>
 <1359210549-10719-1-git-send-email-kerolasa@iki.fi>
 <CALCETrUgdKwdCCTLEbJFj=P7J5nX6w078TbNeD3AZ5yK7d=gOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALCETrUgdKwdCCTLEbJFj=P7J5nX6w078TbNeD3AZ5yK7d=gOA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 04, 2013 at 12:20:09PM -0800, Andy Lutomirski wrote:
> What's the status of this patch?  I'm not really familiar with the
> merge process for util-linux.

 Be patient, I'm going to merge it.

> FWIW, this code would benefit from s/--caps/--inhcaps/g.  My bad.  I
> can submit a new version or a followup if that would be helpful.

 The latest version is 

    https://github.com/kerolasa/lelux-utiliteetit/commits/setpriv

 Sami did some cosmetic changes to make it more compatible with
 the rest if the util-linux stuff.

 Please, use this version for you changes. A small patch with
 only bugfix or new feature will be fine.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
