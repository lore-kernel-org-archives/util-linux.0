Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46029 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260AbcDGHpW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 7 Apr 2016 03:45:22 -0400
Date: Thu, 7 Apr 2016 09:45:20 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Isaac Dunham <ibid.ag@gmail.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] tests: test_md5 prints md5sum only
Message-ID: <20160407074520.2odjbvim2z35xgjg@ws.net.home>
References: <1459938618-20153-1-git-send-email-sweet_f_a@gmx.de>
 <201604061940.22739.sweet_f_a@gmx.de>
 <20160406213809.GA6396@newbook>
 <201604070036.47481.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201604070036.47481.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 07, 2016 at 12:36:47AM +0200, Ruediger Meier wrote:
> > however, one or two of them will probably break 
> > due to the shell not working the same (parameter subsitution inside
> > shell aritmetic inside $().).
> > Similarly, -f is the only readlink option that seems to be used.
> > (Busybox supports this.)
> 
> Unfortunately readlink -f is the most useful option of readlink. But 
> probably we wouldn't need it always where we are using it right now.

BTW, we have lib/canonicalize.c, so write replacement for readlink -f
for our tests is trivial.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
