Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:16803 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774Ab1FIUcq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 9 Jun 2011 16:32:46 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p59KWkXW024758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Thu, 9 Jun 2011 16:32:46 -0400
Received: from nb (ovpn-113-80.phx2.redhat.com [10.3.113.80])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p59KWjwt029650
	for <util-linux@vger.kernel.org>; Thu, 9 Jun 2011 16:32:46 -0400
Date: Thu, 9 Jun 2011 22:32:44 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux <util-linux@vger.kernel.org>
Subject: heads up - move shlibs/*
Message-ID: <20110609203244.GA28907@nb.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi,

I have moved
    
  $(top_srcdir)/shlibs/{blkid,mount,uuid}
  
directories to the top-level directory, so we have 

  $(top_srcdir)/libblkid
  $(top_srcdir)/libmount
  $(top_srcdir)/libuuid

directories now. The "shlibs" directory does not exists anymore.

  git pull
  git clean -xfd

is probably a good choice...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
