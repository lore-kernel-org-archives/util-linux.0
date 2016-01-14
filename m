Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36504 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753598AbcANKcB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Jan 2016 05:32:01 -0500
Date: Thu, 14 Jan 2016 11:31:58 +0100
From: Karel Zak <kzak@redhat.com>
To: Fredrik Johnsson <fredrik.johnsson@axis.com>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: Cyclic dependency with systemd?
Message-ID: <20160114103158.rffxxsnkn466ofj5@ws.net.home>
References: <1452762264910.97373@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452762264910.97373@axis.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 14, 2016 at 09:04:25AM +0000, Fredrik Johnsson wrote:
> I have not run into any problems myself but can this be an issue? In
> theory: If you compile systemd without util-linux, it should fail
> because it needs libmount, and if you try to compile util-linux, it
> should also fail because it needs sd_booted from libsystemd.

The dependence on libsystemd is optional: 

 1/ build util-linux --without-systemd
 2/ build systemd
 3/ re-build util-linux --with-systemd

anyway, people usually don't build all from scratch. If you already
have system with all the dependencies then you can build without extra
care about this issue.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
