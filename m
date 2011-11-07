Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:62003 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753232Ab1KGKeC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Nov 2011 05:34:02 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pA7AY2Yc003330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Mon, 7 Nov 2011 05:34:02 -0500
Received: from nb (ovpn-116-34.ams2.redhat.com [10.36.116.34])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id pA7AY0MW030804
	for <util-linux@vger.kernel.org>; Mon, 7 Nov 2011 05:34:01 -0500
Date: Mon, 7 Nov 2011 11:34:00 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: build system changes
Message-ID: <20111107103400.GD25410@nb.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi,

I just pushed build-system changes:

 - clean up AC macro names and move all macros to m4/ul.m4

 - add macros (UL_REQUIRES_*) to maintain dependencies between components (e.g.
   mountpoint(1) requires libmount)


and some developers oriented changes:

 - add a new script tools/config-gen to call ./configure script with
   predefined set of options (defined in tools/config-gen.d/), for example:

        ./tools/config-gen all

   will enable all possible utils

        ./tools/config-gen devel non-nls selinux  

   will enable all possible utils, devel options, selinux support and
   disable NLS.

   Note, it's NOT expected that end-users or downstream will use the
   config-gen script. This script is for developers only.

 - add build-system regression test (based on tools/config-gen), note
   that the test is not enabled by default, you have to use:

        ./tests/run.sh build-sys --force


See Documentation/howto-build-sys.txt for more details.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
