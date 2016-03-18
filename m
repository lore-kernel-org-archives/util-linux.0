Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38125 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755009AbcCRN4x (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 18 Mar 2016 09:56:53 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 95D59627C3
	for <util-linux@vger.kernel.org>; Fri, 18 Mar 2016 13:56:52 +0000 (UTC)
Received: from ws (ovpn-204-89.brq.redhat.com [10.40.204.89])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u2IDupEf017882
	for <util-linux@vger.kernel.org>; Fri, 18 Mar 2016 09:56:52 -0400
Date: Fri, 18 Mar 2016 14:56:51 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: swapon test
Message-ID: <20160318135651.pgdl524chq47jqeh@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi,

 please, test swapon from git tree. I have rewritten Sami's changes to
 make it usable again... 
 
 (... I have to be more careful with review of his patches and he
  has to be more pessimistic with large changes and testing... :-)

 It also seems we need "swapon --all" regression test.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
