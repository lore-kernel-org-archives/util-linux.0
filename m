Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:24676 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475Ab2A3Jnh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 30 Jan 2012 04:43:37 -0500
Date: Mon, 30 Jan 2012 10:43:33 +0100
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: fs locks: export informational name
Message-ID: <20120130094333.GA14284@x2.net.home>
References: <1327765053.3336.7.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327765053.3336.7.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sat, Jan 28, 2012 at 04:37:33PM +0100, Davidlohr Bueso wrote:
> I'm currently rewritting lslk(8) from scratch so we can integrate it in
> util-linux, and continue maintaining it.
> 
> In order to not break userspace, the kernel is currently exporting the
> major:minor numbers of the device where the locked file resides.  Could
> we agree on defining WE_CAN_BREAK_LSLK_NOW and start exporting the
> informational name instead?

 --disable-lslk should be enough :-)

 We can support DEV column (with maj:min), but not use it on the
 default output please. We have ReleaseNotes and man page where we can
 describe possible differences between original and u-l version.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
