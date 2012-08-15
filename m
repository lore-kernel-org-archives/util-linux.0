Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64975 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab2HOJIT convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 15 Aug 2012 05:08:19 -0400
Received: by bkwj10 with SMTP id j10so431985bkw.19
        for <util-linux@vger.kernel.org>; Wed, 15 Aug 2012 02:08:18 -0700 (PDT)
From: Andrea Bonomi <a.bonomi@endian.com>
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH 0/2] agetty: display network address in issue
Date: Wed, 15 Aug 2012 11:08:16 +0200
References: <2B6CF89C-6218-4289-B116-27108562664F@endian.com>
To: util-linux@vger.kernel.org
Message-Id: <BBDB2F27-F199-4F90-B393-569763011661@endian.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,
I developed a small patch for displaying the network address (IPv4 or IPv6) of a selected network interface in the agetty issue file.
The name of network interface (default eth0) can be configured through a command line option.
I use this feature on my virtual machines, so I can know the addresses without login. I hope this can be useful for someone else. 
Have a nice day,
Andrea Bonomi

:: e n d i a n
:: security with passion

:: andrea bonomi
:: senior software engineer
:: http://www.endian.com  :: a.bonomi@endian.com