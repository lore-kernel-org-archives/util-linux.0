Return-Path: util-linux-owner@vger.kernel.org
Received: from prod-mail-xrelay02.akamai.com ([72.246.2.14]:37307 "EHLO
	prod-mail-xrelay02.akamai.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754262Ab3IYPaD (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 25 Sep 2013 11:30:03 -0400
Received: from prod-mail-xrelay02.akamai.com (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 5FF78284E8
	for <util-linux@vger.kernel.org>; Wed, 25 Sep 2013 15:21:16 +0000 (GMT)
Received: from prod-mail-relay02.akamai.com (prod-mail-relay02.akamai.com [172.17.50.21])
	by prod-mail-xrelay02.akamai.com (Postfix) with ESMTP id 4CC9A284E1
	for <util-linux@vger.kernel.org>; Wed, 25 Sep 2013 15:21:16 +0000 (GMT)
Received: from usma1ex-cashub.kendall.corp.akamai.com (usma1ex-cashub4.kendall.corp.akamai.com [172.27.105.20])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 41F2EFE055
	for <util-linux@vger.kernel.org>; Wed, 25 Sep 2013 15:21:16 +0000 (GMT)
Message-ID: <5242FF60.1030805@akamai.com>
Date: Wed, 25 Sep 2013 11:21:04 -0400
From: Matthew Horsfall <alh@akamai.com>
MIME-Version: 1.0
To: <util-linux@vger.kernel.org>
Subject: Possible security issue with mount()
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

I've discovered a possible security issue with mount and I was wondering 
where I should report it.

Thank you,

-- Matthew Horsfall (alh)
