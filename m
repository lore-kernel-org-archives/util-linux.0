Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:9422 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754995Ab2IUKor (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 21 Sep 2012 06:44:47 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q8LAikAv024600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 21 Sep 2012 06:44:46 -0400
Date: Fri, 21 Sep 2012 12:44:44 +0200
From: Karel Zak <kzak@redhat.com>
To: Milan Broz <mbroz@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] mkswap: wipe old signature if there is no part table by
 default
Message-ID: <20120921104444.GC13710@x2.net.home>
References: <1347274719-26869-1-git-send-email-mbroz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1347274719-26869-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Sep 10, 2012 at 12:58:39PM +0200, Milan Broz wrote:
>  disk-utils/mkswap.8 |    5 ++---
>  disk-utils/mkswap.c |   47 ++++++++++++++++++++---------------------------
>  2 files changed, 22 insertions(+), 30 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
