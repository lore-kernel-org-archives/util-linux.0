Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:25816 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639Ab2HBS1G (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 2 Aug 2012 14:27:06 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q72IR6eN005539
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Thu, 2 Aug 2012 14:27:06 -0400
Received: from x2 (ovpn-113-91.phx2.redhat.com [10.3.113.91])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q72IR5b5020891
	for <util-linux@vger.kernel.org>; Thu, 2 Aug 2012 14:27:05 -0400
Date: Thu, 2 Aug 2012 20:27:04 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux <util-linux@vger.kernel.org>
Subject: Re: 2.22-rc1 build fails if configured with --disable-static
Message-ID: <20120802182704.GC8807@x2.net.home>
References: <20120727115523.GA22051@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120727115523.GA22051@foxbat.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 27, 2012 at 01:55:23PM +0200, Petr Uzel wrote:
> I just encountered that 2.22-rc1 build fails if
> 
> ./configure --disable-static
> make
> 
> The error I'm getting is:

 Fixed

  - "make check" is required to build tests

  - ./configure setups BUILD_LIBMOUNT_TESTS and BUILD_LIBBLKID_TESTS
    and the libtool variable $enable_static is required (so
    --disable-static disables the tests too).


 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
