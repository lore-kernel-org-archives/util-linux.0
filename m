Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57569 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754540Ab3ITLGu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 20 Sep 2013 07:06:50 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r8KB6oS2017664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 20 Sep 2013 07:06:50 -0400
Date: Fri, 20 Sep 2013 13:06:48 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Ondrej Oprala <ooprala@redhat.com>
Subject: pylibmount and py3
Message-ID: <20130920110648.GA32348@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi,

 I have applied Ondrej's python3 support to pylibmount. It's possible
 to recompile the library with python2 as well as with python3.

 The ./configure script by default follows distribution and looks for
 "python" pkg-config module, you can override the default and use

   --with-python=2  or  --with-python=3

 then it looks for "python2" or "python3" pkg-config module.

 Please, test it with your distribution.

 Note that for example Fedora uses symlinks to redirect pkg-config
 from "python" to "python2" (the current Fedora default).

        /usr/lib64/pkgconfig/python-2.7.pc
        /usr/lib64/pkgconfig/python2.pc      -> python-2.7.pc
        /usr/lib64/pkgconfig/python-3.3m.pc  -> python-3.3.pc
        /usr/lib64/pkgconfig/python-3.3.pc
        /usr/lib64/pkgconfig/python3.pc      -> python-3.3.pc
        /usr/lib64/pkgconfig/python.pc       -> python2.pc


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
