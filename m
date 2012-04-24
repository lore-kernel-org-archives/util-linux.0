Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20252 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757190Ab2DXRuz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Apr 2012 13:50:55 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q3OHosVw013659
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 24 Apr 2012 13:50:54 -0400
Received: from x2 (ovpn-116-57.ams2.redhat.com [10.36.116.57])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q3OHorOJ006646
	for <util-linux@vger.kernel.org>; Tue, 24 Apr 2012 13:50:54 -0400
Date: Tue, 24 Apr 2012 19:50:53 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: Re: findmnt: determine mount by pointing to a subdirectory
Message-ID: <20120424175053.GB17370@x2.net.home>
References: <20120424152658.GC3813@magazyn-ziarno.zbozowa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120424152658.GC3813@magazyn-ziarno.zbozowa>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 24, 2012 at 05:26:58PM +0200, Marcin Szewczyk wrote:
> Hi again,
> 
> one last issue I have with findmnt is that it seems that it won't show
> any output if I point to a subdirectory of a mountpoint. For example
> when the whole system is mounted from a single partition and I would
> like findmnt to show me some information about / by pointing to
> /boot/extlinux.
> 
> The idea is based on the df command capability to do such a thing. But
> df gives less options in general. I would like to patch one of Debian's
> scripts in the extlinux package. Now it uses df to determine drive where
> the /boot/extlinux directory resides. It causes problems if / is AUFS.
> Findmnt will show the correct block device but I have to loop cutting
> off path segments one by one and check if I can find a mount.
> 
> Have I missed something? Or is there a possibility of having this kind
> of functionality in the future?

 Yes, I'll implement it.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
