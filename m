Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:8273 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755099AbaELKZS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 12 May 2014 06:25:18 -0400
Date: Mon, 12 May 2014 12:25:10 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Subject: Re: last: please review -F and --time-format
Message-ID: <20140512102510.GB8951@x2.net.home>
References: <201405071631.53729.sweet_f_a@gmx.de>
 <CAG27Bk0fWizWdEhQQUxQNVHp+SsM71qZwqgXgXbhVKxBZkmY+g@mail.gmail.com>
 <201405082226.36617.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201405082226.36617.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 08, 2014 at 10:26:36PM +0200, Ruediger Meier wrote:
> That's a bit ugly to fix without more refactoring. I've tried here to 
> address both issues:
> https://github.com/karelzak/util-linux/pull/73

 Merged, but note that code like:

   if (ctl->time_fmt > LAST_TIMEFTM_SHORT_CTIME)

 is fragile (as someone can modify LAST_TIMEFTM_* enum), it would be
 better to introduce any macro and keep it near to LAST_TIMEFTM_*
 definitions or fix the problem in a better way.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
