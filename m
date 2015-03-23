Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40005 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261AbbCWJVh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Mar 2015 05:21:37 -0400
Date: Mon, 23 Mar 2015 10:21:35 +0100
From: Karel Zak <kzak@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: util-linux@vger.kernel.org
Subject: Re: unshare(1) --propagation
Message-ID: <20150323092135.GC1749@ws.net.home>
References: <20150318172603.GE28925@ws.net.home>
 <87y4moam1e.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87y4moam1e.fsf@x220.int.ebiederm.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 22, 2015 at 02:07:25PM -0500, Eric W. Biederman wrote:
> It might surprise a few folks that 
> "--propagation shared" and "--propagation off" are do not do
> the same thing..  But otherwise as far as functionality this looks
> fine.
> 
> I will suggest instead of calling it "--propagation off" you
> call it "--propagation unchanged".

 Good idea, changed.

> I also think --propagation private is much less likely to burn folks.
> 
> Of course the flip side is that as soon as they finish prototyping and
> start putting their logic in an application they will get burned.  But
> there is only so much a person can do.  And "--propagation private" is
> a common enough desire I think it makes sense.  Especially since
> "--propagation private" is what any sane person will expect to happen.

 Yep, thanks for review.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
