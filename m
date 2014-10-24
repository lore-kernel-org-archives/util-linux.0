Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1950 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756398AbaJXM7v (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Oct 2014 08:59:51 -0400
Date: Fri, 24 Oct 2014 14:59:39 +0200
From: Karel Zak <kzak@redhat.com>
To: JWP <elseifthen@gmx.com>
Cc: Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/5] hwclock: clean up message periods/full stops
Message-ID: <20141024125939.GD10134@x2.net.home>
References: <5449BE57.9040203@gmx.com>
 <1414150431.840372.182833341.74402120@webmail.messagingengine.com>
 <544A4817.3070406@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <544A4817.3070406@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Oct 24, 2014 at 08:37:43AM -0400, JWP wrote:
> My sincere oligopolies to translators, but hwclock is slated for refactoring
> and I expect many message changes will be included.  Hopefully, the changes
> will include improving things for translators.

If you really plan to do the refactoring then don't care about
messages at all. The result will be completely different code (I
hope:-). But what we need to to merge all the changes by one pull 
request.

Note that the best is to start with date types, try to describe
hwclock by structs (hwclock_control, hwclock_adjtime, hwclock_hwops,
etc.), then write small functions that work with the structs and then
high level logic. See for example cfdisk.c, losetup.c, name.c...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
