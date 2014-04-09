Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20012 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460AbaDIHwZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Apr 2014 03:52:25 -0400
Date: Wed, 9 Apr 2014 09:52:15 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Thomas =?iso-8859-1?Q?B=E4chler?= <thomas@archlinux.org>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] fstrim: add systemd units
Message-ID: <20140409075215.GP22126@x2.net.home>
References: <1396561311-12825-1-git-send-email-thomas@archlinux.org>
 <201404081225.21563.sweet_f_a@gmx.de>
 <5343D600.7000507@archlinux.org>
 <201404081407.29362.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201404081407.29362.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 08, 2014 at 02:07:28PM +0200, Ruediger Meier wrote:
> I don't say something against systemd here and I don't see this black 
> and white only. I'am just against adding sysadmin scripts which 
> actually do only trivial things. 

Well, it's not so important if the file is trivial or non-trivial --
the overhead for distributions is usually almost the same. It's always
cheaper to maintain distribution independent stuff on one shared place.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
