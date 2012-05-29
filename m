Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:21635 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab2E2Nbp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 May 2012 09:31:45 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q4TDVjum008309
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 29 May 2012 09:31:45 -0400
Received: from x2 (ovpn-116-57.ams2.redhat.com [10.36.116.57])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q4TDVi8l022295
	for <util-linux@vger.kernel.org>; Tue, 29 May 2012 09:31:44 -0400
Date: Tue, 29 May 2012 15:31:43 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: no more --enable-login-utils
Message-ID: <20120529133143.GC374@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


  I have replaced --enable-login-utils with:

          --enable-vipw 
          --enable-newgrp 
          --enable-chfn-chsh
          --disable-login  
          --disable-sulogin
          --disable-su    

 so now we have fine-grained control on login utils. The login(1),
 sulogin(8) and su(1) are enabled by default.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
