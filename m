Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41579 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124Ab1HHJv6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 8 Aug 2011 05:51:58 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p789pvEC011858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Mon, 8 Aug 2011 05:51:57 -0400
Received: from nb (ovpn-116-29.ams2.redhat.com [10.36.116.29])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p789pu2O006403
	for <util-linux@vger.kernel.org>; Mon, 8 Aug 2011 05:51:57 -0400
Date: Mon, 8 Aug 2011 11:51:55 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] wall: build with SUID_{C,LD}FLAGS
Message-ID: <20110808095155.GC25933@nb.net.home>
References: <20110802132730.GA2195@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110802132730.GA2195@foxbat.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 02, 2011 at 03:27:32PM +0200, Petr Uzel wrote:
>  term-utils/Makefile.am |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
