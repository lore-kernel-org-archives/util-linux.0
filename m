Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42882 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932123AbbGTJ0j (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 20 Jul 2015 05:26:39 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 01BA1A85
	for <util-linux@vger.kernel.org>; Mon, 20 Jul 2015 09:26:38 +0000 (UTC)
Date: Mon, 20 Jul 2015 11:26:37 +0200
From: Karel Zak <kzak@redhat.com>
To: Stef Walter <stefw@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] agetty: Reprompt once the network addresses change if
 address displayed
Message-ID: <20150720092637.GF11633@ws.net.home>
References: <1435928288-25644-1-git-send-email-stefw@redhat.com>
 <20150706140711.GF17734@vapier>
 <559E20A9.7010307@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <559E20A9.7010307@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 09, 2015 at 09:20:09AM +0200, Stef Walter wrote:
> I'm only a sporadic contributor to util-linux. I felt that adding a
> dependency to util-linux wasn't my place to suggest. In addition this
> patch performs very very simple usage of the netlink socket. We don't
> even look at message data.

IMHO it's fine.

> Fixed all of these other review items and pushed the patch here:
> 
> https://github.com/stefwalter/util-linux/commits/agetty-addrchange

 Applied, thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
