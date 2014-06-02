Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:58372 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752518AbaFBAeI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 1 Jun 2014 20:34:08 -0400
Received: from brln-4db817cb.pool.mediaways.net ([77.184.23.203]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0LoVvG-1WJbCW1pec-00gV3u
 for <util-linux@vger.kernel.org>; Mon, 02 Jun 2014 02:34:06 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: build-sys: minor issues
Date: Mon, 2 Jun 2014 02:33:38 +0200
References: <201406020056.17074.sweet_f_a@gmx.de>
In-Reply-To: <201406020056.17074.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201406020233.39094.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 02 June 2014, Ruediger Meier wrote:
> I have two minor issues with our build-sys:

Another issue:

3. --enable-gtk-doc does not work in out-of-tree build:

$ mkdir build 
$ cd build
$ ../configure --enable-gtk-doc 
$ make V=1
[...]
gtkdoc-mkhtml --path="/home/rudi/devel/util-linux/build/libmount/docs:/home/rudi/devel/util-linux/build/libmount/docs/xml:/home/rudi/devel/util-linux/build/../libmount/docs" 
\
                 \
                libmount \
                /home/rudi/devel/util-linux/build/../libmount/docs/libmount-docs.xml
/home/rudi/devel/util-linux/build/libmount/docs/version.xml:1: parser 
error : Start tag expected, '<' not found
2.24.900-7afc22
^
/home/rudi/devel/util-linux/build/../libmount/docs/libmount-docs.xml:59: 
element include: XInclude error : could not 
load /home/rudi/devel/util-linux/libmount/docs/xml/version.xml, and no 
fallback was found
make[2]: *** [html-build.stamp] Error 6
make[2]: Leaving directory 
`/home/rudi/devel/util-linux/build/libmount/docs'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/rudi/devel/util-linux/build'
make: *** [all] Error 2


BTW maybe we could consider about adding these docs to dist tarball to 
not bother users with gtk-doc deps? (But I know then it's even more 
complicated to rebuild cleanly in builddir when the existing one in 
dist srcdir is outdated.)

cu,
Rudi
