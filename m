Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:65133 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442AbaFBJsd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Jun 2014 05:48:33 -0400
Date: Mon, 2 Jun 2014 11:48:26 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: build-sys: minor issues
Message-ID: <20140602094826.GN9000@x2.net.home>
References: <201406020056.17074.sweet_f_a@gmx.de>
 <201406020233.39094.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201406020233.39094.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 02, 2014 at 02:33:38AM +0200, Ruediger Meier wrote:
> On Monday 02 June 2014, Ruediger Meier wrote:
> > I have two minor issues with our build-sys:
> 
> Another issue:
> 
> 3. --enable-gtk-doc does not work in out-of-tree build:

 I'll try to fix it (it worked time ago if I good remember). Frankly,
 the way how is gtk-doc designed to work with autotools sucks...

 BTW, our TODO:

   * use something better than gtk-doc for libmount and libblkid (doxyden?)

  ;-)

> BTW maybe we could consider about adding these docs to dist tarball to 
> not bother users with gtk-doc deps? (But I know then it's even more 

 Hmm... not sure, I guess the number of people who care about libs
 docs is pretty small and for mainstream distros is the dependence on
 gtk-doc no issue.

> complicated to rebuild cleanly in builddir when the existing one in 
> dist srcdir is outdated.)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
