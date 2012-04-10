Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:16786 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751284Ab2DJJrN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Apr 2012 05:47:13 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q3A9lCfj025758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 10 Apr 2012 05:47:13 -0400
Received: from x2 (ovpn-116-49.ams2.redhat.com [10.36.116.49])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q3A9lBtr028291
	for <util-linux@vger.kernel.org>; Tue, 10 Apr 2012 05:47:12 -0400
Date: Tue, 10 Apr 2012 11:47:11 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] fsck: don't free fstab table on parse failure
Message-ID: <20120410094711.GB18900@x2.net.home>
References: <1332852838-6188-1-git-send-email-dreisner@archlinux.org>
 <20120409141226.GA843@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120409141226.GA843@rampage>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Apr 09, 2012 at 10:12:26AM -0400, Dave Reisner wrote:
> On Tue, Mar 27, 2012 at 08:53:58AM -0400, Dave Reisner wrote:
> > Even if we fail parsing, fstab gets referenced later in the code (and
> > will subsequently crash via heap corruption). Take the easy way out and
> > simply avoid deallocating this table, as it will be freed for us on
> > program exit regardless.
> > 
> > Signed-off-by: Dave Reisner <dreisner@archlinux.org>
> > ---
> 
> Pinging this, as it doesn't seem it was merged...

 Sorry, somehow marked as applied in my u-l mail folder, but not
 applied in git.

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
