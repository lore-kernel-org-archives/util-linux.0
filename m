Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28887 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609Ab1I0NDt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 27 Sep 2011 09:03:49 -0400
Date: Tue, 27 Sep 2011 15:03:23 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux <util-linux@vger.kernel.org>, Michal Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH] flock: make flock(3) work on NFSv4
Message-ID: <20110927130323.GB19994@nb.net.home>
References: <20110915081916.GA11152@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110915081916.GA11152@foxbat.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Sep 15, 2011 at 10:19:17AM +0200, Petr Uzel wrote:
>  sys-utils/flock.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
