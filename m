Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34963 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbaDHHsw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Apr 2014 03:48:52 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s387mpSq017320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 8 Apr 2014 03:48:51 -0400
Received: from redhat.brq.redhat.com (unused-4-202.brq.redhat.com [10.34.4.202])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s387moTi004800
	for <util-linux@vger.kernel.org>; Tue, 8 Apr 2014 03:48:51 -0400
From: Ondrej Oprala <ooprala@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 00/10] Man page corrections v1.0
Date: Tue,  8 Apr 2014 09:48:39 +0200
Message-Id: <1396943329-22347-1-git-send-email-ooprala@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Just some minor man page corrections.

Ondrej Oprala (10):
  last: fix minor typos in the man page
  runuser: fix minor typos in the man page
  su: fix minor typos in the man page
  sulogin: minor man page improvements
  utmpdump: minor man page improvements
  nologin: minor man page improvements
  vipw: minor man page improvements
  addpart: minor man page improvements
  cfdisk: minor man page improvements
  delpart: minor man page improvements

 disk-utils/addpart.8   |  8 ++++----
 disk-utils/cfdisk.8    | 24 ++++++++++++------------
 disk-utils/delpart.8   |  2 +-
 login-utils/last.1     | 32 ++++++++++++++++----------------
 login-utils/nologin.8  | 10 +++++-----
 login-utils/runuser.1  | 28 ++++++++++++++--------------
 login-utils/su.1       | 20 ++++++++++----------
 login-utils/sulogin.8  |  2 +-
 login-utils/utmpdump.1 | 24 ++++++++++++------------
 login-utils/vipw.8     |  2 +-
 10 files changed, 76 insertions(+), 76 deletions(-)

-- 
1.8.5.1

