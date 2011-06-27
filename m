Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:4829 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752577Ab1F0P7R (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Jun 2011 11:59:17 -0400
Date: Mon, 27 Jun 2011 17:59:14 +0200
From: Karel Zak <kzak@redhat.com>
To: Marek Otahal <markotahal@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: mount: if mount -a crashes on one partition, remaining should
	be probed
Message-ID: <20110627155914.GD6418@nb.net.home>
References: <201106071151.18570.markotahal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201106071151.18570.markotahal@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 07, 2011 at 11:51:17AM +0200, Marek Otahal wrote:
> with 2.6.39 kernel I can get in conditions when mounting a btrfs
> partition segfaults (I already reported upstream -
> http://article.gmane.org/gmane.comp.file-systems.btrfs/11135 ).

 If the oops occur in any process (except init) then the process is
 usually killed by kernel... so it really does not seem like mount(8)
 bug.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
