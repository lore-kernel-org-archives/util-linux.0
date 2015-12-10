Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:61948 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873AbbLJW60 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 10 Dec 2015 17:58:26 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Yoss@gmx.net
Subject: Re: bug in "mount --bind" for hashed tree indexed directories
Date: Thu, 10 Dec 2015 23:58:23 +0100
Cc: util-linux@vger.kernel.org
References: <trinity-01dc6d15-b86a-49f7-bd1c-6b0c22554b9d-1449786251438@3capp-gmx-bs27>
In-Reply-To: <trinity-01dc6d15-b86a-49f7-bd1c-6b0c22554b9d-1449786251438@3capp-gmx-bs27>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201512102358.23577.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 10 December 2015, Yoss@gmx.net wrote:

> Additional notes:
> The problem seem to be more complex, because if a 'echo "test" >>
> /etc/testa' is used, it works. But after a change with vi, echo
> doesn't works too. Practical background is the use of mount --bind in
> a bind (named) chroot environment. A change of /etc/named.conf will
> not result in an update of /var/named/chroot/etc/named.conf.

Why don't you use a hardlink?
$ cp -al /etc/named.conf /var/named/chroot/etc/named.conf

Then vim will automatically change it's behavior and saves changes 
in-place.

cu,
Rudi
