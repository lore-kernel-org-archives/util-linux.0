Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37691 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756027AbbJILO5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 9 Oct 2015 07:14:57 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id EB7CE8F2E4
	for <util-linux@vger.kernel.org>; Fri,  9 Oct 2015 11:14:56 +0000 (UTC)
Date: Fri, 9 Oct 2015 13:14:55 +0200
From: Karel Zak <kzak@redhat.com>
To: Ian Wienand <iwienand@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libfdisk: Detect out-of-space when adding new primary
 partition
Message-ID: <20151009111455.GD2356@ws.net.home>
References: <5615EA6C.8000801@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5615EA6C.8000801@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 08, 2015 at 03:00:44PM +1100, Ian Wienand wrote:
>  libfdisk/src/dos.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
