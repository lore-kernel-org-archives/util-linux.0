Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40283 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751238AbbIXKte (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 24 Sep 2015 06:49:34 -0400
Date: Thu, 24 Sep 2015 12:49:32 +0200
From: Karel Zak <kzak@redhat.com>
To: Oliver Freyermuth <o.freyermuth@googlemail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [Regression] util-linux-2.27: zramctl lists same info for all
 devices (DATA COMPR TOTAL)
Message-ID: <20150924104932.GC1787@ws.net.home>
References: <55EDD791.30606@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55EDD791.30606@googlemail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Sep 07, 2015 at 08:29:37PM +0200, Oliver Freyermuth wrote:
> I guess it is related to commit
> 5388c862607ec4f25f3e7ad23ab858b696bde1a1 .  It parses mmstat and
> fills in z->mm_stat and z->mm_stat_probed only the first time
> get_mm_stat is called. Since the codes reuses the very same
> zram-struct "z" afterwards and z->mm_stat is never freed (and
> z->mm_stat_probed is never reset), only the first device is every
> queried. 

Yes, fixed (will be in v2.27.1). Thanks for your report!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
