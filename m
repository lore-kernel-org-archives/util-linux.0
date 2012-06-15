Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53138 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756298Ab2FOJxW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 15 Jun 2012 05:53:22 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q5F9rLRI017838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 15 Jun 2012 05:53:21 -0400
Date: Fri, 15 Jun 2012 11:53:14 +0200
From: Karel Zak <kzak@redhat.com>
To: Milan Broz <mbroz@redhat.com>
Cc: util-linux@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH] libblkid: update dm-verity scan
Message-ID: <20120615095314.GE16531@x2.net.home>
References: <1338550448-13005-1-git-send-email-mbroz@redhat.com>
 <1339499882-1432-1-git-send-email-mbroz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339499882-1432-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 12, 2012 at 01:18:02PM +0200, Milan Broz wrote:
>  libblkid/src/superblocks/lvm.c |   33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
