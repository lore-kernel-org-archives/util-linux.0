Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1719 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018Ab1HOMfm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 15 Aug 2011 08:35:42 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7FCZgCK028002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Mon, 15 Aug 2011 08:35:42 -0400
Received: from nb (ovpn-116-29.ams2.redhat.com [10.36.116.29])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p7FCZfnF010492
	for <util-linux@vger.kernel.org>; Mon, 15 Aug 2011 08:35:42 -0400
Date: Mon, 15 Aug 2011 14:35:41 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] dmesg: avoid mess at the end of dmesg output
Message-ID: <20110815123541.GC2038@nb.net.home>
References: <20110810121639.GA19672@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110810121639.GA19672@foxbat.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 10, 2011 at 02:16:40PM +0200, Petr Uzel wrote:
>  sys-utils/dmesg.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
