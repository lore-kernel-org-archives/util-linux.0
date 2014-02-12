Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f175.google.com ([209.85.214.175]:48680 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606AbaBLP33 (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Wed, 12 Feb 2014 10:29:29 -0500
Received: by mail-ob0-f175.google.com with SMTP id wn1so10596336obc.34
        for <util-linux-ng@vger.kernel.org>; Wed, 12 Feb 2014 07:29:28 -0800 (PST)
Received: from [192.168.0.75] (cpe-72-178-123-130.satx.res.rr.com. [72.178.123.130])
        by mx.google.com with ESMTPSA id ut2sm53525819obc.3.2014.02.12.07.29.26
        for <util-linux-ng@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Feb 2014 07:29:27 -0800 (PST)
Message-ID: <52FB9355.3090702@gmail.com>
Date: Wed, 12 Feb 2014 09:29:25 -0600
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: util-linux-ng@vger.kernel.org
Subject: findmnt/df discrepancy
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I've noticed a discrepancy in percent free between findmnt and df:

$ df -h|grep /tmp
/dev/sdb5        9.8G  8.3G  967M  90% /tmp
$ findmnt --df|grep /tmp
/dev/sdb5  ext4  9.7G  8.3G  967M  85% /tmp

Actually, the discrepancy seems to be df as 8.3/9.8 is 84.7%.
Can anyone here explain the difference?  Should it be submitted to 
coreutils as a bug?

   -- Bruce
