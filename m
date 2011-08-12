Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:10825 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751546Ab1HLL6A (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 12 Aug 2011 07:58:00 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7CBw0AP003290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 12 Aug 2011 07:58:00 -0400
Received: from nb (ovpn-116-29.ams2.redhat.com [10.36.116.29])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p7CBvxF5031174
	for <util-linux@vger.kernel.org>; Fri, 12 Aug 2011 07:58:00 -0400
Date: Fri, 12 Aug 2011 13:57:59 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: PAM-only login(1)
Message-ID: <20110812115758.GC1843@nb.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


  I'd like to clean up login(1) code for v2.21. The current code is
  mess with many #ifdef and support for some unused (and badly tested) 
  features (e.g. non-PAM support for /etc/securetty and /etc/usertty).

  What about to finally create nice and readable PAM-only login(1) for
  Linux?

  The alternatives for systems without PAM are busybox and shadow-utils.

  Comments?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
