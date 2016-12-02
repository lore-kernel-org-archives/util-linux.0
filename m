Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759175AbcLBMXI (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 2 Dec 2016 07:23:08 -0500
Date: Fri, 2 Dec 2016 13:23:06 +0100
From: Karel Zak <kzak@redhat.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2] lsns: Fix parser for /proc/<pid>/stat which is
 including space in comm
Message-ID: <20161202122306.ukkas6kck2w6m622@ws.net.home>
References: <87a8cvk01b.fsf@mail.parknet.co.jp>
 <20161122204301.GB21655@vapier.lan>
 <874m2yhj7l.fsf_-_@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <874m2yhj7l.fsf_-_@mail.parknet.co.jp>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 23, 2016 at 02:13:34PM +0900, OGAWA Hirofumi wrote:
>  sys-utils/lsns.c |   30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)

Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
