Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:41590 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332AbcDRPwO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Apr 2016 11:52:14 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1asBT1-0007Mb-28
	for util-linux@vger.kernel.org; Mon, 18 Apr 2016 17:52:03 +0200
Received: from ppp37-190-56-88.pppoe.spdop.ru ([37.190.56.88])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 18 Apr 2016 17:52:03 +0200
Received: from yumkam by ppp37-190-56-88.pppoe.spdop.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 18 Apr 2016 17:52:03 +0200
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: Re: [PATCH] nsenter: fix ability to enter unprivileged containers
Date: Mon, 18 Apr 2016 18:51:52 +0300
Message-ID: <m34maylxt3.fsf@gmail.com>
References: <1460982392.2452.6.camel@HansenPartnership.com>
	<m3ega3kmvr.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

yumkam@gmail.com (Yuriy M. Kaminskiy) writes:

> # nsenter --mount=/run/build-container/aarch64 nsenter --user=/dev/fd/3 3</run/build-container/user
>   
> (disclaimer: unverified;

Just for record,
1) above workaround verified/works;
2) and this part:

> on my kernel mount-bind fails for mount-ns fds).

was *my* mistake (I somehow missed mount-ns peculiarity about incompatibility
with shared propagation [it is documented in unshare(1)])

