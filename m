Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37797 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756172Ab1KVOr5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 22 Nov 2011 09:47:57 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pAMElviD014716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 22 Nov 2011 09:47:57 -0500
Date: Tue, 22 Nov 2011 15:47:55 +0100
From: Karel Zak <kzak@redhat.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [patch] Enable fstab.d in mount -a
Message-ID: <20111122144755.GY7916@nb.net.home>
References: <20111114.224753.785892012923334635.yamato@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111114.224753.785892012923334635.yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 14, 2011 at 10:47:53PM +0900, Masatake YAMATO wrote:
> This patch makes mount command read fstab.d/*.fstab if the command
> is built with --enable-libmount-mount.  

 Applied (with minor changes). Thanks! It was in my TODO for the next
 release.
 
 I have also updated fstab.5 and mount.8 man pages.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
