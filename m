Return-Path: util-linux-owner@vger.kernel.org
Received: from outerface.net ([195.70.199.109]:60920 "EHLO outerface.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169Ab3DJK2E (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 10 Apr 2013 06:28:04 -0400
Received: from umbar.oktetlabs.ru ([188.134.5.200]:59838 helo=[192.168.38.110])
	by outerface.net with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mailbox@sergio.spb.ru>)
	id 1UPrxr-0002aT-PN
	for util-linux@vger.kernel.org; Wed, 10 Apr 2013 14:09:16 +0400
Message-ID: <51653A7F.8060807@sergio.spb.ru>
Date: Wed, 10 Apr 2013 14:10:07 +0400
From: sergio <mailbox@sergio.spb.ru>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: lscpu should show model name
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello.

Could you add model name field to the lscpu's output.
Like cat /proc/cpuinfo | grep 'model name'

-- 
sergio.
