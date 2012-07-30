Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55090 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753909Ab2G3QCL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 30 Jul 2012 12:02:11 -0400
Date: Mon, 30 Jul 2012 18:02:03 +0200
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Subject: Re: 2.22-rc1 build fails if configured with --disable-static
Message-ID: <20120730160203.GL5845@x2.net.home>
References: <20120727115523.GA22051@foxbat.suse.cz>
 <CAG27Bk2UuPG3++nU5dZzKjJgAiNRP0PEFhFLZ0QBSDDU=tXNMg@mail.gmail.com>
 <201207300949.29940.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201207300949.29940.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 30, 2012 at 09:49:29AM -0400, Mike Frysinger wrote:
> >  noinst_PROGRAMS += \
> >  	test_blkid_cache \
> >  	test_blkid_config \
> 
> these should be in check_PROGRAMS

 Ah, nice idea. Fixed. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
