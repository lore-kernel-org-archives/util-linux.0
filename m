Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55009 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754595Ab2I0XN0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 27 Sep 2012 19:13:26 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q8RNDQqO015734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Thu, 27 Sep 2012 19:13:26 -0400
Date: Fri, 28 Sep 2012 01:13:24 +0200
From: Karel Zak <kzak@redhat.com>
To: Lukas Czerner <lczerner@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] blkdiscard: add new command
Message-ID: <20120927231324.GA7822@x2.net.home>
References: <1347486555-24330-1-git-send-email-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1347486555-24330-1-git-send-email-lczerner@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 12, 2012 at 05:49:15PM -0400, Lukas Czerner wrote:
>  sys-utils/Makemodule.am |    5 ++
>  sys-utils/blkdiscard.8  |   66 ++++++++++++++++++
>  sys-utils/blkdiscard.c  |  173 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 245 insertions(+), 0 deletions(-)
>  create mode 100644 sys-utils/blkdiscard.8
>  create mode 100644 sys-utils/blkdiscard.c

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
