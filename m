Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38014 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030618AbcCQNdn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Mar 2016 09:33:43 -0400
Date: Thu, 17 Mar 2016 14:33:41 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org, Andreas Henriksson <andreas@fatal.se>
Subject: Re: [PATCH] tests: fix fdisk/bsd for alpha
Message-ID: <20160317133341.fwjakpzsdln3oivg@ws.net.home>
References: <1458088844-23523-1-git-send-email-sweet_f_a@gmx.de>
 <20160316113741.cdm4hrufcoiki5ae@ws.net.home>
 <20160316131107.4orceajqir34wavj@ws.net.home>
 <201603161627.10907.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201603161627.10907.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 16, 2016 at 04:27:10PM +0100, Ruediger Meier wrote:
> And we could disable setarch's uname26 test because
> # glibc requires kernel >= 3.0, thus setarch --uname-2.6 fails
> # on platforms without VDSO

OK, added exception for sparc.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
