Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57472 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755183AbbI3Mqk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 30 Sep 2015 08:46:40 -0400
Date: Wed, 30 Sep 2015 14:46:38 +0200
From: Karel Zak <kzak@redhat.com>
To: Werner Fink <werner@suse.de>, util-linux@vger.kernel.org
Subject: sulogin usemask
Message-ID: <20150930124638.GE1787@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



 Hi,

 https://github.com/systemd/systemd/pull/1399 this discussion
 highlights that the code around 'usemask' is not robust enough.

 The 'volatile' does not mean atomic. 
 
 It would be nice to improve the code -- avoid the mask at all, or use
 pthread_mutex_lock() (note that you can use mmaped shared memory for
 the muttex and share the lock between forked processes, you don't
 have to use threads).

 Comments?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
