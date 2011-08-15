Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52878 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751967Ab1HOMgM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 15 Aug 2011 08:36:12 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7FCaCfC017534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Mon, 15 Aug 2011 08:36:12 -0400
Received: from nb (ovpn-116-29.ams2.redhat.com [10.36.116.29])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p7FCaBE2023104
	for <util-linux@vger.kernel.org>; Mon, 15 Aug 2011 08:36:12 -0400
Date: Mon, 15 Aug 2011 14:36:11 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] hexdump: fix segfault due to uninitialized memory
Message-ID: <20110815123611.GD2038@nb.net.home>
References: <20110810133227.GA14002@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110810133227.GA14002@foxbat.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 10, 2011 at 03:32:28PM +0200, Petr Uzel wrote:
>  text-utils/display.c |    4 ++--
>  text-utils/parse.c   |    6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
