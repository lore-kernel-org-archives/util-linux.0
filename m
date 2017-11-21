Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751232AbdKUJoG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 21 Nov 2017 04:44:06 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 281156868A
        for <util-linux@vger.kernel.org>; Tue, 21 Nov 2017 09:44:06 +0000 (UTC)
Date: Tue, 21 Nov 2017 10:44:01 +0100
From: Karel Zak <kzak@redhat.com>
To: Andy Grover <agrover@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Mark char* params to blkid_dev_set_search as const
Message-ID: <20171121094401.ynkxphecqkyly5bk@ws.net.home>
References: <20171120200950.11377-1-agrover@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171120200950.11377-1-agrover@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 20, 2017 at 12:09:50PM -0800, Andy Grover wrote:
>  libblkid/src/blkid.h.in | 2 +-
>  libblkid/src/dev.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
