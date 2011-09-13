Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:9765 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185Ab1IMJix (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 13 Sep 2011 05:38:53 -0400
Date: Tue, 13 Sep 2011 11:38:50 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux <util-linux@vger.kernel.org>, Neil F Brown <nfbrown@suse.com>
Subject: Re: [PATCH] lib: do not attempt to close(0) in sysfs_deinit()
Message-ID: <20110913093850.GI16902@nb.net.home>
References: <20110913090845.GA8203@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110913090845.GA8203@foxbat.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 13, 2011 at 11:08:46AM +0200, Petr Uzel wrote:
>  lib/sysfs.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
