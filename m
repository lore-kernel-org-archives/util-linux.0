Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53253 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbaFCKmy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 3 Jun 2014 06:42:54 -0400
Date: Tue, 3 Jun 2014 12:42:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: build-sys: minor issues
Message-ID: <20140603104249.GQ9000@x2.net.home>
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
> 
> $ mkdir build 
> $ cd build
> $ ../configure --enable-gtk-doc 
> $ make V=1
> [...]
> gtkdoc-mkhtml --path="/home/rudi/devel/util-linux/build/libmount/docs:/home/rudi/devel/util-linux/build/libmount/docs/xml:/home/rudi/devel/util-linux/build/../libmount/docs" 
> \
>                  \
>                 libmount \
>                 /home/rudi/devel/util-linux/build/../libmount/docs/libmount-docs.xml
> /home/rudi/devel/util-linux/build/libmount/docs/version.xml:1: parser 
> error : Start tag expected, '<' not found
> 2.24.900-7afc22
> ^
> /home/rudi/devel/util-linux/build/../libmount/docs/libmount-docs.xml:59: 
> element include: XInclude error : could not 
> load /home/rudi/devel/util-linux/libmount/docs/xml/version.xml, and no 
> fallback was found

 Fixed.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
