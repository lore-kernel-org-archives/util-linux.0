Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:29526 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751894Ab1I0NgU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 27 Sep 2011 09:36:20 -0400
Date: Tue, 27 Sep 2011 15:35:52 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/7] sfdisk improvements
Message-ID: <20110927133552.GD1982@nb.net.home>
References: <1316438955-20790-1-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316438955-20790-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Sep 19, 2011 at 03:29:08PM +0200, Petr Uzel wrote:
> Third one makes sfdisk not to issue a fatal warning (overridable, though),
> if the partition does not start/end on the cylinder boundary and
> the unit specified is other than cylinders. These days,
> we shouldn't care about the CHS that much IMO...

 Right, see also cc393e381def1540db7b1273dde9410bea616b22. Giulio has
 added some improvements for -L (Linux) option to disable some silly
 tests.

> I decided to use unsigned long long to represent the 64-bit integers,
> which might not be the best choice (maybe we should use off_t or uint64_t
> instead??). Comments are welcomed.

 Well, "unsigned long long" is horribly long, but probably good enough
 for now (as we already using this type in fdisk.c).

 The real solution is to start to work on a new fdisks...

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
