Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33334 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730AbcEaQhx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 31 May 2016 12:37:53 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 561568AE73
	for <util-linux@vger.kernel.org>; Tue, 31 May 2016 16:37:53 +0000 (UTC)
Received: from ws (ovpn-204-89.brq.redhat.com [10.40.204.89])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u4VGbq6A021173
	for <util-linux@vger.kernel.org>; Tue, 31 May 2016 12:37:52 -0400
Date: Tue, 31 May 2016 18:37:51 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: cal(1) changes
Message-ID: <20160531163751.hllsomrqkechhtfz@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 I have committed two changes:

 * make it possible to specify month by name (according to locales)

    $ cal May 2017

 * accept timestamps / relative date

    $ cal '2 weeks ago'

    $ cal '+1year'

    $ cal 'tomorrow'

 We already have function to parse timestamps and I love it when use
 'git log --since', so why not use it for cal? (Note that timestamps
 are based on English and I think it's right thing (for KISS)).

 Comments?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
