Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55397 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895Ab1F0OWt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Jun 2011 10:22:49 -0400
Date: Mon, 27 Jun 2011 16:22:45 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] blkdev: add blkdev_get_physector_size()
Message-ID: <20110627142245.GA14747@nb.net.home>
References: <1308625104.3690.1.camel@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308625104.3690.1.camel@offworld>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 20, 2011 at 10:58:24PM -0400, Davidlohr Bueso wrote:
>  include/blkdev.h |    3 +++
>  lib/blkdev.c     |   14 ++++++++++++++
>  2 files changed, 17 insertions(+), 0 deletions(-)

 Applied with minor changes, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
