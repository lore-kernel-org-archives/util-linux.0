Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37021 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876AbcDRLWZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Apr 2016 07:22:25 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D85C0C049D7F
	for <util-linux@vger.kernel.org>; Mon, 18 Apr 2016 11:22:24 +0000 (UTC)
Received: from ws (ovpn-204-89.brq.redhat.com [10.40.204.89])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u3IBMNH5017063
	for <util-linux@vger.kernel.org>; Mon, 18 Apr 2016 07:22:24 -0400
Date: Mon, 18 Apr 2016 13:22:23 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: Re: libmount python bindings and header includes
Message-ID: <20160418112223.shsjbjwfmfqimnai@ws.net.home>
References: <20160412174653.GA6588@vapier.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160412174653.GA6588@vapier.lan>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 12, 2016 at 01:46:53PM -0400, Mike Frysinger wrote:
> i'm currently seeing these build warnings:
> libmount/python/fs.c:110:40: warning: implicit declaration of function 'major'
> libmount/python/fs.c:111:7: warning: implicit declaration of function 'minor'
> 
> this is handled for most of the code in include/c.h:
> #ifdef HAVE_SYS_SYSMACROS_H
> # include <sys/sysmacros.h>     /* for major, minor */
> #endif
> 
> but the python code doesn't include that header.  i'm not sure what the
> preference is here (make the python code pull in that header or just copy
> over the sysmacros.h logic), so i'm skipping writing a patch.

Our c.h is so wonderful that it's expected everywhere :) Fixed.

Thanks!
    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
