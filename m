Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39056 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756878Ab2DXRww (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Apr 2012 13:52:52 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q3OHqp9c003817
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 24 Apr 2012 13:52:52 -0400
Received: from x2 (ovpn-116-57.ams2.redhat.com [10.36.116.57])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q3OHqoLQ007180
	for <util-linux@vger.kernel.org>; Tue, 24 Apr 2012 13:52:51 -0400
Date: Tue, 24 Apr 2012 19:52:50 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: Re: findmnt: parsing mountpoints with spaces
Message-ID: <20120424175250.GC17370@x2.net.home>
References: <20120424144055.GB3813@magazyn-ziarno.zbozowa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120424144055.GB3813@magazyn-ziarno.zbozowa>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 24, 2012 at 04:40:55PM +0200, Marcin Szewczyk wrote:
> Hi,
> 
> is there a way to make findmnt print unambiguous output in case of block
> devices/directories/mountpoints whose names contain spaces? I can see
> that --raw makes findmnt print undecorated output, but spaces remain not
> escaped.
> 
> May I request a feature of escaping spaces and possibly other
> non-printable characters in a fstab manner (\040 for space)?

 Good point, I have already added this to lsblk for LABELs in parsable
 output, it seems that we need this for mountpoint and findmnt too.

 Added to my TODO. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
