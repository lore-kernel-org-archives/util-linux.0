Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:30426 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816Ab2KPIgh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 16 Nov 2012 03:36:37 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qAG8aaf3023967
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 16 Nov 2012 03:36:36 -0500
Received: from x2 (ovpn-113-46.phx2.redhat.com [10.3.113.46])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id qAG8aZRN019245
	for <util-linux@vger.kernel.org>; Fri, 16 Nov 2012 03:36:36 -0500
Date: Fri, 16 Nov 2012 09:36:34 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: Re: vlock command
Message-ID: <20121116083634.GA29284@x2.net.home>
References: <20121114103509.GD1835@x2.net.home>
 <50A37AD8.6060601@gmail.com>
 <20121114122207.GE1835@x2.net.home>
 <20121114235426.GE20303@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121114235426.GE20303@altlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 15, 2012 at 03:54:27AM +0400, Dmitry V. Levin wrote:

> Well, could you then explain why do you keep that
> 7 year old vlock-1.3-morepam.patch from Nalin in Fedora vlock package?

...to make it compatible with many others PAM applications. It's
common practice to use pam_authenticate() + pam_acct_mgmt() +
pam_setcred().  I don't think it's good idea to make any exceptions
from this practice.

You need pam_acct_mgmt() to check account validity, expiration etc.

> It does something unnatural for vlock, e.g. pam_acct_mgmt and even
> pam_setcred!  At the same time, the only module in its account stack is
> pam_permit.so.  Weird.

Well, it's only config file, $EDITOR /etc/pam.d/vlock is enough to
make your configuration more paranoid. It's definitely better to
support all the features by binary and define policies in config
files.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
