Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58873 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877Ab2G0IKf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 27 Jul 2012 04:10:35 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q6R8AZob020508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 27 Jul 2012 04:10:35 -0400
Received: from x2 ([10.3.113.2])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q6R8AYBO028206
	for <util-linux@vger.kernel.org>; Fri, 27 Jul 2012 04:10:35 -0400
Date: Fri, 27 Jul 2012 10:10:33 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: v2.22-rc2 wish list
Message-ID: <20120727081033.GA14019@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 It would be nice to have:

  - fixed typos in docs, man pages, Release Notes, strings, ...
    (misspell-check)

  - regression tests for fdisk (see for example tests/ts/fdisk/sunlabel),
    it would be really nice to have tests for all labels with all
    basic operations (add, move, remove partitions, ...)

  - try to re-build tarball in your distro

  - test uuidd with systemd

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
