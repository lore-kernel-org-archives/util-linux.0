Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38150 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755834AbcETJYq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 20 May 2016 05:24:46 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7976B49469
	for <util-linux@vger.kernel.org>; Fri, 20 May 2016 09:24:45 +0000 (UTC)
Received: from ws (ovpn-204-89.brq.redhat.com [10.40.204.89])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u4K9OihC021219
	for <util-linux@vger.kernel.org>; Fri, 20 May 2016 05:24:45 -0400
Date: Fri, 20 May 2016 11:24:44 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] Use the plymouth local protocol instead the plymouth
 binary
Message-ID: <20160520092444.bxlos6r52kazytjl@ws.net.home>
References: <1461324096-29280-1-git-send-email-werner@suse.de>
 <20160505094245.6frwtvaxoueyrfw7@ws.net.home>
 <20160517101838.2x7fi3zg5u4r2gjz@boole.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160517101838.2x7fi3zg5u4r2gjz@boole.suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 17, 2016 at 12:18:38PM +0200, Dr. Werner Fink wrote:
>  include/plymouth-ctrl.h |  65 +++++++++++++++++++++
>  lib/Makemodule.am       |   1 +
>  lib/plymouth-ctrl.c     | 147 ++++++++++++++++++++++++++++++++++++++++++++++++
>  login-utils/sulogin.c   |  44 ++-------------
>  term-utils/agetty.c     |  48 ++--------------
>  5 files changed, 223 insertions(+), 82 deletions(-)
>  create mode 100644 include/plymouth-ctrl.h
>  create mode 100644 lib/plymouth-ctrl.c

 Applied with minor changes, thanks.
    
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
