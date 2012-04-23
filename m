Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:12872 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752361Ab2DWMDx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Apr 2012 08:03:53 -0400
Date: Mon, 23 Apr 2012 14:02:44 +0200
From: Karel Zak <kzak@redhat.com>
To: chas williams - CONTRACTOR <chas@cmf.nrl.navy.mil>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] login-utils: use getdtablesize() correctly in login.c
Message-ID: <20120423120244.GI11847@x2.net.home>
References: <20120420105828.554ce55a@thirdoffive.cmf.nrl.navy.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120420105828.554ce55a@thirdoffive.cmf.nrl.navy.mil>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Apr 20, 2012 at 10:58:28AM -0400, chas williams - CONTRACTOR wrote:
>     login-utils: use getdtablesize() correctly in login.c
>     
>     getdtablesize() is the number of descriptors and since decriptors start
>     at 0, its value isnt the largest descriptors possible.  One should use
>     getdtablesize() - 1 instead.

 Applied, thanks.

 I have also added fallback for the getdtablesize() to lib/fileutils.c, it
 seems that the function is not too portable.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
