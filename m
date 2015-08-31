Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f44.google.com ([209.85.218.44]:36840 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298AbbHaCEu (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 30 Aug 2015 22:04:50 -0400
Received: by oibi18 with SMTP id i18so51480139oib.3
        for <util-linux@vger.kernel.org>; Sun, 30 Aug 2015 19:04:50 -0700 (PDT)
Received: from [192.168.0.75] (cpe-70-123-244-133.satx.res.rr.com. [70.123.244.133])
        by smtp.gmail.com with ESMTPSA id j2sm9523841obh.16.2015.08.30.19.04.48
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Aug 2015 19:04:49 -0700 (PDT)
Message-ID: <55E3B640.2060606@gmail.com>
Date: Sun, 30 Aug 2015 21:04:48 -0500
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: fdisk
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I have a question about (or a enhancement request) running fdisk.  When 
asking to list known partition types, I get about 70 lines of output. 
Generally that would not be a problem, but I was running in a Debian 
install/rescue iso that uses busybox in a 25 line terminal.  I do not 
have a way to scroll up and thus cannot see the first 40 or so partition 
types.

Is there a way to use a pager for this?  In this situation 'more' is 
available but 'less' is not.  Otherwise I think an automatic pause every 
20 lines or so would be appropriate to build into the partition type 
listing.

   -- Bruce Dubbs
