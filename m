Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36970 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964817AbcCONKi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Mar 2016 09:10:38 -0400
Date: Tue, 15 Mar 2016 14:10:34 +0100
From: Karel Zak <kzak@redhat.com>
To: George Spelvin <linux@horizon.com>
Cc: util-linux@vger.kernel.org
Subject: Re: e2fsck: /dev/hda2 is mounted.
Message-ID: <20160315131034.gju5rtzm2uacjs7a@ws.net.home>
References: <20160313101414.19038.qmail@ns.horizon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160313101414.19038.qmail@ns.horizon.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 13, 2016 at 06:14:14AM -0400, George Spelvin wrote:
> Upon investigation, it turned out that fsck didn't understand the
> kernel "root=302" parameter and was trying to run e2fsck on the root
> file system.  This produced an error, causing the boot process
> to drop into a recovery shell.
...
> Running the v2.28-rc1 release (8c97556ecfc0af358d35dc7a842aaadde5eeafd3)
> I got some compile warnings (appended for reference), but a
> working execurable which could be run as follows:

The problem should be fixed, git pull, make and re-test, please.

Thanks
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
