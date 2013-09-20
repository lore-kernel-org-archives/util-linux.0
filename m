Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56940 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754490Ab3ITLhg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 20 Sep 2013 07:37:36 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r8KBbaKB007436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 20 Sep 2013 07:37:36 -0400
Received: from x2.net.home (ovpn-113-22.phx2.redhat.com [10.3.113.22])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r8KBbZ2I008978
	for <util-linux@vger.kernel.org>; Fri, 20 Sep 2013 07:37:36 -0400
Date: Fri, 20 Sep 2013 13:37:34 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: v2.24 fdisk and libfdisk
Message-ID: <20130920113734.GB32348@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


I have merged libfdisk branch, changes:

    89 files changed, 8988 insertions(+), 7842 deletions(-)

  * complete refactoring (no more "if (label == FOO)" everywhere)
  * all label drivers (GPT, MBR, SUN, SGI and BSD) moved to libfdisk
  * output uses lib/tt.c
  * colors enabled by default
  * more readable help output ('m' command)
  * uses {M,G,T}iB (2^n) to print disk size
  * device properties (I/O limits, geometry) in all 'p'rint outputs
    for all labels
  * input (commands) should be backwardly compatible, but now it's
    case sensitive
  * all code uses the same alignment/geometry code
  * no more global variables

  * allows to edit GPT partition name and UUID (expert mode)
  * allows to edit GPT disk UUID (expert mode)

  * libfdisk API is not stable yet (planned for v2.25)
  * libfdisk.so is not distributed yet (planned for v2.25)



TODO:

  * (???) support hybrid GPT modification - now supported read-only
  
  * rewrite cfdisk to use the library

  * add support for pre-configured values to bypass dialogs to make
    it usable in programs like sfdisk (now all is driven by dialogs
    only)


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
