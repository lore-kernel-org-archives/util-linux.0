Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52320 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742Ab3JaMPH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 31 Oct 2013 08:15:07 -0400
Date: Thu, 31 Oct 2013 13:14:56 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [0000/0010] cal: code revisit part I
Message-ID: <20131031121456.GF1536@x2.net.home>
References: <1382906556-16442-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382906556-16442-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Oct 27, 2013 at 08:42:26PM +0000, Sami Kerola wrote:
> I got the --one and --three outputs working, but I am not completely
> happy about the --three.  Quite frankly better function would take input
> how many horizontal calendar outputs are needed, and would do exactly
> that.  Such function would be more reusable when considering yearly
> output, and the fact it has two column output when in julian mode.

 Yes, in the final output function should not be hardcoded a number of
 months -- it would be better to have a generic function that
 is able to use arbitrary list/array of the months. The list/array of
 the months should be composed in another function.
 
 Now it's possible to print only 1, 3 or 12 months, and all is
 hardcoded. It would be nice to have a way how to print arbitrary
 number of months (or arbitrary range).
 
 For example it would be nice to have a way how to specify a quarter 
 of the company fiscal year (!= calendar year). I can imagine
 something like --month=<list> option or so..

> Karel, it is be best not to merge the last patch.  It is more of
> work-in-progress, comments would be great.

 I'll probably wait for whole code refactoring rather than merge
 an incomplete thing.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
